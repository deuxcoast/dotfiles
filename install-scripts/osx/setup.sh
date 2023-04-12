#!/bin/bash
set -e
set -u

RCol='\033[0m'
Gre='\033[0;32m'
Red='\033[0;31m'
Yel='\033[0;33m'

# ==========
## Printing functions ##
# ==========
function gecho {
  echo "${Gre}[message] $1${RCol}"
}

function yecho {
  echo "${Yel}[warning] $1${RCol}"
}

function wecho {
  # red, but don't exit 1
  echo "${Red}[error] $1${RCol}"
}


function recho {
  echo "${Red}[error] $1${RCol}"
  exit 1
}

# ==========
## Install functions ##
# ==========

# Check for pre-req, fail if not found
function check_preq {
  (command -v "$1" > /dev/null  && gecho "$1 found...") || 
    recho "$1 not found, install before proceeding."
}

# Look for command line tool, if not install via homebrew
function install_brew {
  (command -v "$1" > /dev/null  && gecho "$1 found...") || 
    (yecho "$1 not found, installing via homebrew..." && brew install "$1")
}

# Function for linking dotfiles
# function linkdotfile {
#   file="$1"
#   if [ ! -e "$HOME/$file" -a ! -L "$HOME/$file" ]; then
#       yecho "$file not found, linking..." >&2
#       ln -s "$HOME/dotfiles/$file $HOME/file"
#   else
#       gecho "$file found, ignoring..." >&2
#   fi
# }
#

# ==========
# Perform actual installations
# ==========
 
# Are we in right directory?
[[ "$(basename "$(pwd)")" == ".dotfiles" ]] || 
  recho "doesn't look like you're in dotfiles/"

# Check that the necessary pre-requisites are met:
check_preq gcc
check_preq brew

# Install essential programs with homebrew
install_brew the_silver_searcher
install_brew tmux
install_brew nvim
install_brew bat
install_brew fzf
install_brew lazygit
install_brew ripgrep
install_brew node

# ==========
# Setup NvChad
# ==========

# Check if there is already nvim configuration
if [ -e $"HOME"/.configs/nvim ]; then
  yecho "found a previous nvim configuration, backing up in:\n\t~/.configs/backup_nvim" >&2

  # Make backup of any previous nvim configuration
  if [ ! -e "$HOME"/.configs/backup_nvim ]; then

    mkdir "$HOME"/.configs/backup_nvim 
    mv "$HOME"/.config/nvim "$HOME"/.config/backup_nvim 
    mv "$HOME"/.local/share/nvim "$HOME"/.config/backup_nvim/plugins 
    mv "$HOME"/.cache/nvim "$HOME"/.config/backup_nvim/cache 
  else
    mv -f "$HOME"/.config/nvim "$HOME"/.config/backup_nvim
    mv -f "$HOME"/.local/share/nvim "$HOME"/.config/backup_nvim/plugins 
    mv -f "$HOME"/.cache/nvim "$HOME"/.config/backup_nvim/cache 
  fi
else
  gecho "no prior nvim configuration found" >&2
fi

# Install NvChad 
# We want to overwrite the `~/.config/nvim/lua/custom` folder with our own
# symlink config before opening the nvim executable.
gecho "installing NvChad via git clone"
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1

make

# ==========
# Create a global Git ignore file
# ==========
if [ ! -e "$HOME"/.global_ignore ]; then
    yecho "~/.global_ignore not found, curling from Github..." >&2
    curl \
      https://raw.githubusercontent.com/github/gitignore/master/Global/Emacs.gitignore \
      https://raw.githubusercontent.com/github/gitignore/master/Global/Vim.gitignore \
      https://raw.githubusercontent.com/github/gitignore/master/Global/macOS.gitignore \
    > ~/.global_ignore 2> /dev/null
    git config --global core.excludesfile ~/.global_ignore && 
      yecho "[message] adding ignore file to Git..." >&2
else
    gecho "~/.global_ignore found, ignoring..." >&2
fi

yecho "run the following to change shell to zsh... :" >&2
echo "  chsh -s /bin/zsh "

