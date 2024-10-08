# Dotfiles

## Instructions

Simply clone the repository into your home directory, `cd` in and run `init.sh`.

### Yabai and skhd

Getting `yabai` to work is a more involved process, as we need to disable System
Integrity Protection, and install a scripting addition.

The detailed instructions, which are different for Intel Macs and ARM Macs, can
be found
[here](https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection).

- For ARM Macs, do not forget to enable non-Apple-signed arm64 binaries after
  disabling SIP, with the command below. _Restart a second time after doing this_.

  ```bash

  sudo nvram boot-args=-arm64e_preview_abi

  ```

- To configure the scripting addition, we can enter the command below, which
  gives yabai root privileges, which it needs in order to inject code into
  Dock.app, which is how it can act as a window manager on top of OSX.

```bash

bash echo "$(whoami) ALL=(root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai)
| cut -d " " -f 1) $(which yabai) --load-sa" | sudo tee
/private/etc/sudoers.d/yabai

```

- Should be good to go at this point. Run `yabai --start-service`, which will
  start the launchd service.

## Sourcing of startup files for Zsh

Determining where we should put various aspects of our Zsh configuration, to
ensure that all operations happen in the correct order can lead to a special
kind of insanity. Determining the order in which startup files are read by a Zsh
shell, and in which our `$PATH` is set, is a road paved with lots of "gotachas".

Taken from the [Zsh Docs](https://zsh.sourceforge.io/Intro/intro_3.html), we
have the following order in which startup files are sourced:

- `$ZDOTDIR/.zshenv`
  `.zshenv` is sourced on all invocations of the shell, unless the `-f` option is
  set (the `-f` option is equivalent to `--norcs`, which prevents the zsh startup
  files from being sourced). We should thus use this file to set our $PATH with
  directories containing command executables, but we should avoid including
  commands that assume we are using a `tty`.
- `$ZDOTDIR/.zprofile`
- `$ZDOTDIR/.zshrc`
  `.zshrc` is sourced in interactive shells. We should include aliases, functions,
  options, and key bindings in this file. This is the bread and butter of our zsh
  configuration.
- `$ZDOTDIR/.zlogin`
- `$ZDOTDIR/.zlogout`

### References

- [Zsh Reference Card](https://www.bash2zsh.com/zsh_refcard/refcard.pdf)
- [Zsh Lovers Man Page](https://grml.org/zsh/zsh-lovers.html)

## tmux and terminfo

I wasted countless hours trying to determine why tmux was integrating with
Alacritty and Nvim correctly on one machine while it was completely bugging out
on another (keyboard input was sporatic, colors in Nvim were incorrect).

At first I assumed the underlying problem was the different processors (Arm64 m1
Macbook Air vs Intel x86_64 iMac). After finding that what seemingly fixed the
problem on one machine would break the other, I went about trying to find an
entirely separate solution for each. This underlying assumption of where to
attribute the fault was completely incorrect! The real problem was the
`terminfo` settings, which had apparently been correctly compiled on one
computer and not on the other (meaning I had fixed it months before on one
computer and completely forgotten about it, hence this reference note for future
me).

The problem boiled down to MacOS shipping with an out-of-date version of `ncurses`
that doesn't have a `terminfo` entry for `tmux-256color`. These `terminfo` entries
tell `ncurses` how to use the capabilities of our terminal: they are basically
an API between terminals and the rendering library.

Meanwhile, since I had installed tmux via Homebrew, I also had a newer version
of `ncurses` installed on my system, the version which tmux was compiled
against. This is why tmux worked without a hiccup in some cases, but when using
an application linked against the MacOS version of `ncurses`, things started to
fall apart.

The fix for all of this was to update the macOS `terminfo` database with the
`tmux-256color` entry (and `alacritty-direct` while we're at it).

I would have never discovered any of this on my own, the following guides were
indispensible for getting everything in a working state:

- [Installing tmux-256color for macOS](https://gist.github.com/bbqtd/a4ac060d6f6b9ea6fe3aabe735aa9d95)
- [The definitive guide to using tmux-256color on
  macOS](https://gpanders.com/blog/the-definitive-guide-to-using-tmux-256color-on-macos/)

```

```
