imac:
	stow --verbose --target=$$HOME --restow nvim-imac
	stow --verbose --target=$$HOME --restow alacritty
	stow --verbose --target=$$HOME --restow iterm
	stow --verbose --target=$$HOME --restow lazygit
	stow --verbose --target=$$HOME --restow tmux
	stow --verbose --target=$$HOME --restow zsh

laptop:
	stow --verbose --target=$$HOME --restow nvim-laptop
	stow --verbose --target=$$HOME --restow alacritty
	stow --verbose --target=$$HOME --restow iterm
	stow --verbose --target=$$HOME --restow lazygit
	stow --verbose --target=$$HOME --restow tmux
	stow --verbose --target=$$HOME --restow zsh

delete:
	stow --verbose --target=$$HOME --delete */
