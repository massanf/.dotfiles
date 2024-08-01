#!bin/sh

# Variables.
PKGS=(
  "curl"
  "stow"
  "zsh"
  "tmux"
  "git"
  "bat"
  "cargo"
)

CONFLICT_ITEMS=(
  "$HOME/.dotfiles"
  "$HOME/.zshrc"
  "$HOME/.zshrc_local"
  "$HOME/.zprofile"
  "$HOME/.zprofile_local"
  "$HOME/.oh-my-zsh"
  "$HOME/.vim"
  "$HOME/.vimrc"
  "$HOME/.tmux"
  "$HOME/.tmux.conf"
)

# Functions.
check_item() {
    for item in "${items[@]}"; do
        expanded_item=$(eval echo "$item")  # Expand ~ to the full path
        if [ -e "$expanded_item" ] && [ ! -L "$expanded_item" ]; then
            echo "Error: $expanded_item exists."
            exit 1
        fi
    done
}

# Main.
# Define package manager command.
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    PKG_MANAGER="sudo apt update && sudo apt install -y"
elif [[ "$OSTYPE" == "linux-musl"* ]]; then
    PKG_MANAGER="sudo apk update && sudo apk add"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    if ! command -v brew &> /dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    PKG_MANAGER="brew install"
else
    echo "Unsupported OS type: $OSTYPE"
    exit 1
fi

# Check for conflict files.
for item in "${CONFLICT_ITEMS[@]}"; do
    check_item "$item" || exit 1
done

# Install packages.
pgks_string=""
for item in "${PKGS[@]}"; do
    pkgs_string+="$item "
done
$PKG_MANAGER $pkgs_string

# Clone or update dotfiles repo.
cd $HOME
if [ -d "$HOME/.dotfiles" ]; then
    cd $HOME/.dotfiles
    git pull --recurse-submodules
    git submodule update --init --recursive
else
    git clone --recurse-submodules -j8 https://github.com/massanf/.dotfiles.git
    cd $HOME/.dotfiles
fi

# Stow.
stow vim zsh tmux fzf

# Setup simlink (omz submodule -> p10k submodule).
ln -s $HOME/.dotfiles/zsh/.oh-my-zsh-powerlevel10k $HOME/.dotfiles/zsh/.oh-my-zsh/themes/powerlevel10k

# Install fzf (apt installs an older version).
$HOME/.fzf/install --bin --no-bash --no-fish

# Install Eza.
cargo install eza

# Install bat.
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo ln -s /usr/bin/batcat /usr/local/bin/bat
fi

# Install plugins for Vim.
vim +'PlugInstall --sync' +qa

# Install plugins for tmux.
$HOME/.tmux/plugins/tpm/scripts/install_plugins.sh

# Set default shell.
chsh -s $(which zsh)

# Activate zsh.
zsh
