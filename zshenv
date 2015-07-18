#
# .zshenv
#

WWW_HOME=https://duckduckgo.com
EDITOR=vi

export EDITOR WWW_HOME

if [[ $TERM == "linux" ]]; then
  export BROWSER=lynx
fi
