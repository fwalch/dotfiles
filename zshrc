#
# ~/.zshrc
#

export ZSH=$HOME/.dotfiles/zsh/oh-my-zsh
export ZSH_THEME="fwalch"

plugins=(gitfast)

# For virtual console, fall back to fwalch theme included in oh-my-zsh
if [[ $TERM != "linux" ]]; then
  export ZSH_CUSTOM=$HOME/.dotfiles/zsh/custom
fi

DISABLE_AUTO_UPDATE=true

source $ZSH/oh-my-zsh.sh

# Colors!
if [[ $TERM != "linux" ]]; then
  eval $(dircolors -b $ZSH_CUSTOM/badwolf.dircolors)
  export GREP_COLOR='01;33'

  # Use LS_COLORS for completion
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

bindkey -v

bindkey -M viins "^K" history-beginning-search-backward
bindkey -M viins "^J" history-beginning-search-forward
bindkey -M viins "^P" up-line-or-history
bindkey -M viins "^N" down-line-or-history

bindkey -M vicmd "^K" history-beginning-search-backward
bindkey -M vicmd "^J" history-beginning-search-forward
bindkey -M vicmd "^P" up-line-or-history
bindkey -M vicmd "^N" down-line-or-history
bindkey -M vicmd "?" history-incremental-search-backward
bindkey -M vicmd "/" history-incremental-search-forward

unsetopt correct_all
unsetopt auto_name_dirs
unsetopt inc_append_history
setopt append_history

#source $HOME/.dotfiles/zsh/custom/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Based on https://github.com/justinmk/config/blob/master/.bashrc#L222
ghrebasepr() {(
  set -e
  set -o pipefail
  PR=${1}
  REPO_SLUG="$(git config --get remote.upstream.url \
    | sed 's/^.*:\/\/github.com\/\(.*\)\.git/\1/')"
  PR_TITLE="$(curl -Ss "https://api.github.com/repos/${REPO_SLUG}/pulls/${PR}" \
    | jq -r '.title' \
    | sed 's/^\[\(RFC\|RDY\)\] *//')"
  git fetch --all &&
  git checkout refs/pull/upstream/${PR} &&
  git rebase upstream/master &&
  git checkout master &&
  git stash save autosave-$(date +%Y%m%d_%H%M%S) &&
  git reset --hard upstream/master &&
  git merge -m "Merge #${PR} '${PR_TITLE}'." \
    --no-ff - &&
  git log -n 5
)}

ghrebase1() {
  PR=${1}
  git fetch --all &&
  git checkout refs/pull/upstream/${PR} &&
  git rebase upstream/master &&
  git checkout master &&
  git stash save autosave-$(date +%Y%m%d_%H%M%S) &&
  git reset --hard upstream/master &&
  git merge --ff-only - &&
  git commit --amend -m "$(git log -1 --pretty=format:"%B" \
    | sed -E "1 s/^(.*)\$/\\1 #${PR}/g")" &&
  git log -n 5
}

source $HOME/.zshrc.local
