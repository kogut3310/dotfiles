# Dotfiles

Personal, portable Bash and Git configuration for multiple Linux machines.

This repository keeps custom settings separate from distribution-managed startup files. It is designed for Ubuntu and other Linux distributions using Bash.

## Contents

| File | Purpose |
| --- | --- |
| `bash/init.sh` | Loads the interactive Bash configuration. |
| `bash/aliases.sh` | Bash aliases (`..`, `...`). |
| `bash/functions.sh` | Helpers such as `mkcd` and `croot`. |
| `bash/colors.sh` | Sets magenta (`di=0;35`) for directories in GNU `ls`. |
| `bash/prompt.sh` | Configures the colored, two-line prompt with Git branch. |
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

## Prompt colors and Git branch

`bash/prompt.sh` deliberately replaces the default `PS1` with the preferred two-line layout:

```text
user@host ~/dotfiles (main)
$ 
```

- Green (`32`): user and hostname.
- Magenta (`35`): working directory.
- Red (`31`): current Git branch, shown as `(main)`.
- Reset (`0`) before the second line, containing a literal `$`.
- The terminal window title is set to the working directory.

The branch function uses `git symbolic-ref --quiet --short HEAD` instead of piping `git branch` through `sed`, reducing overhead in a normal Git repository. It uses `git rev-parse --short HEAD` as a fallback for detached HEAD (displayed as `(detached:abc1234)`). Outside a Git repository, the branch segment is empty.

## Directory colors

`bash/colors.sh` appends `di=0;35:` to `LS_COLORS`, overriding the usual blue directories with magenta for better contrast on dark terminal themes. It checks whether the final entry already matches, avoiding duplicate entries when `~/.bashrc` is reloaded. All other existing `LS_COLORS` entries are preserved.

The setting applies when GNU `ls` is invoked with coloring enabled, for example `ls --color=auto`. Ubuntu typically enables this using a shell alias in `.bashrc`.

## Customization

Edit the scripts under `bash/` or `git/gitconfig` and commit your changes. Reopen your terminal (or `source ~/.bashrc`) to reload Bash files. Changes to included Git aliases are available to the next Git invocation.

If you previously hard-coded a `PS1` or `LS_COLORS` override directly in `~/.bashrc`, consider deleting the redundant lines after confirming the new configuration is active.

Do not commit credentials, API keys, machine-specific secrets or sensitive environment variables to this public repository.
