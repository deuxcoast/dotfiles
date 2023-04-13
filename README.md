# Dotfiles Repo
A collection of my dotfiles, managed with symlinks using Gnu Stow. Includes a
custom config built on top of 
## Instructions
1. Clone this git repo into your home directory with the following command:
```bash
git clone https://github.com/duexcoast/dotfiles ~/.dotfiles --depth 1
```

2. If this is you're installing this for the first time (and are using a Mac), 
run the shell script in the base directory to bootstrap the proccess.
```bash
cd ~/.dotfiles
setup.sh
```

3. Otherwise, simply use the makefile to create symlinks for all the configuration
files. It won't work correctly if there isn't the correct directory shaffolding.
```bash
cd ~/.dotfiles
make
```

## What is Included
These dotfiles contain my custom configurations for neovim, tmux, zsh, and more.

My neovim config is catered towards full lsp support for Go and Typescript, and excellent
Git integration with Fugitive and LazyGit. It is built on top of [NvChad](https://github.com/NvChad/NvChad),
and only occupies the `~/.config/nvim/lua/custom` directory. It must be installed
on top of an NvChad installation.

## Setup Script
IMPORTANT: The script has not yet been tested and may contain bugs. 

The `setup.sh` script will install neccessary packages to bootstrap a new machine,
and will set up Oh-My-Zsh with plugins, as well as various essential CLI applications.

The script will backup and store all overwritten configurations in `~/.config/backup`,
and if there is previous backups it will store them in a tarball.


