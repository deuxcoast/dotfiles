# Dotfiles

## Sourcing of startup files for Zsh 
Determining where we should put various aspects of our Zsh configuration, to 
ensure that all operations happen in the correct order can lead to a special
kind of insanity. Determing the order in which startup files are read by a Zsh 
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


