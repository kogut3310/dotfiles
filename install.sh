#!/usr/bin/env bash
set -euo pipefail

# Configure this checkout without replacing distribution-provided dotfiles.
repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
bashrc="$HOME/.bashrc"
init_file="$repo_dir/bash/init.sh"
git_aliases="$repo_dir/git/gitconfig"
marker='# >>> dotfiles loader >>>'

# %q makes an absolute pathname safe to embed in Bash source code.
printf -v quoted_init '%q' "$init_file"

if [[ ! -e "$bashrc" ]]; then
    touch -- "$bashrc"
fi

if grep -Fq -- "$marker" "$bashrc"; then
    printf 'Bash: existing dotfiles loader found; skipping.\n'
else
    cat >> "$bashrc" <<EOF

$marker
if [[ -r $quoted_init ]]; then
    source $quoted_init
fi
# <<< dotfiles loader <<<
EOF
    printf 'Bash: added loader to %s\n' "$bashrc"
fi

if ! command -v git >/dev/null 2>&1; then
    printf 'Git was not found; skipped Git aliases.\n' >&2
elif git config --global --get-all include.path 2>/dev/null | grep -Fxq -- "$git_aliases"; then
    printf 'Git: aliases already included; skipping.\n'
else
    git config --global --add include.path "$git_aliases"
    printf 'Git: added include.path in global Git configuration.\n'
fi

printf 'Done. Open a new terminal or run: source ~/.bashrc\n'
