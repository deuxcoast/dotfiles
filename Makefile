.PHONY: all, clean, link

all: clean link
	
link:
	stow --verbose --target=$$HOME --restow nvim
	stow --verbose --target=$$HOME --restow alacritty
	stow --verbose --target=$$HOME --restow git
	stow --verbose --target=$$HOME --restow lazygit
	stow --verbose --target=$$HOME --restow tmux
	stow --verbose --target=$$HOME --restow zsh
	stow --verbose --target=$$HOME --restow skhd
	stow --verbose --target=$$HOME --restow yabai
	stow --verbose --target=$$HOME --restow sketchybar
	stow --verbose --target=$$HOME --restow anki

	# We don't want to track the plugins in our dotfiles repo, but
	# we want to ensure the custom dir they are installed to exists
	[[ -d ~/.config/tmux-plugins ]] || mkdir ~/.config/tmux-plugins/ 
	echo "Alacritty should be at least version 0.13"

clean:
	stow --verbose --target=$$HOME --delete */
