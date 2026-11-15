# scripts/cli/nu/commands/brew.nu
# Hijacked Homebrew CLI (`cx brew`)

use ../../core/toml_pin.nu [pin-bootstrap-pkg]

def --wrapped main [...args: string] {
    if (($nu.os-info.name | str lowercase) == "windows") {
        error make { msg: "[ClauseOS] `cx brew` is only supported on POSIX (macOS/Linux)." }
    }

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
    if ($cmd == "install") and ($clean_args | any {|a| $a == "--cask" }) {
        error make { msg: "[ClauseOS] Homebrew --cask installs are forbidden in ClauseOS." }
    }

    let brew_bin = ($env.HOMEBREW_PREFIX | path join "bin" "brew")
    if not ($brew_bin | path exists) {
        error make { msg: $"[ClauseOS] Hermetic Homebrew not found at ($env.HOMEBREW_PREFIX)." }
    }

    ^$brew_bin ...$clean_args

    if ($cmd == "install") {
        let pkg_args = ($clean_args | skip 1 | where {|a| not ($a | str starts-with "-") })
        for raw_pkg in $pkg_args {
            let pkg_name = ($raw_pkg | split row "/" | last | split row "@" | get 0)
            let info = (^$brew_bin info --json=v2 $pkg_name | from json)
            let ver = ($info.formulae | first | get versions.stable)
            pin-bootstrap-pkg "brew" $pkg_name $ver {} [] $target_env
        }
    }
}