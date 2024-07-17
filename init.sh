#!/bin/bash

# ------------------------------------------------------------------------------
# Install Brew
# ------------------------------------------------------------------------------

if ! command -v brew &> /dev/null
then
    printf "Installing Brew\n\n"
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    printf "Brew already installed\n\n"
fi

if ! command -v stow &> /dev/null
then
    printf "Installing Stow\n\n"
    brew install stow
else
    printf "Stow already installed\n\n"
fi

# ------------------------------------------------------------------------------
# Create necessary file structure
# ------------------------------------------------------------------------------
# add directory for tmux plugins, if it doesn't exist yet.
# necessary because we're using a custom directory, and using stow
# with out the path in place first will create problems.
[[ -d ~/.config/tmux-plugins ]] || mkdir ~/.config/tmux-plugins/

# ------------------------------------------------------------------------------
# Symlink dotfiles using stow
# ------------------------------------------------------------------------------
printf "Creating symlinks of dotfiles using Stow\n\n"
if [[ -f Makefile ]]; then
    make
else
    printf "Could not find a Makefile\n"
    printf "Make sure you are in the correct dotfiles directory\n\n"
    exit
fi

# ------------------------------------------------------------------------------
# Install packages from Brewfile
#
# Brew file should be symlinked as ~/Brewfile from stow command above
# ------------------------------------------------------------------------------

# Looks for ~/Brewfile and installs its contents
brew bundle install --global

# Build cache for bat pager, so themes can be used
printf "\n"
printf "Build cache for bat pager, enable custom themes\n\n"
bat cache --build

# ------------------------------------------------------------------------------
# Install Oh My Zsh
# ------------------------------------------------------------------------------

if [[ -n $ZSH_CUSTOM ]]; then
    printf "\n"
    printf "Installing Oh My Zsh\n\n"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    printf "\n"
    printf "Oh My Zsh already installed\n\n"
fi

# ------------------------------------------------------------------------------
# Install zsh plugins
# ------------------------------------------------------------------------------

# zsh-autosuggestions
if [[ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]]; then
    printf "Installing zsh-autosuggestions plugin\n"
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
fi

# zsh-syntax-highlighting
if [[ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]]; then
    printf "Installing zsh-syntax-highlighting plugin\n"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

# fzf-tab
if [[ ! -d ~/.oh-my-zsh/custom/plugins/fzf-tab ]]; then
    printf "Installing fzf-tab plugin\n"
    git clone https://github.com/Aloxaf/fzf-tab ~/.oh-my-zsh/custom/plugins/fzf-tab
fi

# ------------------------------------------------------------------------------
# Install tmux plugins
# ------------------------------------------------------------------------------

if [[ ! -d ~/.config/tmux-plugins/tpm ]]; then
    printf "\n"
    printf "Installing tmux plugin manager\n\n"
    git clone https://github.com/tmux-plugins/tpm ~/.config/tmux-plugins/tpm

    printf "\n\n"
    printf "Installing tmux plugins\n\n"
    ~/.config/tmux-plugins/tpm/bin/install_plugins
fi
