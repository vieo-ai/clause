# scripts/cli/nu/commands/add.nu
# Unified package installer: `cx add <mise|scoop|brew>:<pkg[@ver]> [--env <overlay>]`

use ../core/toml_pin.nu [pin-bootstrap-pkg]

def main [
    spec: string,
    --env (-e): string = ""
] {
    let parsed = if ($spec | str contains ":") {
        let parts = ($spec | split row ":" -n 2)
        { backend: ($parts | get 0 | str lowercase), target: ($parts | get 1) }
    } else {
        { backend: "mise", target: $spec }
    }

    let is_win = (($nu.os-info.name | str lowercase) == "windows")
    let mise_bin = ($env.CLAUSE_BIN_DIR | path join (if $is_win { "mise.exe" } else { "mise" }))

    match $parsed.backend {
        "mise" => {
            ^$mise_bin use --pin $parsed.target
            let pkg_name = ($parsed.target | split row "@" | get 0)
            let ver = (^$mise_bin current $pkg_name | str trim)
            pin-bootstrap-pkg "mise" $pkg_name $ver {} [] $env
        }
        "scoop" => {
            clause scoop install $parsed.target --env $env
        }
        "brew" => {
            clause brew install $parsed.target --env $env
        }
        _ => {
            error make { msg: $"[ClauseOS] Unsupported package backend '($parsed.backend)'. Use mise:, scoop:, or brew:." }
        }
    }
}