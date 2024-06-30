#!/bin/bash
# === Settings ===
PACKAGES_TO_INSTALL=("zsh" "vim" "tmux" "stow")
DOTFILES=("vim" "zsh" "tmux")

# === Install packages ===
# Function to check if a package is installed
is_installed() {
  command -v $1 >/dev/null 2>&1
}

# Function to install packages
install_packages() {
  # Update package list and install packages based on OS
  if [ -f /etc/debian_version ]; then
    # For Debian-based systems
    sudo apt-get update
    for PACKAGE in "${PACKAGES_TO_INSTALL[@]}"; do
      if ! is_installed $PACKAGE; then
        echo "Installing $PACKAGE..."
        sudo apt-get install -y $PACKAGE
      else
        echo "$PACKAGE is already installed."
      fi
    done
  elif [ -f /etc/redhat-release ]; then
    # For Red Hat-based systems
    for PACKAGE in "${PACKAGES_TO_INSTALL[@]}"; do
      if ! is_installed $PACKAGE; then
        echo "Installing $PACKAGE..."
        sudo yum install -y $PACKAGE
      else
        echo "$PACKAGE is already installed."
      fi
    done
  elif [ "$(uname)" == "Darwin" ]; then
    # For macOS
    for PACKAGE in "${PACKAGES_TO_INSTALL[@]}"; do
      if ! is_installed $PACKAGE; then
        echo "Installing $PACKAGE..."
        brew install $PACKAGE
      else
        echo "$PACKAGE is already installed."
      fi
    done
  else
    echo "Unsupported OS. Please install ${PACKAGES_TO_INSTALL[@]} manually."
    exit 1
  fi
}

# Install necessary packages
install_packages

# === stow === 
# Change to the dotfiles directory
DOTFILES_DIR=~/dotfiles
cd $DOTFILES_DIR

# List of directories to stow

# Stow each directory
for DOTFILE in "${DOTFILES[@]}"; do
  stow -v $DOTFILE
done
