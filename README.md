## Prerequisites
- stow (brew)
- zsh (brew)
  - oh-my-zsh (cli)
  - powerlevel10k (cli)
- tmux
  - iceberg_minimal (installed)
- vim
  - `:PlugInstall`

## stow
Link `~/.vimrc` to `~/dotfiles/vim/.vimrc`, etc.
```
cd ~/dotfiles
stow [zsh|tmux|vim|p10k]
```

