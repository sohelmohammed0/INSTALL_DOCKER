#!/bin/bash

# Update and upgrade packages
sudo apt update && sudo apt upgrade -y

# Install prerequisite packages
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Set up the Docker repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package database with Docker packages
sudo apt update

# Install Docker CE, CLI, and containerd
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Add the current user to the docker group
sudo usermod -aG docker $USER

# Print Docker version to verify installation
docker --version

echo "Docker installation is complete. Please log out and back in or restart your session for the group changes to take effect."
