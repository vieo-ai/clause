# scripts/cli/nu/core/toml_pin.nu
# Reads & updates [bootstrap.packages] and [env] in .mise.<env>.toml

export def resolve-target-manifest [target_env?: string] {
    let root = $env.CLAUSE_PROJECT_ROOT
    let env_name = if ($target_env | is-not-empty) {
        $target_env
    } else if ($env.MISE_ENV? | is-not-empty) {
        ($env.MISE_ENV | split row "," | last | str trim)
    } else {
        "local"
    }
    $root | path join $".mise.($env_name).toml"
}

export def pin-bootstrap-pkg [
    manager: string,
    pkg: string,
    version: string,
    extra_env?: record,
    extra_paths?: list<string>,
    target_env?: string
] {
    let toml_path = (resolve-target-manifest $target_env)
    mut doc = if ($toml_path | path exists) { open $toml_path } else { {} }

    # Pin under [bootstrap.packages]
    let boot = ($doc | get -o bootstrap | default {})
    let pkgs = ($boot | get -o packages | default {} | upsert $"($manager):($pkg)" $version)
    $doc = ($doc | upsert bootstrap ($boot | upsert packages $pkgs))

    # Merge any Scoop manifest env_set / env_add_path into [env]
    mut env_tbl = ($doc | get -o env | default {})
    if ($extra_env | is-not-empty) {
        for kv in ($extra_env | transpose k v) {
            $env_tbl = ($env_tbl | upsert $kv.k $kv.v)
        }
    }
    if ($extra_paths | is-not-empty) {
        let cur = ($env_tbl | get -o "_.path" | default [])
        $env_tbl = ($env_tbl | upsert "_.path" ($cur | append $extra_paths | uniq))
    }
    if not ($env_tbl | is-empty) {
        $doc = ($doc | upsert env $env_tbl)
    }

    $doc | to toml | save -f $toml_path
    print $"(ansi cyan)[ClauseOS](ansi reset) Pinned ($manager):($pkg) = \"($version)\" -> ($toml_path | path basename)"
}