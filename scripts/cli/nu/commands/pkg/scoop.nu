# scripts/cli/nu/commands/scoop.nu
# Hijacked Scoop CLI (`cx scoop` and `$CLAUSE_BIN_DIR/scoop.cmd`)

use ../../core/toml_pin.nu [pin-bootstrap-pkg]

def --wrapped main [...args: string] {
    if (($nu.os-info.name | str lowercase) != "windows") {
        error make { msg: "[ClauseOS] `cx scoop` is only supported on Windows." }
    }

    # Parse optional --env / -e flag safely even when $args is empty
    mut target_env = ""
    mut clean_args = []
    mut skip = false
    if ($args | is-not-empty) {
        for i in 0..(($args | length) - 1) {
            if $skip { $skip = false; continue }
            let a = ($args | get $i)
            if (($a == "--env") or ($a == "-e")) and (($i + 1) < ($args | length)) {
                $target_env = ($args | get ($i + 1))
                $skip = true
            } else {
                $clean_args = ($clean_args | append $a)
            }
        }
    }

    let cmd = ($clean_args | first | default "" | str lowercase)
    if ($cmd == "install") and ($clean_args | any {|a| ($a == "--global") or ($a =~ '^-[^-]*g') }) {
        error make { msg: "[ClauseOS] Global Scoop installs (-g / --global) are forbidden." }
    }

    let scoop_dir  = $env.SCOOP
    let scoop_main = ($scoop_dir | path join "apps" "scoop" "current" "bin" "scoop.ps1")
    let env_helper = ($env.CLAUSE_CONFIG_DIR | path join "scoop" "environment.ps1")

    if not ($scoop_main | path exists) {
        error make { msg: $"[ClauseOS] Hermetic Scoop not found at ($scoop_dir). Run cx bootstrap first." }
    }

    let pwsh_bin = ($env.CLAUSE_BIN_DIR | path join "pwsh.exe")
    let pwsh = if ($pwsh_bin | path exists) { $pwsh_bin } else if (which pwsh | is-not-empty) { "pwsh" } else { "powershell" }

    let template = '
        $ErrorActionPreference = "Stop"
        $ScoopRoot   = "__SCOOP_DIR__"
        $ScoopMain   = "__SCOOP_MAIN__"
        $EnvHelper   = "__ENV_HELPER__"
        $Cmd         = "__CMD__"
        $PatchMarker = "# clause-scoop-patches: 1"

        if (Test-Path -LiteralPath $EnvHelper) { . $EnvHelper }

        # Re-apply runtime patches if Scoop updated itself
        $libDir = Join-Path $ScoopRoot "apps\scoop\current\lib"
        $sysPs1 = Join-Path $libDir "system.ps1"
        if (-not (Get-Content -LiteralPath $sysPs1 -Raw).Contains($PatchMarker)) {
            $corePs1 = Join-Path $libDir "core.ps1"
            if (Test-Path $corePs1) {
                $c = (Get-Content -LiteralPath $corePs1 -Raw).Replace("$env:XDG_CONFIG_HOME", "`"$env:CLAUSE_CONFIG_DIR`"")
                Set-Content -LiteralPath $corePs1 -Value $c -NoNewline
            }
            $shortPs1 = Join-Path $libDir "shortcuts.ps1"
            if (Test-Path $shortPs1) {
                $s = (Get-Content -LiteralPath $shortPs1 -Raw) + "`nfunction create_startmenu_shortcuts($manifest, $dir, $global, $arch) { }`nfunction startmenu_shortcut([System.IO.FileInfo] $target, $shortcutName, $arguments, [System.IO.FileInfo]$icon, $global) { }`n"
                Set-Content -LiteralPath $shortPs1 -Value $s -NoNewline
            }
            $sysNew = (Get-Content -LiteralPath $sysPs1 -Raw) + "`nfunction Set-EnvVar { param([string]$Name, [string]$Value, [switch]$Global) }`n$PatchMarker`n"
            Set-Content -LiteralPath $sysPs1 -Value $sysNew -NoNewline
        }

        # Snapshot HKCU\Environment\Path in memory before updates
        $pathSnap = $null
        if ($Cmd -eq "update" -and (Get-Command Save-ScoopPortableUserPath -ErrorAction SilentlyContinue)) {
            $pathSnap = Join-Path $env:CLAUSE_TEMP_DIR ("scoop-path-" + [guid]::NewGuid().ToString("N") + ".json")
            Save-ScoopPortableUserPath -SnapshotFile $pathSnap
        }

        try {
            & $ScoopMain @args
            $rc = $LASTEXITCODE
        } finally {
            if ($pathSnap -and (Test-Path -LiteralPath $pathSnap)) {
                Restore-ScoopPortableUserPath -SnapshotFile $pathSnap | Out-Null
                Remove-Item -LiteralPath $pathSnap -Force -ErrorAction SilentlyContinue
            }
        }
        exit $rc
    '

    let runner = ($template
        | str replace "__SCOOP_DIR__" $scoop_dir
        | str replace "__SCOOP_MAIN__" $scoop_main
        | str replace "__ENV_HELPER__" $env_helper
        | str replace "__CMD__" $cmd
    )

    # Write transient runner script inside CLAUSE_TEMP_DIR and execute via -File so $args forwards verbatim
    let runner_file = ($env.CLAUSE_TEMP_DIR | path join $"clause-scoop-(random uuid).ps1")
    $runner | save -f $runner_file
    try {
        ^$pwsh -NoProfile -ExecutionPolicy Bypass -File $runner_file ...$clean_args
    } finally {
        if ($runner_file | path exists) { rm -f $runner_file }
    }

    # On `install`, pin resolved version & manifest env_set/env_add_path into .mise.<env>.toml
    if ($cmd == "install") {
        let pkg_args = ($clean_args | skip 1 | where {|a| not ($a | str starts-with "-") })
        for raw_pkg in $pkg_args {
            let pkg_name = ($raw_pkg | split row "/" | last | split row "@" | get 0)
            let app_cur = ($scoop_dir | path join "apps" $pkg_name "current")
            let m_new = ($app_cur | path join "scoop-manifest.json")
            let m_old = ($app_cur | path join "manifest.json")
            let m_path = if ($m_new | path exists) { $m_new } else { $m_old }

            if ($m_path | path exists) {
                let manifest = (open $m_path)
                let ver = ($manifest | get version)
                let app_var = $"{{ env.SCOOP }}/apps/($pkg_name)/current"
                let persist_var = $"{{ env.SCOOP }}/persist/($pkg_name)"

                mut app_env = {}
                let raw_env = ($manifest | get -o env_set | default {})
                for kv in ($raw_env | transpose k v) {
                    let expanded = ($kv.v | str replace --all "$dir" $app_var | str replace --all "$persist_dir" $persist_var)
                    $app_env = ($app_env | upsert $kv.k $expanded)
                }

                let raw_paths = ($manifest | get -o env_add_path | default [])
                let path_list = if ($raw_paths | describe | str starts-with "string") { [$raw_paths] } else { $raw_paths }
                let resolved_paths = ($path_list | each {|p|
                    if ($p == ".") { $app_var } else { $"($app_var)/($p)" }
                })

                pin-bootstrap-pkg "scoop" $pkg_name $ver $app_env $resolved_paths $target_env
            }
        }
    }
}