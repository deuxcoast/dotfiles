all:
	stow --verbose --target=$$HOME --restow nvim
	stow --verbose --target=$$HOME --restow alacritty
	stow --verbose --target=$$HOME --restow iterm
	stow --verbose --target=$$HOME --restow git
	stow --verbose --target=$$HOME --restow lazygit
	stow --verbose --target=$$HOME --restow tmux
	stow --verbose --target=$$HOME --restow zsh

delete:
	stow --verbose --target=$$HOME --delete */
