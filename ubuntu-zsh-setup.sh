#!/bin/bash

# Function to pause until a key is pressed
pause() {
  read -n1 -r -p "Press any key to continue..." key
  echo ""
}

# Function to check and install a package if not installed
install_if_not_installed() {
  local package=$1
  dpkg -l | grep -qw "$package" || {
    echo "Installing $package..."
    sudo apt update
    sudo apt install -y "$package"
  }
}

echo "Starting setup for Zsh and Oh My Zsh on your Ubuntu server."

# Step 1: Check and install Git
echo "Step 1: Checking for Git..."
install_if_not_installed git
pause

# Step 2: Check and install Curl
echo "Step 2: Checking for Curl..."
install_if_not_installed curl
pause

# Step 3: Check and install Zsh
echo "Step 3: Checking for Zsh..."
install_if_not_installed zsh
pause

# Step 4: Set Zsh as the default shell
echo "Step 4: Setting Zsh as the default shell..."
if [[ $SHELL != *zsh ]]; then
  chsh -s "$(which zsh)"
  echo "Default shell changed to Zsh. Log out and back in to apply the changes."
else
  echo "Zsh is already the default shell."
fi
pause

# Step 5: Install Oh My Zsh
echo "Step 5: Installing Oh My Zsh..."
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "Oh My Zsh is already installed."
fi

echo "Setup completed!"
