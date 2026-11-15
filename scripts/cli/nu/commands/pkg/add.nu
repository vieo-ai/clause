# scripts/cli/nu/commands/add.nu
# Unified package installer: `cx add <mise|scoop|brew>:<pkg[@ver]> [--target (-e) <overlay>]`

use ../../core/toml_pin.nu [pin-bootstrap-pkg]

def main [
    spec: string,
    --target (-e): string = ""
] {
    let parsed = if ($spec | str contains ":") {
        let parts = ($spec | split row ":" -n 2)
        { backend: ($parts | get 0 | str lowercase), target: ($parts | get 1) }
    } else {
        { backend: "mise", target: $spec }
    }

    let is_win = (($nu.os-info.name | str lowercase) == "windows")
    let mise_bin = ($env.CLAUSE_BIN_DIR | path join (if $is_win { "mise.exe" } else { "mise" }))
    let mod_nu = ($env.CLAUSE_PROJECT_ROOT | path join "scripts" "cli" "nu" "mod.nu")
    let nu_bin = $nu.current-exe

    match $parsed.backend {
        "mise" => {
            ^$mise_bin use --pin $parsed.target
            let pkg_name = ($parsed.target | split row "@" | get 0)
            let ver = (^$mise_bin current $pkg_name | str trim)
            pin-bootstrap-pkg "mise" $pkg_name $ver {} [] $target
        }
        "scoop" => {
            if ($target | is-not-empty) {
                ^$nu_bin $mod_nu scoop install $parsed.target --env $target
            } else {
                ^$nu_bin $mod_nu scoop install $parsed.target
            }
        }
        "brew" => {
            if ($target | is-not-empty) {
                ^$nu_bin $mod_nu brew install $parsed.target --env $target
            } else {
                ^$nu_bin $mod_nu brew install $parsed.target
            }
        }
        _ => {
            error make { msg: $"[ClauseOS] Unsupported package backend '($parsed.backend)'. Use mise:, scoop:, or brew:." }
        }
    }
}