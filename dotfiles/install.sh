!#/bin/bash

# This script is intended to be run on a WSL environment to set up the necessary configurations and install required tools.

# Update and upgrade the system packages
sudo apt update && sudo apt upgrade -y

# Install necessary packages for Python development and other tools
sudo apt install python3-pip -y
sudo apt install python3-venv -y

# Install Docker
sudo apt-get remove docker docker-engine docker.io containerd runc -y
sudo apt-get update -y

if ! command -v docker &> /dev/null; then
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    rm get-docker.sh
fi

sudo usermod -aG docker $USER
newgrp docker

# Clean up unnecessary packages and cache
sudo apt clean
sudo apt autoremove --purge -y

# Configure Git with global settings
git config --global user.name "Mukesh Singla"
git config --global user.email "er.mukesh.singla@gmail.com"
git config --global init.defaultBranch main
git config --global core.editor "code --wait"
git config --global core.autocrlf input

# Append the contents of .aliases and .bashrc from the wsl directory to the user's .bashrc
cat ~/playground/git-repo/homelab/dotfiles/wsl/.aliases >> ~/.bashrc
cat ~/playground/git-repo/homelab/dotfiles/wsl/.bashrc >> ~/.bashrc

# Source the updated .bashrc to apply the changes immediately
source ~/.bashrc

# Test the connection to the Ollama API
curl http://192.168.0.100:11434/api/tags

# Install Claude CLI tool
curl -fsSL https://claude.ai/install.sh | bash

# Start the Docker service if it's not already running
if (! systemctl is-active --quiet docker) && (! service docker status > /dev/null 2>&1); then
    sudo service docker start
fi

# Source the updated .bashrc to apply the changes immediately
source ~/.bashrc

cp ~/playground/git-repo/homelab/dotfiles/host/.wslconfig /mnt/c/Users/mukes/.wslconfig