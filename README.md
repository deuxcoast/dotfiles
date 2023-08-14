# Dotfiles Repo

A collection of my dotfiles, managed with symlinks using Gnu Stow. Say what you
will about my nvim config, but she's beautiful to me. There's a makefile included
in the project root with commands for setting up a new box.

## Installation

I plan on writing a script to automate all of this, but for the time being, there
is a bit of manual labor involved. Hard work builds character.

### Downloading the required packages

1. Clone this repo into your home directory with the following command:

```bash
git clone https://github.com/duexcoast/dotfiles ~/.dotfiles --depth 1
```

> :warning: These configs were written on Macs, and have not taken other OS's into
> account. That being said, they should work on both the newer M1 arm64 architecture,
> as well as older Intel-based Macs.

2.  There are a number of programs required in order for these programs to operate
    correctly. An incomplete list off the top of my head, starting with (obviously) a
    package manager:

        - [homebrew](https://brew.sh/)
        - [stow](https://github.com/aspiers/stow)
        - [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)
        - [nvim](https://github.com/neovim/neovim)
        - [tmux](https://github.com/tmux/tmux)
        - [tmuxinator](https://formulae.brew.sh/formula/tmuxinator)
        - [bat](https://github.com/sharkdp/bat)
        - [fzf](https://github.com/junegunn/fzf)
        - [ripgrep](https://github.com/BurntSushi/ripgrep)
        - [the_silver_searcher](https://github.com/ggreer/the_silver_searcher)
        - [lazygit](https://github.com/jesseduffield/lazygit)
        - [delta](https://github.com/dandavison/delta)
        - [nodejs](https://github.com/nodejs/node)
        - [autojump](https://github.com/wting/autojump)
        - [glow](https://github.com/charmbracelet/glow)
        - [go](https://github.com/golang/go)
        - [go tools](https://github.com/golang/tools)
        - [nodejs](https://nodejs.org/en/download/current)

3.  You will also need to install certain additonal zsh plugins not provided by
    ohmyzsh. They can be installed using the ohmyzsh plugin manager, by following
    the instructions on the pages below:

        - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh)
        - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md)

### Using Stow for Symlinks

Included in the root of the project is a Makefile with commands for creating symlinks
in the correct destination for all configuration files. If you're installing this
for the first time, `cd` into your `$HOME` directory (it's important that the
`.dotfiles` repository has been cloned to `$HOME`), and run the following command:

```
make clean-link
```

This command first deletes all symlinks being managed by stow in the `$HOME`
directory (this helps avoid conflicts that occur when the target files already
exist), and then runs the following command:

```bash
stow --verbose --target=$$HOME --restow nvim
stow --verbose --target=$$HOME --restow alacritty
stow --verbose --target=$$HOME --restow iterm
stow --verbose --target=$$HOME --restow git
stow --verbose --target=$$HOME --restow lazygit
stow --verbose --target=$$HOME --restow tmux
stow --verbose --target=$$HOME --restow zsh
```

All programs are organized under a self-named directory. Below this level, the
directory structure is modeled relative to where all files should be symlinked,
relative to the `$HOME` directory. Stow takes this structure, and uses it to
determine the destination of the symlinks.

## Additional Setup

Of course there's more to do.

### Mac Os Settings

It is important for your health that you remap the control key to the caps lock
key at the system level. You will rapidly develop carpal tunnel if this is
neglected, and life will just be generally unpleasant.

I've also chosen to remap the Alt key, trading places with the Apple command key.

These settings can be changed in the "System Settings" application under the
"Keyboard" tab. Once there, the "Keyboard Shortcuts" button will provide you the
opportunity to change the mapping.

You should also turn off all other system wide hotkeys that you don't use.

### Alacritty

The default font I'm using in the terminal is Hasklug Nerd Font, a forked version
of Source Code Pro with ligatures. This font can be downloaded here:

```
https://github.com/ryanoasis/nerd-fonts/releases
```

I've referenced the normal, italic and bold versions in the alacritty config, so
they all three are required.

### Tmux

For tmux, we need to install the plugins refercened in the `.tmux.conf` file. This
is relatively easy, all we need to do is use the key mapping `<C-a> I`, which will
tell the Tmux Plugin Manager to install all required plugins.

The bigger problem here is the way that tmux handles 256 bit color and rendering
italics. If you run into issues around the way neovim highlights are being rendered
in Tmux, then this [gist](https://gist.github.com/andersevenrud/015e61af2fd264371032763d4ed965b6)
can be a great reference.

If it doesn't work smoothly for you, the follwing resources might help: [alacritty
TERM for ssh](https://news.ycombinator.com/item?id=27076282).

### Nvim

This should be automated, but in case it's not:

We need to install all of the language servers in order for LSP to work. This can
be done effortlessly by running `:Mason` and using the interface to download the
required language servers.

We also need to download Debug Adapters in order to use DAP. Download instructions
for various languages can be found [here](https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation).
Most importantly:

    - [Delve](https://github.com/go-delve/delve/tree/master/Documentation/installation) for debugging) Go code.

There will be other things that arise.

### Scripts

There's a collection of scripts that will get symlinked to `~/.local/bin/`, an ever
increasing collection of small, little useful things.

I've created a script named `config` to help with working on all of these files. It
utilizes `tmuxinator` to create tmux sessions for the programs provided as
arguments.

For example, the command `config nvim` will create a new session
self-named "nvim config" with three windows, the first being an nvim instance opened
on a saved-session in the nvim config workspace, the second being a terminal, and
the third being lazygit.

This has turned out to be a pretty good workflow for me so far, and has drastically
increased the speed at which I'm able to hop around between projects, and spin up
all the windows I need.

The one improvement I'm still trying to figure out is how to make reproducible nvim
sessions. The current way I save sessions is pretty buggy and not very effective.
