## Cloning
```
git clone --recurse-submodules -j8 https://github.com/massanf/dotfiles.git
```

## Prerequisites
- stow (brew/apt)
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

## Procedure
```sh
cd ~
git clone --recurse-submodules -j8 https://github.com/massanf/dotfiles.git
brew install stow zsh tmux vim
stow zsh tmux vim p10k
chsh -s /bin/zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```
