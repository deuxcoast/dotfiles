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
install_brew stow
install_brew autojump

# ==========
# Create backups of configs before creating symlinks
# ==========

if [ -d "$HOME"/.config/backup ]; then
  yecho "creating backup directory"
  mkdir -p "$HOME"/.config/backup
else
  cd "$HOME"/.config
  tar -cf config-archive-$(date +"%d-%m-%Y") backup
  rm -rf "$HOME"/.config/backup
  mkdir -p "$HOME"/.config/backup
  mv config-archive-$(date +"%d-%m-%Y") "$HOME"/.config/backup 
  cd "$HOME"/.dotfiles
fi

# Backup and create directories for zsh config
if [ -d "$HOME"/.zsh ]; then
  mv "$HOME"/.zsh "$HOME"/.config/backup/.zsh
fi  
mkdir "$HOME"/.zsh

if [ -e "$HOME"/.zshrc ]; then
  mv "$HOME"/.zshrc "$HOME"/.config/backup/.zshrc  
fi
touch "$HOME"/.zshrc

# Backup and create directories for tmux config
if [ -e "$HOME"/.tmux.conf ]; then
  mv "$HOME"/.tmux.conf "$HOME"/.config/backup/.tmux.conf  
fi
touch "$HOME"/.tmux.conf

# Backup and create directories for git config
if [ -e "$HOME"/.gitconfig ]; then
  mv "$HOME"/.gitconfig "$HOME"/.config/backup/.gitconfig
fi
touch "$HOME"/.gitconfig

mkdir "$HOME"/.config/git
if [ -d "$HOME"/.config/git ]; then
  mv "$HOME"/.config/git "$HOME"/.config/backup/git
fi
mkdir "$HOME"/.config/git

# Backup and create directories for lazygit config
if [ -d "$HOME"/.config/lazygit ]; then
  mv "$HOME"/.config/lazygit "$HOME"/.config/backup/lazygit
fi
mkdir "$HOME"/.config/lazygit

# Backup and create files for iterm
if [ -d "$HOME"/.config/iterm2/profiles ]; then
  mv "$HOME"/.config/iterm2/profiles "$HOME"/.config/backup/iterm2
fi
mkdir "$HOME"/.config/iterm2/profiles
  
# ==========
# Setup NvChad
# ==========

# Check if there is already nvim configuration
if [ -e "$HOME"/.config/nvim ]; then
  yecho "found a previous nvim configuration, backing up in:\n~/.config/backup/nvim\n" >&2

  # Make backup of any previous nvim configuration
  if [ ! -d "$HOME"/.config/backup/nvim ]; then

    mkdir -p "$HOME"/.config/backup/nvim
    
    mv "$HOME"/.config/nvim "$HOME"/.config/backup/nvim 
    mv "$HOME"/.local/share/nvim "$HOME"/.config/backup/nvim/plugins 
    mv "$HOME"/.cache/nvim "$HOME"/.config/backup/nvim/cache 
  else
    mv -f "$HOME"/.config/nvim "$HOME"/.config/backup/nvim
    mv -f "$HOME"/.local/share/nvim "$HOME"/.config/backup/nvim/plugins 
    mv -f "$HOME"/.cache/nvim "$HOME"/.config/backup/nvim/cache 
  fi
  # now that download is complete, delete `~/.config/nvim` to prep for NvChad installation
  yecho "removing ~/.config/nvim"
else
  gecho "no prior nvim configuration found" >&2
fi


# Install NvChad 
# We want to overwrite the `~/.config/nvim/lua/custom` folder with our own
# symlink config before opening the nvim executable.
gecho "installing NvChad via git clone"
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1

# ==========
# Install Oh-My-Zsh
# ==========
if [ ! -d "$HOME"/.oh-my-zsh]; then 
  yecho "Oh-My-Zsh not found, installing..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install Oh-My-Zsh plugins
# Check if zsh-syntax-highlighting is present, install if not
if [ ! -d "$HOME"/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting]; then 
  yecho "zsh-syntax-highlighting plugin not found, installing..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting 
else
  gecho "found zsh-syntax-highlighting plugin"
fi

# Check if zsh-syntax-highlighting is present, install if not
if [ ! -d "$HOME"/.oh-my-zsh/custom/plugins/zsh-autosuggestions]; then 
  yecho "zsh-autosuggestions plugin not found, installing..."
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
else
  gecho "found zsh-autosuggestions plugin"
fi

# ==========
# Create symlinks for dotfiles by executing stow command in `.dotfiles` directory
# ==========
stow --verbose --target=$$HOME --restow */



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

