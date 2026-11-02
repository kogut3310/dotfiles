# Use magenta for directory names when GNU ls colors are enabled.
# Append the override at the end so it wins over dircolors' default di= entry.
# Avoid repeated entries when ~/.bashrc is re-sourced.
case ":${LS_COLORS-}" in
    *':di=0;35'|*':di=0;35:') ;;
    *) LS_COLORS="${LS_COLORS:+${LS_COLORS%:}:}di=0;35:" ;;
esac
export LS_COLORS
