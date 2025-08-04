#!/bin/bash

set -euxo pipefail  # Exit on error, undefined vars; show commands

# Update and upgrade packages
apt update && apt upgrade -y

# Install prerequisite packages
apt install -y apt-transport-https ca-certificates curl gnupg lsb-release software-properties-common

# Add Docker's official GPG key securely
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
    gpg --dearmor -o /etc/apt/keyrings/docker.gpg

chmod a+r /etc/apt/keyrings/docker.gpg

# Set up the Docker repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package database with Docker packages
apt update

# Install Docker CE, CLI, and containerd
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Enable Docker to start on boot
systemctl enable docker
systemctl start docker

# Add the current user to the docker group (optional)
if id -nG "$USER" | grep -qw docker; then
    echo "User already in docker group"
else
    usermod -aG docker "$USER"
    echo "Added $USER to docker group"
fi

# Confirm Docker installation
docker --version || echo "Docker installed but might need a new login session"

# Info message
echo "✅ Docker installation is complete."
echo "ℹ️ You must log out and log back in for docker group changes to take effect."
