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

	# setup modular tmux config
	$(shell ./bootstrap.sh)
delete:
	stow --verbose --target=$$HOME --delete */

	# Change the tmux configuration back to the base minimal config
	echo 'source-file ~/.config/tmux/minimal.conf' > ~/.dotfiles/tmux/.config/tmux/tmux.conf

clean-link:
	delete
	all
