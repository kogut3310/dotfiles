# Add the current Git branch to the interactive Bash prompt.
# Retains the distribution's existing colors and other PS1 content.

__dotfiles_git_branch_prompt() {
    command -v git >/dev/null 2>&1 || return 0

    local branch
    if branch=$(git symbolic-ref --quiet --short HEAD 2>/dev/null); then
        printf ' (%s)' "$branch"
    elif branch=$(git rev-parse --short HEAD 2>/dev/null); then
        printf ' (detached:%s)' "$branch"
    fi
}

# Avoid adding the same prompt substitution twice when Bash is reloaded.
if [[ ${PS1-} == *'$(__dotfiles_git_branch_prompt)'* ]]; then
    return 0
fi

# Ubuntu's default prompt ends with \$ followed by a space.
# Insert the branch before the prompt symbol. For custom prompts,
# show the branch as a prefix instead of replacing their formatting.
if [[ ${PS1-} == *'\$ '* ]]; then
    PS1=${PS1/'\$ '/'$(__dotfiles_git_branch_prompt)\$ '}
else
    PS1='$( __dotfiles_git_branch_prompt )'"${PS1-}"
fi
