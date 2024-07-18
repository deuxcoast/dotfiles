#!/bin/bash

# ------------------------------------------------------------------------------
# Install Brew
# ------------------------------------------------------------------------------

if ! command -v brew &> /dev/null
then
    printf "Installing Brew\n\n"
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # If brew is being installed for the first time, we need to add it to the
    # PATH so it can be used in the rest of this script. The installation
    # directory is different depending on the CPU architecture.
    case $(uname -ms) in

        "Darwin arm64")
            printf "Adding brew to path (in ~/.zprofile) for arm64 Mac\n\n"

            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
            ;;

        "Darwin x86_64")
            printf "Adding brew to path (in ~/.zprofile) for x86_64 Mac\n\n"

            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
            ;;
    esac


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
# Add directory for tmux plugins, if it doesn't exist yet. this is necessary
# because we're using a custom plugin directory, and using stow with out the
# path in place first will create problems (we want to stow the files only, not
# the directory structure around them).
[[ -d ~/.config/tmux-plugins ]] || mkdir ~/.config/tmux-plugins

# Similar issue, lazygit has runtime files that it keeps in the config folder
# that we don't want to sync between machines. So we don't want to symlink the
# folder, just the config file within it
[[ -d ~/.config/lazygit ]] || mkdir ~/.config/lazygit

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
    # executable provided by tmux plugin manager that installs plugins listed
    # in tmux.conf, will install plugins into $TMUX_PLUGIN_MANAGER_PATH, which
    # is also set in tmux.conf
    ~/.config/tmux-plugins/tpm/bin/install_plugins
fi

# ------------------------------------------------------------------------------
# Configure Yabai
# ------------------------------------------------------------------------------
