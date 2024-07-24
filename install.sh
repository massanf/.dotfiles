#!bin/sh

# Install.
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo apt update
    sudo apt install -y curl stow zsh tmux vim
elif [[ "$OSTYPE" == "darwin"* ]]; then
    if ! command -v brew &> /dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew install curl stow zsh tmux vim
fi

# Clone dotfiles repo.
cd ~
git clone --recurse-submodules -j8 https://github.com/massanf/dotfiles.git
cd ~/dotfiles

# Stow.
stow vim zsh tmux

# Simlinks (omz submodule -> p10k submodule).
ln -s ~/dotfiles/zsh/.oh-my-zsh-powerlevel10k ~/dotfiles/zsh/.oh-my-zsh/themes/powerlevel10k

# Set default shell.
sudo chsh -s /bin/zsh

# Run `:PlugInstall`.
vim +'PlugInstall --sync' +qa
