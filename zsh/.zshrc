# zsh location.
export ZSH=$HOME/.oh-my-zsh

# Theme.
ZSH_THEME="powerlevel10k/powerlevel10k"
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
[[ ! -f $HOME/.p10k.zsh ]] || source $HOME/.p10k.zsh

# Other settings.
export LANG=en_US.UTF-8
plugins=(git)
source $ZSH/oh-my-zsh.sh

# bat conflicts with another package on linux.
alias bat='batcat'

# Load .zshrc_local.
source $HOME/.zshrc_local
