# scripts/cli/nu/commands/pkg/mise.nu
# Hijacked Mise CLI (`cx pkg:mise`)

use ../../core/toml_pin.nu [pin-bootstrap-pkg]

def --wrapped main [...args: string] {
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
    if ($cmd in ["install", "use", "uninstall", "rm"]) and ($clean_args | any {|a| ($a == "--global") or ($a =~ '^-[^-]*g') }) {
        error make { msg: "[ClauseOS] Global Mise flags (-g / --global) are forbidden." }
    }

    let is_win = (($nu.os-info.name | str lowercase) == "windows")
    let mise_name = if $is_win { "mise.exe" } else { "mise" }
    let mise_bin = ($env.CLAUSE_BIN_DIR | path join $mise_name)

    if not ($mise_bin | path exists) {
        error make { msg: $"[ClauseOS] Hermetic Mise not found at ($mise_bin)." }
    }

    ^$mise_bin ...$clean_args

    # On `install` or `use`, pin resolved tool version into .mise.<env>.toml
    if ($cmd in ["install", "use"]) {
        let pkg_args = ($clean_args | skip 1 | where {|a| not ($a | str starts-with "-") })
        for raw_pkg in $pkg_args {
            let tool_spec = ($raw_pkg | split row "@" | get 0)
            let resolved_ver = (^$mise_bin current $tool_spec | str trim)
            if ($resolved_ver | is-not-empty) {
                pin-bootstrap-pkg "mise" $tool_spec $resolved_ver {} [] $target_env
            }
        }
    }
}