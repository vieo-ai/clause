# scripts/cli/nu/commands/pkg/_default.nu
# Package Management Namespace Help (`cx pkg`)

def main [...args: string] {
    print $"(ansi cyan_bold)ClauseOS Workbench — Hermetic Package Manager \(cx pkg\)(ansi reset)"
    print "Usage: cx pkg:<command> [...args]\n"

    print $"(ansi yellow_bold)Commands:(ansi reset)"
    print $"  • (ansi green)cx pkg:add(ansi reset) <mise|scoop|brew>:<pkg[@ver]> [--target (-e) <overlay>]"
    print "      Unified package installer (defaults to mise: backend if omitted)"
    print $"  • (ansi green)cx pkg:mise(ansi reset) <subcommand> [...args] [--env (-e) <overlay>]"
    print "      Hermetic Mise CLI wrapper (blocks -g / --global; auto-pins on install/use)"
    print $"  • (ansi green)cx pkg:scoop(ansi reset) <subcommand> [...args] [--env (-e) <overlay>]"
    print "      Hermetic Scoop CLI wrapper for Windows (blocks -g / --global; auto-pins on install)"
    print $"  • (ansi green)cx pkg:brew(ansi reset) <subcommand> [...args] [--env (-e) <overlay>]"
    print "      Hermetic Homebrew CLI wrapper for POSIX (blocks --cask; auto-pins on install)\n"

    print $"(ansi yellow_bold)Examples:(ansi reset)"
    print "  cx pkg:add ripgrep -e dev"
    print "  cx pkg:add scoop:jq --target core"
    print "  cx pkg:mise install node@22"
    print "  cx pkg:scoop install fd"
    print "  cx pkg:brew install gh"
}