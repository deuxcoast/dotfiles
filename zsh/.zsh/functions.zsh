# `Ctrl-H` keybinding to launch the widget (this widget works only on zsh, don't know how to do it on bash and fish (additionaly pressing`ctrl-backspace` will trigger the widget to be executed too because both share the same keycode)
bindkey '^h' fzf-man-widget
zle -N fzf-man-widget
# Icon used is nerdfont

# This prevents a conflict between zsh-vi-mode and FZF CTRL-R history keybinding
function zvm_after_init() {
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
}

# Man without options will use fzf to select a page
# function man(){
# 	MAN="/usr/bin/man"
# 	if [ -n "$1" ]; then
# 		$MAN "$@"
# 		return $?
# 	else
# 		$MAN -k . | fzf --reverse --preview="echo {1,2} | sed 's/ (/./' | sed -E 's/\)\s*$//' | xargs $MAN" | awk '{print $1 "." $2}' | tr -d '()' | xargs -r $MAN
# 		return $?
# 	fi
# }
# Create a symlink for the provided files in ~/.local/bin
binify() {
  for arg; do
    ln -s "$PWD/$arg" "$HOME/.local/bin/$arg"
  done
}

# Create a new directory and enter it
mkd() {
    mkdir -p "$@" && cd "$@"
}

# Print README file
readme() {
  for readme in {readme,README}.{md,MD,markdown,mkd,txt,TXT}; do
    if [[ -x "${command -v glow}" ]] && [[ -f "$readme" ]]; then
      mdv "$readme"
    elif [[ -f "$readme" ]]; then
      cat "$readme"
    fi
  done
}

# Weather
weather() {
  curl -s "https://wttr.in/${1:-Ponorogo}?m2F&format=v2"
}

# Get information about IP address
ip-address() {
  curl -s -H "Accept: application/json" "https://ipinfo.io/${1:-}" | jq "del(.loc, .postal, .readme)"
}

# Incognito mode
incognito() {
  unset HISTFILE
  if [ -x "$(command -v tmux)" ]; then
    tmux set-option window-status-current-format "#[fg=brightwhite,bg=#b487b4] #I #[fg=brightwhite,bg=#966396] #W "
  fi
}

# Git commit browser
fshow() {
    local commit_hash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
    local view_commit="$commit_hash | xargs -I % sh -c 'git show --color=always % | diff-so-fancy'"
    git log --color=always \
        --format="%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" "$@" | \
    fzf --no-sort --tiebreak=index --no-multi --reverse --ansi \
        --header="enter to view, alt-y to copy hash" --preview="$view_commit" \
        --bind="enter:execute:$view_commit | less -R" \
        --bind="alt-y:execute:$commit_hash | xclip -selection clipboard"
}

# Remove all commit in Git
git-remove-all-commit() {
    local branch
    branch=$(git symbolic-ref --short HEAD)
    echo -e "\nDo you want to remove all your commit in \033[1m$branch\033[0m branch? [Y/n] "
    read -r response
    case "$response" in
        [yY][eE][sS]|[yY])
            git checkout --orphan latest_branch
            git add -A
            git commit -am "Initial commit"
            git branch -D "$branch"
            git branch -m "$branch"
            echo -e "\nTo force update your repository, run this command:\n\n    git push -fu origin $branch"
            ;;
        *)
            echo "Cancelled."
            ;;
    esac
}

function tmuxx()
{
    if [[ $# == 0 ]] && command tmux ls >& /dev/null; then
        command tmux attach \; choose-tree -s
    else
        command tmux "$@"
    fi
}

# ripgrep using fzf ui and bat preview
function rgf()
{
    rg --line-number --no-heading --color=always --smart-case "$@" | fzf -d ':' -n 2.. --ansi --no-sort --preview-window 'down:20%:+{2}' --preview 'bat --style=numbers --color=always --highlight-line {2} {1}'
}
