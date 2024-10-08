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

# Copy file contents to clipboard
cpf() {
    cat $1 | pbcopy
}

cpcwd() {
  pwd | pbcopy
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

git_history_browse() {
  local out sha q
  while out=$(
      git log --graph --color=always \
          --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" |
      fzf --ansi --multi --reverse --query="$q" --print-query); do
    q=$(head -1 <<< "$out")
    while read sha; do
      [ -n "$sha" ] && git show --color=always $sha | less -R
    done < <(sed '1d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
  done
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
