# scripts/cli/pwsh/installers/installer_scoop.ps1
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$Version,
    [Parameter(Mandatory = $false)]
    [string]$ProjectRoot
)

$ErrorActionPreference = 'Stop'

# Only run on Windows NT
if (-not $IsOSWindows) { return }

# Consume canonical SSOT variables from config/env/00-core.toml & 20-toolchains.toml
$LocalBin        = if ($env:CLAUSE_BIN_DIR)    { $env:CLAUSE_BIN_DIR }    else { Join-Path $env:LOCALAPPDATA "Programs\bin" }
$ScoopDir        = if ($env:SCOOP)             { $env:SCOOP }             else { Join-Path $env:CLAUSE_CACHE_DIR "toolchain\scoop" }
$ConfigRoot      = if ($env:CLAUSE_CONFIG_DIR) { $env:CLAUSE_CONFIG_DIR } else { Join-Path $env:LOCALAPPDATA "config" }
$ScoopConfigDir  = Join-Path $ConfigRoot "scoop"
$ScoopConfigFile = Join-Path $ScoopConfigDir "config.json"
$EnvHelperPs1    = Join-Path $ScoopConfigDir "environment.ps1"
$ScoopCoreScript = Join-Path $ScoopDir "apps\scoop\current\bin\scoop.ps1"
$ScoopBinTarget  = Join-Path $LocalBin "scoop.cmd"
$PatchMarker     = "# clause-scoop-patches: 1"

# Ensure hermetic config directory exists inside CLAUSE_CONFIG_DIR
if (-not (Test-Path -LiteralPath $ScoopConfigDir)) {
    New-Item -ItemType Directory -Path $ScoopConfigDir -Force | Out-Null
}

if (-not (Test-Path -LiteralPath $ScoopConfigFile)) {
    @{
        create_startmenu_shortcut = $false
        show_update_log           = $false
    } | ConvertTo-Json | Set-Content -LiteralPath $ScoopConfigFile -Encoding UTF8
}

# Write Vegard IT registry-free hook & HKCU PATH guard into CLAUSE_CONFIG_DIR\scoop\environment.ps1
$EnvironmentGuardCode = @'
$script:ScoopPortableSearchPaths = @('PKG_CONFIG_PATH', 'CMAKE_PREFIX_PATH')

function Save-ScoopPortableUserPath([string]$SnapshotFile, [string]$RegistrySubKey = 'Environment') {
    $ErrorActionPreference = 'Stop'
    $key = [Microsoft.Win32.Registry]::CurrentUser.OpenSubKey($RegistrySubKey)
    $snapshot = @{ exists = $false; kind = $null; value = $null }
    try {
        if ($key -and ($key.GetValueNames() -contains 'Path')) {
            $snapshot.exists = $true
            $snapshot.kind = $key.GetValueKind('Path').ToString()
            if ($snapshot.kind -notin 'String', 'ExpandString') { throw 'User PATH has an unsupported registry type' }
            $snapshot.value = $key.GetValue('Path', $null, 'DoNotExpandEnvironmentNames')
        }
    } finally {
        if ($key) { $key.Dispose() }
    }
    $stream = [IO.File]::Open($SnapshotFile, 'CreateNew', 'Write', 'None')
    $writer = $null
    try {
        $writer = [IO.StreamWriter]::new($stream, [Text.Encoding]::Unicode)
        $writer.Write(($snapshot | ConvertTo-Json -Compress))
    } finally {
        if ($writer) { $writer.Dispose() } else { $stream.Dispose() }
    }
}

function Restore-ScoopPortableUserPath([string]$SnapshotFile, [string]$RegistrySubKey = 'Environment') {
    $ErrorActionPreference = 'Stop'
    Set-StrictMode -Version Latest
    $snapshot = Get-Content -LiteralPath $SnapshotFile -Raw -Encoding Unicode | ConvertFrom-Json
    if ($snapshot.exists -isnot [bool] -or ($snapshot.exists -and
        ($snapshot.kind -notin 'String', 'ExpandString' -or $snapshot.value -isnot [string]))) {
        throw 'Invalid user PATH snapshot'
    }
    $key = [Microsoft.Win32.Registry]::CurrentUser.OpenSubKey($RegistrySubKey)
    try {
        $exists = $key -and ($key.GetValueNames() -contains 'Path')
        if ($snapshot.exists -eq $exists -and (-not $exists -or
            ($snapshot.kind -eq $key.GetValueKind('Path').ToString() -and
            [string]::Equals($snapshot.value, $key.GetValue('Path', $null, 'DoNotExpandEnvironmentNames'), 'Ordinal')))) {
            return $false
        }
    } finally {
        if ($key) { $key.Dispose() }
    }
    $key = [Microsoft.Win32.Registry]::CurrentUser.CreateSubKey($RegistrySubKey)
    try {
        if ($snapshot.exists) { $key.SetValue('Path', $snapshot.value, [Microsoft.Win32.RegistryValueKind]$snapshot.kind) }
        else { $key.DeleteValue('Path', $false) }
    } finally {
        $key.Dispose()
    }
    return $true
}
'@
Set-Content -LiteralPath $EnvHelperPs1 -Value $EnvironmentGuardCode -Encoding UTF8 -NoNewline

# In-place runtime patcher for Scoop core libraries
function Invoke-ClauseScoopPatch {
    param([string]$TargetScoopDir)

    $appRoot = Join-Path $TargetScoopDir "apps\scoop\current"
    $libDir  = Join-Path $appRoot "lib"
    $sysPs1  = Join-Path $libDir "system.ps1"
    if (-not (Test-Path -LiteralPath $sysPs1)) {
        throw "Cannot patch Scoop: missing $sysPs1"
    }

    # 1. lib/core.ps1: anchor Scoop config lookup strictly to CLAUSE_CONFIG_DIR
    $corePs1 = Join-Path $libDir "core.ps1"
    if (Test-Path -LiteralPath $corePs1) {
        $old = Get-Content -LiteralPath $corePs1 -Raw
        $new = $old.Replace('$env:XDG_CONFIG_HOME', '"$env:CLAUSE_CONFIG_DIR"')
        if ($old -ne $new) { Set-Content -LiteralPath $corePs1 -Value $new -NoNewline }
    }

    # 2. lib/shortcuts.ps1: suppress Start Menu shortcut creation
    $shortcutsPs1 = Join-Path $libDir "shortcuts.ps1"
    if (Test-Path -LiteralPath $shortcutsPs1) {
        $old = $new = Get-Content -LiteralPath $shortcutsPs1 -Raw
        foreach ($fn in @(
            'function create_startmenu_shortcuts($manifest, $dir, $global, $arch) { }',
            'function startmenu_shortcut([System.IO.FileInfo] $target, $shortcutName, $arguments, [System.IO.FileInfo]$icon, $global) { }'
        )) {
            if (-not $new.Contains($fn)) { $new += "`n$fn`n" }
        }
        if ($old -ne $new) { Set-Content -LiteralPath $shortcutsPs1 -Value $new -NoNewline }
    }

    # 3. libexec/scoop-import.ps1: block Scoopfiles marked 'Global install'
    $importPs1 = Join-Path $appRoot "libexec\scoop-import.ps1"
    if (Test-Path -LiteralPath $importPs1) {
        $old = Get-Content -LiteralPath $importPs1 -Raw
        $anchor = 'foreach ($item in $import.config.PSObject.Properties) {'
        $guard  = "foreach (`$portableApp in `$import.apps) { if ('Global install' -in (`$portableApp.Info -split ', ')) { throw `"ClauseOS: Cannot import global app `$(`$portableApp.Name)`" } }`n"
        if ($old.Contains($anchor) -and -not $old.Contains("Cannot import global app")) {
            Set-Content -LiteralPath $importPs1 -Value $old.Replace($anchor, $guard + $anchor) -NoNewline
        }
    }

    # 4. lib/system.ps1: override Set-EnvVar as a no-op (zero HKCU registry writes) + patch marker
    $old = $new = Get-Content -LiteralPath $sysPs1 -Raw
    foreach ($line in @(
        'function Set-EnvVar { param([string]$Name, [string]$Value, [switch]$Global) }',
        $PatchMarker
    )) {
        if (-not $new.Contains($line)) { $new += "`n$line`n" }
    }
    if ($old -ne $new) { Set-Content -LiteralPath $sysPs1 -Value $new -NoNewline }
}

# Pre-seed Scoop into $env:SCOOP if not yet installed
if (-not (Test-Path -LiteralPath $ScoopCoreScript)) {
    Write-ClauseLog "Pre-seeding Hermetic Scoop into $ScoopDir..." -Level INFO
    $RawInstaller     = Join-Path $env:CLAUSE_TEMP_DIR "install_scoop_raw.ps1"
    $PatchedInstaller = Join-Path $env:CLAUSE_TEMP_DIR "install_scoop_hermetic.ps1"

    try {
        Get-File -Url 'https://get.scoop.sh' -OutFile $RawInstaller
        $ScriptText = (Get-Content -LiteralPath $RawInstaller -Raw).
            Replace('$env:XDG_CONFIG_HOME', '"$env:CLAUSE_CONFIG_DIR"').
            Replace('(Test-Path "$SCOOP_DIR\*")', '$false') -replace '\s\s+Add-ShimsDirToPath', ''

        Set-Content -LiteralPath $PatchedInstaller -Value $ScriptText -Encoding UTF8 -NoNewline
        & $PatchedInstaller -ScoopDir "$ScoopDir" -NoPath
        Write-ClauseLog "Scoop pre-seeded successfully." -Level INFO
    } catch {
        Write-ClauseLog "Failed to install Scoop: $_" -Level FATAL
        throw "[ClauseOS Stage 2] Error: Failed to install Scoop: $_"
    } finally {
        Remove-Item -LiteralPath $RawInstaller, $PatchedInstaller -Force -ErrorAction SilentlyContinue
    }
}

# Apply runtime patches if missing or overwritten
$SysContent = Get-Content -LiteralPath (Join-Path $ScoopDir "apps\scoop\current\lib\system.ps1") -Raw -ErrorAction SilentlyContinue
if (-not $SysContent -or -not $SysContent.Contains($PatchMarker)) {
    Write-ClauseLog "Applying hermetic runtime patches to Scoop..." -Level INFO
    Invoke-ClauseScoopPatch -TargetScoopDir $ScoopDir
}

# Wire $env:CLAUSE_BIN_DIR\scoop.cmd directly into the ClauseOS CLI (`cx scoop`)
$ShimContent = @"
@echo off
cx scoop %*
"@
Set-Content -LiteralPath $ScoopBinTarget -Value $ShimContent -Encoding ASCII
Write-ClauseLog "Hermetic Scoop shim wired at $ScoopBinTarget -> cx scoop" -Level INFO