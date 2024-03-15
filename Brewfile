#!/bin/bash

# cli tools
brew archey4
brew atuin
brew bat
brew btop
brew coreutils
brew docker
brew exa
brew fd
brew fzf
brew gh
brew git-delta
brew glow
brew htop
brew hub
brew jq
brew kubectl
brew lazygit
brew mongocli
brew mosh
brew mosh
brew most
brew mysql
brew neovim
brew osx-cpu-temp
brew ripgrep
brew rsync
brew the_silver_searcher
brew tmux
brew tmuxinator
brew tree
brew vivid
brew wget
brew zoxide
brew zsh
brew zzz

# databases / key-value stores
brew elasticsearch, restart_service: :changed
brew mongodb, restart_service: :changed
brew mysql, restart_service: :changed
brew postgis
brew postgresql, restart_service: :changed
brew redis, restart_service: :changed

# dev gui apps
cask alacritty unless File.directory?("/Applications/Alacritty.app/")
cask docker unless File.directory?("/Applications/Docker.app/")
cask ngrok
cask pgadmin4
cask postman
cask tailscale
cask vagrant
cask wireshark

# non-dev gui apps
cask anki
cask bitwarden
cask caffeine # turns off auto-sleep
cask dropbox
cask figma
cask firefox
cask google-chrome
cask google-drive-file-stream
cask hyperswitch # fixes alt-tab
cask kap         # screen capture
cask slack
cask the-unarchiver
cask vlc
cask zoom

# quicklook plugins
# https://github.com/sindresorhus/quick-look-plugins
# Might need to remove quarantine attributes
# To see attributes, run:
# xattr -r ~/Library/QuickLook
# To remove quarantine attributes, run:
# xattr -d -r com.apple.quarantine ~/Library/QuickLook
cask qlcolorcode
cask qlimagesize
cask qlmarkdown
cask qlstephen
cask qlvideo
cask quicklook-json
cask quicklookase
cask suspicious-package

# programming languages & package managers
brew golang
brew node
brew nvm
brew pnpm
brew yarn
brew rustup-init
brew ruby
brew pyenv

echo "Copy and paste the following to install oh-my-zsh:"
echo "\$ sh -c \"\$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)\""
echo "script/strap-after-setup DONE"

