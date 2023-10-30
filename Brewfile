#!/bin/bash

# cli tools
brew zsh
brew neovim
brew hub
brew mosh
brew the_silver_searcher
brew tree
brew tmux
brew wget
brew fzf
brew git-delta
brew ripgrep
brew bat
brew autojump
brew tmuxinator
brew lazygit
brew rsync
brew jq
brew gh
brew kubectl
brew docker
brew mysql
brew mongocli
brew coreutils
brew archey4
brew htop
brew osx-cpu-temp
brew most
brew zzz
brew atuin
brew glow
brew vivid
brew mosh
brew exa
brew fd



# databases / key-value stores
brew mongodb, restart_service: :changed
brew mysql, restart_service: :changed
brew postgresql, restart_service: :changed
brew postgis
brew redis, restart_service: :changed
brew elasticsearch, restart_service: :changed

# dev gui apps
cask alacritty unless File.directory?("/Applications/Alacritty.app/")
cask docker unless File.directory?("/Applications/Docker.app/")
cask postman
cask wireshark
cask vagrant
cask ngrok
cask pgadmin4
cask tailscale

# non-dev gui apps
cask google-chrome
cask firefox
cask the-unarchiver
cask vlc
cask figma
cask caffeine # turns off auto-sleep
cask dropbox
cask google-drive-file-stream
cask hyperswitch # fixes alt-tab
cask kap         # screen capture
cask slack
cask anki
cask zoom
cask bitwarden

# quicklook plugins
# https://github.com/sindresorhus/quick-look-plugins
# Might need to remove quarantine attributes
# To see attributes, run:
# xattr -r ~/Library/QuickLook
# To remove quarantine attributes, run:
# xattr -d -r com.apple.quarantine ~/Library/QuickLook
cask qlcolorcode
cask qlstephen
cask qlmarkdown
cask quicklook-json
cask qlimagesize
cask suspicious-package
cask quicklookase
cask qlvideo

# programming languages & package managers
brew golang
brew node
brew nvm
brew yarn
brew pnpm

echo "Copy and paste the following to install oh-my-zsh:"
echo "\$ sh -c \"\$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)\""
echo "script/strap-after-setup DONE"

