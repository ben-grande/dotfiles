<!--
SPDX-FileCopyrightText: 2023 Benjamin Grande M. S. <ben.grande.b@gmail.com>

SPDX-License-Identifier: CC-BY-SA-4.0
-->

# dotfiles

Ben Grande's Dotfiles.

## Table of Contents

* [Description](#description)
* [Installation](#installation)
  * [Salt](#salt)
  * [Script](#script)
* [Usage](#usage)
* [License](#license)

## Description

Configuration and scripts targeting:

- Usability:
  - Vi keybindings for application movement
  - Emacs keybindings for command-line editing
  - XDG Specification to not clutter $HOME
- Portability:
  - POSIX compliant code
  - Drop-in configuration files
  - Tested in Qubes OS Dom0, Debian, Fedora
- Tasks:
  - GUI: x11, gtk
  - SCM: git, tig, git-shell
  - Keys: gpg, ssh
  - Networking: curl, urlview, wget, w3m
  - Productivity: tmux, vim
  - Shell: sh, bash, zsh, less, dircolors

## Installation

### Salt

The formula was designed to be run in Qubes OS, the normal user name is
hardcoded to `user` and its home is hardcoded to `/home/user`.

Install everything in a qube:
```sh
sudo qubesctl --skip-dom0 --targets=QUBE state.apply dotfiles.copy-all
```

Install specific files in Dom0:
```sh
sudo qubesctl state.apply dotfiles.copy-dom0,dotfiles.copy-sh,dotfiles.copy-vim,dotfiles.copy-x11
```

### Script

You can simply deploy all configurations with:
```sh
./files/setup.sh
```
Or target specific ones by specifying the directory name:
```sh
./files/setup.sh sh bash
```
Note that some files might depend on other directories, specially `sh` which
is a base for `bash` and `zsh` but might also have environment variables for
`net` and `vim`. It also adds `$HOME/.local/bin` and
`$HOME/.local/bin/$HOSTNAME` to the `$PATH` variable, so if the project has
scripts, install the `sh` directory.

Reload your shell:
```sh
exec $SHELL
```

Reload you X server:
```sh
. ~/.config/x11/xprofile
```

You need to logout and login again for some changes to take effect.

## Usage

The deployment replaces existing files and that is the goal, to make sure that
we have the same configuration of every machine. Support for local
configuration is implemented by including a local file per application.

Supported programs and the expected file names in `$HOME`:

- **bash**: .bashrc.local
- **git**:  .gitconfig.local
- **sh**:   .profile.local, .shrc.local, .config/sh/profile.d/ (.sh suffix)
- **ssh**:  .ssh/config.d/ (.conf suffix), .ssh/known_hosts.d/ (.host suffix)
- **tmux**: .tmux.conf.local
- **vim**:  .vimrc.local
- **x11**:  .xprofile.local, .config/x11/xprofile.d/ (.sh suffix)
- **zsh**:  .zshrc.local

## License

This project is [REUSE-compliant](https://reuse.software). It is difficult to
list all licenses and copyrights and keep them up-to-date here.

The easiest way to get the copyright and license of the project with the reuse
tool:
```sh
reuse spdx
```

You can also check these information manually by checking in the file header,
a companion `.license` or in `.reuse/dep5`.
