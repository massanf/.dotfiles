#!bin/sh

# Install.
sudo apt install curl stow zsh tmux vim

# Clone dotfiles repo.
cd ~
git clone --recurse-submodules -j8 https://github.com/massanf/dotfiles.git
cd ~/dotfiles

# Stow.
stow vim zsh tmux

# Simlinks.
ln -s ~/dotfiles/zsh/.oh-my-zsh-powerlevel10k ~/dotfiles/zsh/.oh-my-zsh/themes/powerlevel10k

# Set default shell.
chsh -s /bin/zsh
