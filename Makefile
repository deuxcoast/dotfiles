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
	stow --verbose --target=$$HOME --restow clangd
	stow --verbose --target=$$HOME --restow brew
	stow --verbose --target=$$HOME --restow karabiner

clean:
	stow --verbose --target=$$HOME --delete */
