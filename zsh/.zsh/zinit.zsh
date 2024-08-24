# Install `zinit` if not installed
ZINIT_HOME="${HOME/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

# Load `zinit`
source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
autoload -Uz compinit
compinit
(( ${+_comps} )) && _comps[zinit]=_zinit



# This settings are applied immidiately (because we need to show
# prompt as fast as possible), so the plugins are being loaded
# eagerly.

zinit ice wait'!' lucid
zinit ice depth=1; zinit light romkatv/powerlevel10k

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#################################################################
# FUNCTIONS TO MAKE CONFIGURATION LESS VERBOSE
#################################################################

turbo0()   { zinit ice wait"0a" lucid             "${@}"; }
turbo1()   { zinit ice wait"0b" lucid             "${@}"; }
turbo2()   { zinit ice wait"0c" lucid             "${@}"; }
zcommand() { zinit ice wait"0b" lucid as"command" "${@}"; }
zload()    { zinit load                           "${@}"; }
zsnippet() { zinit snippet                        "${@}"; }

#################################################################
# FUZZY SEARCH AND MOVEMENT
#################################################################

# Install keybindings for fzf
zi for \
    https://github.com/junegunn/fzf/raw/master/shell/{'completion','key-bindings'}.zsh

# Create and bind multiple widgets using fzf
turbo0 multisrc"shell/{completion,key-bindings}.zsh" \
        id-as"junegunn/fzf_completions" pick"/dev/null"
    zload junegunn/fzf

# Fuzzy movement and directory choosing
zinit ice wait"2" as"command" from"gh-r" lucid \
  mv"zoxide*/zoxide -> zoxide" \
  atclone"./zoxide init  zsh > init.zsh" \
  atpull"%atclone" src"init.zsh" nocompile'!'
zinit light ajeetdsouza/zoxide

# Install `fzy` fuzzy finder, if not yet present in the system
# Also install helper scripts for tmux and dwtm
turbo0 as"command" if'[[ -z "$commands[fzy]" ]]' \
       make"!PREFIX=$ZPFX install" atclone"cp contrib/fzy-* $ZPFX/bin/" pick"$ZPFX/bin/fzy*"
    zload jhawthorn/fzy

#################################################################
# INSTALL `k` COMMAND AND GENERATE COMPLETIONS
#################################################################

GENCOMPL_PY=python3
turbo0; zload RobSis/zsh-completion-generator
turbo1 atclone"gencomp k; ZINIT[COMPINIT_OPTS]='-i' zpcompinit" atpull'%atclone'
    zload supercrabtree/k
alias l='k -h'

#################################################################
# OTHER PLUGINS
#################################################################

# Add `git dsf` command to git
zcommand pick"bin/git-dsf";            zload zdharma-continuum/zsh-diff-so-fancy


#################################################################
# IMPORTANT PLUGINS
#################################################################

# Additional completion definitions
turbo0 blockf
zload zsh-users/zsh-completions

# Syntax highlighting
# (compinit without `-i` spawns warning on `sudo -s`)
turbo0 atinit"ZINIT[COMPINIT_OPTS]='-i' zpcompinit; zpcdreplay"
    zload zdharma-continuum/fast-syntax-highlighting

# Autosuggestions
# Note: should go _after_ syntax highlighting plugin
zinit wait lucid light-mode for \
      atload"_zsh_autosuggest_start; \
            ZSH_AUTOSUGGEST_STRATEGY=(history completion) \
            ZSH_AUTOSUGGEST_MANUAL_REBIND=0 \
            ZSH_AUTOSUGGEST_HISTORY_IGNORE=' *' \
            bindkey '^ ' autosuggest-accept" \
      zsh-users/zsh-autosuggestions


#################################################################
# REMOVE TEMPORARY FUNCTIONS
#################################################################

unset -f turbo0
unset -f zload
unset -f zsnippet
