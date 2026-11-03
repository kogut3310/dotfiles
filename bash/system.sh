# General system aliases, available on every machine using these dotfiles.
alias off='sudo poweroff'
alias rr='sudo reboot'
alias gui='sudo systemctl start graphical.target'

# Display a short command reference once per interactive SSH terminal session.
# No output is produced for non-interactive SSH commands or local terminals.
if [[ -n ${SSH_TTY:-} && -z ${DOTFILES_SSH_WELCOME_SHOWN:-} ]]; then
    export DOTFILES_SSH_WELCOME_SHOWN=1

    __dotfiles_display_host=${HOSTNAME:-}
    if [[ -z $__dotfiles_display_host ]]; then
        __dotfiles_display_host=$(hostname -s 2>/dev/null) || __dotfiles_display_host=HOST
    fi
    __dotfiles_display_host=${__dotfiles_display_host%%.*}

    printf '\n=== %s - quick commands ===\n' "${__dotfiles_display_host^^}"
    printf '%-58s | %s\n' 'Restart:      sudo reboot' 'rr'
    printf '%-58s | %s\n' 'Power off:    sudo poweroff' 'off'
    printf '%-58s | %s\n' 'Start GNOME:  sudo systemctl start graphical.target' 'gui'
    printf '\n'

    unset __dotfiles_display_host
fi
