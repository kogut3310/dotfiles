# Entry point sourced by ~/.bashrc. Do not execute as a standalone script.
[[ $- == *i* ]] || return 0

__dotfiles_bash_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P) || return
for __dotfiles_script in aliases.sh functions.sh colors.sh prompt.sh; do
    if [[ -r "$__dotfiles_bash_dir/$__dotfiles_script" ]]; then
        source "$__dotfiles_bash_dir/$__dotfiles_script"
    fi
done
unset __dotfiles_bash_dir __dotfiles_script
