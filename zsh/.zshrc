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

# Fzf settings.
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh
export FZF_DEFAULT_OPTS=' --height=40%'
export FZF_CTRL_R_OPTS=''
export FZF_CTRL_T_OPTS='--preview="bat --color=always {}" --preview-window=right:50%'
export FZF_TMUX_OPTS='-p 80%'

# Alias.
alias ls="eza -alh"
alias vim="nvim"
alias tmux="sh $HOME/launch_tmux.sh"

# Load .zshrc_local.
source $HOME/.zshrc_local
