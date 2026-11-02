# Create a directory and enter it.
mkcd() {
    if (( $# != 1 )); then
        printf 'Usage: mkcd DIRECTORY\n' >&2
        return 2
    fi
    mkdir -p -- "$1" && builtin cd -- "$1"
}

# Jump to the root of the current Git working tree.
croot() {
    local root
    if ! root=$(git rev-parse --show-toplevel 2>/dev/null); then
        printf 'croot: not inside a Git working tree\n' >&2
        return 1
    fi
    builtin cd -- "$root"
}
