## Prerequisites
- stow (brew)
- zsh (brew)
  - `chsh -s /bin/zsh`
  - oh-my-zsh (cli)
  - powerlevel10k (cli)
- tmux (brew)
  - iceberg_minimal (installed)
- vim (brew)
  - `:PlugInstall`

## stow
Link `~/.vimrc` to `~/dotfiles/vim/.vimrc`, etc.
```sh
cd ~/dotfiles
stow [zsh|tmux|vim|p10k]
```

