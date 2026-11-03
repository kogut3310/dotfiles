# Entry point sourced by ~/.bashrc. Do not execute as a standalone script.
[[ $- == *i* ]] || return 0

__dotfiles_bash_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P) || return
for __dotfiles_script in aliases.sh functions.sh colors.sh system.sh prompt.sh; do
    if [[ -r "$__dotfiles_bash_dir/$__dotfiles_script" ]]; then
        source "$__dotfiles_bash_dir/$__dotfiles_script"
    fi
done

# Load optional settings matched to the machine's short hostname.
__dotfiles_hostname=${HOSTNAME:-}
if [[ -z $__dotfiles_hostname ]]; then
    __dotfiles_hostname=$(hostname -s 2>/dev/null) || true
fi
__dotfiles_hostname=${__dotfiles_hostname%%.*}
if [[ -n $__dotfiles_hostname && $__dotfiles_hostname != */* && -r "$__dotfiles_bash_dir/hosts/$__dotfiles_hostname.sh" ]]; then
    source "$__dotfiles_bash_dir/hosts/$__dotfiles_hostname.sh"
fi

unset __dotfiles_bash_dir __dotfiles_script __dotfiles_hostname
