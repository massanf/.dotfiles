## Cloning
```
git clone --recurse-submodules -j8 https://github.com/massanf/dotfiles.git
```

## Prerequisites
- git curl stow (brew/apt)
- zsh (brew/apt)
  - `chsh -s /bin/zsh`
  - oh-my-zsh (cli)
  - powerlevel10k (cli)
- tmux (brew/apt)
  - tpm (installed) `C-b I` 
  - iceberg_minimal (installed)
- vim (brew)
  - Vim Plug `:PlugInstall`

## stow
Link `~/.vimrc` to `~/dotfiles/vim/.vimrc`, etc.
```sh
cd ~/dotfiles
stow [zsh|tmux|vim|p10k]
```

