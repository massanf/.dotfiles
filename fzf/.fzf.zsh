# Setup fzf
# ---------
if [[ ! "$PATH" == */home/mfujita/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/mfujita/.fzf/bin"
fi

source <(fzf --zsh)
