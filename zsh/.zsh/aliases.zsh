alias j='z'
alias ji='zi'
alias cheat='curl cht.sh/'
# --- Navigation ---
alias ..="cd .."
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias ~='cd ~'

# --- Easy reports ---

# List
alias ls='eza --classify'
alias lsa='eza --classify --all'
alias grep='grep --color=auto'
alias l="eza --classify -l"
alias la="ls -la"
alias lf="ls -l | grep '^-'"
alias lr="ls -R"
alias l.f="ls -ld .* | grep '^-'"
alias ld="ls -l | grep '^d'"
alias l.d="ls -ld .* | grep '^d'}"

# Disk Usage
alias dud="du -d 1 -h"
alias duf="du -sh *"

alias fdir="find . -type f -name" # this is wrong?
alias ff="find . -type f -name"

# copy the current working directory to the system clipboard
alias cwd="pwd | pbcopy"
alias h="history"
alias hgrep="history | grep"
alias lgrep="ls -l | grep"
alias lagrep="ls -lA | grep"
alias sgrep="grep -R -n -H -C 5 --exclude-dir={.git,.svn,node_modules,Trash,vendor}"
alias cp="cp -iv"
alias mv="mv -iv"
alias ln="ln -iv"
alias mkdir="mkdir -v"
alias rm="rm -i"
alias rmf="rm -rf"
alias p='ps axo pid,user,pcpu,comm'
alias preview='fzf --height=50% --layout=reverse --preview="bat --color=always {}"'

# --- Mkdir Aliases ---
# Make a directory and cd into it
alias mcd='mkdir -pv && cd'

# Make a directory
alias md='mkdir'

# Make a directory with date
alias mdd='mkdir -pv $(date +%Y%m%d)'

# Homebrew for Intel // Rosetta
# With this command I can download binaries for Intel Macs onto the M1 laptop
# using homebrew
alias ibrew='arch -x86_64 /usr/local/bin/brew'
alias x86='arch -x86_64'

# GCC - by default MacOS has a binary /usr/bin/gcc that just runs Clang
# These are so we can use gcc when we want to
alias gcc="gcc-13"
alias g++="g++-13"
alias cc="cc-12"
alias c++="c++-13"

# Clang Compiler
alias clng="clang++ -std=c++20 -pedantic-errors -Wall -Weffc++ -Wextra -Wconversion -Wsign-conversion -Werror -glldb"
alias clngdb="clang++ -std=c++20 -g3 -O0 -pedantic-errors -Wall -Weffc++ -Wextra -Wconversion -Wsign-conversion -Werror -glldb" 

# This command allows me to produce x86 assembly on the M1 mac. Use this
# for following along with CS:APP textbook
alias igcc="arch -x86_64 /usr/local/bin/gcc-13"


# --- Bookmarks ---
alias dl='cd ~/Downloads && ls -lA'
alias doc='cd ~/Documents && ls -lA'
alias tmp='cd ~/Temporary && ls -lA'

# --- Shortcuts ---
alias c='clear'
alias cat='bat'
alias e='exit'


# --- Aliases ---

alias vim="nvim"
alias v="nvim"
alias rm_modules="find . -name "node_modules" -type d -prune -exec rm -rf '{}' +"

# --- Config ---

# alias config="vim ~/.zshrc"
alias reload="source ~/.zshrc"
alias vimconfig="cd ~/.config/nvim ; vim"

# --- Applications ---
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"

# --- Kubernetes ---
# alias k="kubectl"

# --- Typos ---
alias :q='exit'
alias help="man"
alias quit="exit"

# --- Tmux ---
# Attaches tmux to the last session; creates a new session if none exists
# alias t = 'tmux attach || tmux new session'

# Creates a new session
alias tsn='tmux new -s'

# Attaches tmux to a session
alias tsa='tmux attach -t'

# Lists all ongoing sessions
alias tsl='tmux ls'

# Kills a tmux session
alias tsk='tmux kill-session -t'

# Kills all tmux sessions
alias tska='tmux kill-session -a'

# --- ssh ---
# Connect to the raspsberry pi server
alias 'sduexpi'='ssh -i ~/.ssh/id_pi -p 2221 conorney@duex-pi.local'

# -- docker --
alias 'dcu'='docker compose up'
alias 'dcub'='docker compose up --build'
alias 'dcd'='docker compose down'
