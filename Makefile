all:
	stow --verbose --target=$$HOME --restow nvim
	stow --verbose --target=$$HOME --restow alacritty
	stow --verbose --target=$$HOME --restow iterm
	stow --verbose --target=$$HOME --restow git
	stow --verbose --target=$$HOME --restow lazygit
	stow --verbose --target=$$HOME --restow tmux
	stow --verbose --target=$$HOME --restow zsh
	stow --verbose --target=$$HOME --restow skhd
	stow --verbose --target=$$HOME --restow yabai
	stow --verbose --target=$$HOME --restow sketchybar
	stow --verbose --target=$$HOME --restow anki

	$(shell ./bootstrap.sh)
delete:
	stow --verbose --target=$$HOME --delete */

	$(shell ./cleanup.sh)

clean-link:
	delete
	all
