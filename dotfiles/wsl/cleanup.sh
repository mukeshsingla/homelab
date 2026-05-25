!#/bin/bash

# This script is intended to be run on a WSL environment to clean up unnecessary packages and configurations after the initial setup.

# Clean up APT cache and remove unnecessary packages
sudo apt clean
sudo apt autoremove --purge -y

# Remove cached files and directories that are no longer needed
rm -rf ~/.cache/*
rm -rf ~/.local/share/pip/*
rm -rf ~/.npm

