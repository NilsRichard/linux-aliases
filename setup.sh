#!/bin/bash

set -e

echo "Starting setup..."

# Update package list once
sudo apt update

# Install zsh if missing
if ! command -v zsh >/dev/null 2>&1; then
  echo "Installing zsh..."
  sudo apt install -y zsh
else
  echo "zsh already installed, skipping..."
fi

# Install git if missing
if ! command -v git >/dev/null 2>&1; then
  echo "Installing git..."
  sudo apt install -y git
else
  echo "git already installed, skipping..."
fi

# Install curl if missing (needed for downloads)
if ! command -v curl >/dev/null 2>&1; then
  echo "Installing curl..."
  sudo apt install -y curl
else
  echo "curl already installed, skipping..."
fi

# Install Oh My Zsh if not installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  export RUNZSH=no
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "Oh My Zsh already installed, skipping..."
fi

# Set Zsh theme to bureau in .zshrc (add or replace)
if grep -q '^ZSH_THEME=' ~/.zshrc; then
  sed -i 's/^ZSH_THEME=.*/ZSH_THEME="bureau"/' ~/.zshrc
else
  echo 'ZSH_THEME="bureau"' >> ~/.zshrc
fi
echo "Set Zsh theme to bureau."

# Install Docker if missing
if ! command -v docker >/dev/null 2>&1; then
  echo "Installing Docker..."
  curl -fsSL https://get.docker.com | sh
else
  echo "Docker already installed, skipping..."
fi

# Add current user to docker group if not already a member
if groups "$USER" | grep -qw docker; then
  echo "User $USER is already in the docker group."
else
  echo "Adding user $USER to docker group..."
  sudo usermod -aG docker "$USER"
fi

# Download the aliases file, overwrite if exists
echo "Downloading .aliases file..."
curl -fsSL https://raw.githubusercontent.com/NilsRichard/linux-aliases/refs/heads/main/.aliases -o ~/.aliases

# Source .aliases in .zshrc if not already present
if grep -qxF 'source ~/.aliases' ~/.zshrc; then
  echo ".aliases already sourced in .zshrc"
else
  echo 'source ~/.aliases' >> ~/.zshrc
  echo "Added source ~/.aliases to .zshrc"
fi

echo "Setup complete! Please restart your shell or run 'exec zsh' to apply changes."
