#!bin/sh

# Exit on error.
set -e

# Variables.
PKGS=(
  "curl"
  "stow"
  "zsh"
  "tmux"
  "git"
  "bat"
  "ripgrep"
  "neovim"
)

CONFLICT_ITEMS=(
  "$HOME/.dotfiles"
  "$HOME/.zshrc"
  "$HOME/.zshrc_local"
  "$HOME/.zprofile"
  "$HOME/.zprofile_local"
  "$HOME/.oh-my-zsh"
  "$HOME/.nvim"
  "$HOME/.config"
  "$HOME/.tmux"
  "$HOME/.tmux.conf"
)

# Logger.
log_and_run() {
    printf "\n\n\n============================================================\n"
    printf "[INFO] Running command: $*\n"
    printf "============================================================\n"
    eval "$*"
}

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
log_and_run "$PKG_MANAGER $pkgs_string"

# Clone or update dotfiles repo.
cd $HOME
if [ -d "$HOME/.dotfiles" ]; then
    log_and_run "cd $HOME/.dotfiles && git pull --recurse-submodules && git submodule update --init --recursive"
else
    log_and_run "git clone --recurse-submodules -j8 https://github.com/massanf/.dotfiles.git && cd $HOME/.dotfiles"
fi

# Stow.
log_and_run "stow nvim zsh tmux fzf git"

# Setup simlink (omz submodule -> p10k submodule).
log_and_run "ln -sf $HOME/.dotfiles/zsh/.oh-my-zsh-powerlevel10k $HOME/.dotfiles/zsh/.oh-my-zsh/themes/powerlevel10k"

# Exclude iSH (not supported).
if [[ "$OSTYPE" != "linux-musl"* ]]; then
  # Install rust.
  log_and_run "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y"
  # Install Eza.
  log_and_run "cargo install eza git-delta"
  # Install fzf (apt installs an older version).
  log_and_run "$HOME/.fzf/install --bin --no-bash --no-fish"
fi

# Install bat.
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    log_and_run "sudo ln -sf /usr/bin/batcat /usr/local/bin/bat"
fi

# Install plugins for Vim.
log_and_run "nvim --headless -u ~/.config/nvim/init.lua -c 'autocmd User PackerComplete quitall' -c 'PackerSync'"

# Install nerdfont.
log_and_run "git clone https://github.com/ryanoasis/nerd-fonts.git"
log_and_run "$HOME/nerd-fonts/install.sh Hack"

# Install plugins for tmux.
log_and_run "$HOME/.tmux/plugins/tpm/scripts/install_plugins.sh"

# Set default shell.
log_and_run "chsh -s $(which zsh)"

# Activate zsh.
log_and_run "zsh"
