#
# .zshenv
#

WWW_HOME=https://duckduckgo.com
EDITOR=vim

export EDITOR WWW_HOME

if [[ $TERM == "linux" ]]; then
  export BROWSER=lynx
fi
