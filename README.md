# Dotfiles Repo
A collection of my dotfiles, managed with symlinks using Gnu Snow. Includes a
custom config built on top of [NvChad](https://github.com/NvChad/NvChad).

### Instructions
1. Clone this git repo into your home directory with the following command:
```bash
git clone https://github.com/duexcoast/dotfiles ~/.dotfiles --depth 1
```

2. If this is you're installing this for the first time, run the shell script in
the base directory.
```bash
cd ~/.dotfiles
setup.sh
```

3. Otherwise, simply use the makefile to create symlinks for all the configuration
files.
```bash
cd ~/.dotfiles
make
```

### What is Included
These dotfiles contain my custom configurations for neovim, tmux, zsh, and more.
These files are unfortunately what you might call a "hobby" for me, I hope I can
spare you at least one night spent trying to make nvim 

The neovim configuration is just my custom config built on top of [NvChad](https://github.com/NvChad/NvChad).
The config is catered towards full lsp support for Go and Typescript, and excellent
Git integration.
