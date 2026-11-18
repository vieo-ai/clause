# scripts/cli/nu/commands/bundle.nu
# ClauseOS Source Bundle & PDF Exporter (`cx bundle [--out <path>] [--pdf]`)
# Packs all git-tracked source files, ADRs, TOML configs, and scripts into a single
# Markdown document with syntax-highlighted code blocks ready for PDF printing.

export def main [
    --out (-o): string = ""          # Output Markdown path (defaults to .home/.cache/exports/clauseos-source-bundle.md)
    --pdf                            # Also attempt direct PDF conversion via pandoc/typst/weasyprint
    --include-docs                   # Include docs/ markdown files alongside source code (default: true)
] {
    let root = ($env.CLAUSE_PROJECT_ROOT? | default (pwd))
    let cache_dir = ($env.CLAUSE_CACHE_DIR? | default ($root | path join ".home" ".cache"))
    let export_dir = ($cache_dir | path join "exports")
    mkdir $export_dir

    let out_md = if ($out | is-not-empty) {
        $out
    } else {
        $export_dir | path join "clauseos-source-bundle.md"
    }

    print $"(ansi cyan)[ClauseOS Bundle](ansi reset) Scanning tracked repository files in ($root)..."

    # Collect git-tracked files cleanly (falls back to glob if not a git checkout)
    let tracked_files = if (($root | path join ".git") | path exists) {
        cd $root
        (^git ls-files | lines | where {|f| ($f | str trim) != "" })
    } else {
        glob $"($root)/**/*"
        | where {|p| ($p | path type) == "file" }
        | each {|p| $p | path relative-to $root }
    }

    # Filter out binary assets, lockfiles, and .home/ artifacts
    let skip_exts = [
        "png" "jpg" "jpeg" "gif" "webp" "ico" "svg" "pdf" "zip" "tar" "gz" "7z"
        "exe" "dll" "so" "dylib" "beam" "wasm" "vhdx" "qcow2" "iso" "lock" "woff" "woff2" "ttf"
    ]

    let source_files = (
        $tracked_files
        | where {|rel|
            let norm = ($rel | str replace -a "\\" "/")
            let ext = ($norm | path parse | get extension | str lowercase)
            let is_hidden_state = ($norm | str starts-with ".home/")
            let is_bin = ($ext in $skip_exts) or ($norm | str ends-with "Cargo.lock") or ($norm | str ends-with "manifest.lock")
            (not $is_hidden_state) and (not $is_bin) and (($root | path join $rel) | path exists)
        }
        | sort
    )

    let timestamp = (date now | format date "%Y-%m-%d %H:%M:%S %Z")
    let file_count = ($source_files | length)

    # Build Header & Table of Contents
    mut sections = [
        "# ClauseOS Complete Source & Architecture Bundle"
        ""
        $"> **Generated:** ($timestamp)  "
        $"> **Tracked Files Included:** ($file_count)"
        ""
        "## Table of Contents"
        ""
    ]

    for rel in $source_files {
        let anchor = ($rel | str lowercase | str replace -a "/" "" | str replace -a "." "" | str replace -a "_" "-")
        $sections = ($sections | append $"- [`($rel)`]\(#($anchor)\)")
    }

    $sections = ($sections | append ["", "---", ""])

    # Append each file with an appropriate fenced code block
    for rel in $source_files {
        let full_path = ($root | path join $rel)
        let ext = ($rel | path parse | get extension | str lowercase)
        let base = ($rel | path basename | str lowercase)
        let lang = (map-fence-lang $ext $base)

        let raw_content = (try {
            open --raw $full_path | decode utf-8
        } catch {
            "[Binary or non-UTF8 file skipped]"
        })

        # Use 4 backticks if the file itself contains triple backticks (e.g. Markdown ADRs)
        let fence = if ($raw_content | str contains "```") { "````" } else { "```" }

        $sections = ($sections | append [
            $"## `($rel)`"
            ""
            $"($fence)($lang)"
            ($raw_content | str trim --right)
            $fence
            ""
        ])
    }

    let final_md = ($sections | str join "\n")
    $final_md | save -f $out_md
    print $"(ansi green)[ClauseOS Bundle](ansi reset) Wrote ($file_count) files -> ($out_md)"

    if $pdf {
        let out_pdf = ($out_md | str replace -r '\.md$' '.pdf')
        if (which pandoc | is-not-empty) {
            print $"(ansi cyan)[ClauseOS Bundle](ansi reset) Rendering PDF via pandoc -> ($out_pdf)..."
            let pdf_engine = if (which typst | is-not-empty) {
                "typst"
            } else if (which weasyprint | is-not-empty) {
                "weasyprint"
            } else if (which wkhtmltopdf | is-not-empty) {
                "wkhtmltopdf"
            } else {
                ""
            }

            if ($pdf_engine | is-not-empty) {
                ^pandoc $out_md -o $out_pdf --pdf-engine=$pdf_engine -V geometry:margin=0.6in
                print $"(ansi green)[ClauseOS Bundle](ansi reset) PDF ready -> ($out_pdf)"
            } else {
                print $"(ansi yellow)[ClauseOS Bundle](ansi reset) pandoc found, but no PDF engine (typst/weasyprint/wkhtmltopdf) installed. Open ($out_md) in VS Code or browser and Print -> Save as PDF."
            }
        } else {
            print $"(ansi yellow)[ClauseOS Bundle](ansi reset) Open ($out_md) in VS Code Markdown Preview or Chrome/Edge and press Ctrl+P -> Save as PDF."
        }
    }
}

def map-fence-lang [ext: string, base: string] {
    match $ext {
        "nu" => "nushell"
        "ps1" | "psm1" | "psd1" => "powershell"
        "sh" | "bash" | "zsh" => "bash"
        "bat" | "cmd" => "batch"
        "toml" => "toml"
        "yaml" | "yml" => "yaml"
        "json" => "json"
        "rs" => "rust"
        "gleam" => "gleam"
        "erl" | "hrl" => "erlang"
        "ex" | "exs" => "elixir"
        "lua" => "lua"
        "hcl" | "tf" => "hcl"
        "ts" | "tsx" => "typescript"
        "js" | "jsx" => "javascript"
        "py" => "python"
        "md" => "markdown"
        "cx" | "seax" => "dart"
        _ => {
            if $base == "dockerfile" { "dockerfile" } else { "text" }
        }
    }
}