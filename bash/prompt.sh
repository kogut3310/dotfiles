# Reproduce the preferred two-line, colored Bash prompt.
# Green: user@host; magenta: working directory; red: Git branch.

__dotfiles_git_branch_prompt() {
    local branch

    # Common case: Git branch name, with one Git invocation and no sed.
    if branch=$(git symbolic-ref --quiet --short HEAD 2>/dev/null); then
        printf '(%s)' "$branch"
    # Detached HEAD: show the short commit hash rather than an empty branch.
    elif branch=$(git rev-parse --short HEAD 2>/dev/null); then
        printf '(detached:%s)' "$branch"
    fi
}

# \[...\] marks non-printing ANSI sequences for proper readline wrapping.
# Terminal title: current directory; two-line prompt and literal '$' preserved.
PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[35m\]\w \[\e[31m\]$(__dotfiles_git_branch_prompt)\[\e[0m\]\n$ '
