# Dotfiles

Personal, portable Bash and Git configuration for multiple Linux machines.

This repository keeps custom settings separate from distribution-managed startup files. It is designed for Ubuntu and other Linux distributions using Bash.

## Contents

| File | Purpose |
| --- | --- |
| `bash/init.sh` | Loads the interactive Bash configuration. |
| `bash/aliases.sh` | Bash aliases (`..`, `...`). |
| `bash/functions.sh` | Helpers such as `mkcd` and `croot`. |
| `bash/prompt.sh` | Adds the Git branch to the existing Bash prompt. |
| `git/gitconfig` | Portable Git command aliases. |
| `install.sh` | Installs safe references without replacing existing config files. |

## Installation

```bash
git clone https://github.com/kogut3310/dotfiles.git ~/dotfiles
cd ~/dotfiles
bash install.sh
source ~/.bashrc
```

The installer:

1. Appends a small, marked loader to `~/.bashrc`, preserving all existing settings.
2. Adds an `include.path` entry to Git's global configuration so `git/gitconfig` is loaded without replacing `~/.gitconfig`.
3. Can be rerun safely: it checks for an existing loader and Git include.

The repository's checkout location is written into those references. Keep it at a stable path (for example, `~/dotfiles`). If you move it, update the loader and the Git include path.

## Git shortcuts

```bash
git at                 # git status
git cm "Your message"  # git commit -m "Your message"
git co feature/my-work # git checkout feature/my-work
git br                 # git branch
git lg                 # compact decorated commit graph
```

Git aliases work in any shell; they are not Bash-specific.

## Bash helpers

```bash
mkcd ~/Projects/demo  # create directory and enter it
croot                 # go to the root of the current Git worktree
..                    # parent directory
...                   # two directories up
```

The prompt shows the current Git branch, e.g. `user@host:~/dotfiles (main)$`, and hides the extra text outside Git repositories. Detached HEAD states are shown by their abbreviated commit SHA. Existing Ubuntu prompt colors are preserved.

## Customization

Edit `bash/aliases.sh`, `bash/functions.sh`, `bash/prompt.sh` or `git/gitconfig` and commit your changes. Reopen your terminal (or `source ~/.bashrc`) to reload Bash files. Changes to included Git aliases are available to the next Git invocation.

Do not commit credentials, API keys, machine-specific secrets or sensitive environment variables to this repository.
