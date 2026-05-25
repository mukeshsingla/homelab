!#/bin/bash

# This script is intended to be run on a WSL environment to set up the necessary configurations and install required tools.
sudo apt update && sudo apt upgrade -y
sudo apt install python3-pip -y
sudo apt install python3-venv -y

sudo apt clean
sudo apt autoremove --purge -y

# Configure Git with global settings
git config --global user.name "Mukesh Singla"
git config --global user.email "er.mukesh.singla@gmail.com"
git config --global init.defaultBranch main
git config --global core.editor "code --wait"
git config --global core.autocrlf input

# Test the connection to the Ollama API
curl http://192.168.0.100:11434/api/tags

# Install Claude CLI tool
curl -fsSL https://claude.ai/install.sh | bash

# Append the contents of .aliases and .bashrc from the wsl directory to the user's .bashrc
cat ~/playground/git-repo/homelab/dotfiles/wsl/.aliases >> ~/.bashrc
cat ~/playground/git-repo/homelab/dotfiles/wsl/.bashrc >> ~/.bashrc

# Source the updated .bashrc to apply the changes immediately
source ~/.bashrc

cp ~/playground/git-repo/homelab/host/.wslconfig /mnt/c/Users/mukes/.wslconfig