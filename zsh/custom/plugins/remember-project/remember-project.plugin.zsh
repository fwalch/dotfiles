# Slightly modified version of
# http://robots.thoughtbot.com/post/17712589200/run-a-command-every-time-you-change-directories-in-zsh

export CURRENT_PROJECT_PATH=$HOME/.current-project

function chpwd {
#  if [[ (-d '.git') || (-d '.svn') || (-d '.hg') || (-d '.bzr') ]]; then
    echo $(pwd) >! $CURRENT_PROJECT_PATH
#  fi
}

remember-project_cd() {
  if [[ -f $CURRENT_PROJECT_PATH ]]; then
    cd "$(cat $CURRENT_PROJECT_PATH)"
  fi
}

remember-project_cd
