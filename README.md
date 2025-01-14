# Docker Installation Script

This guide provides step-by-step instructions to install Docker on an Ubuntu system using a simple shell script. The script updates packages, installs Docker, and configures the system to allow Docker commands to be run without `sudo`.

---

## Features of the Script
- Updates and upgrades system packages.
- Installs prerequisites for Docker.
- Configures Docker’s official package repository.
- Installs Docker CE (Community Edition), CLI, and containerd.
- Adds the current user to the `docker` group to allow non-root Docker access.
- Verifies the Docker installation.

---

## How to Use the Script

### 1. Download the Script
Create a new file to hold the script:
```bash
vi install_docker.sh
```
Copy and paste the script below into the file:
```bash
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
```
Save and exit the editor by pressing `CTRL+O`, `Enter`, and `CTRL+X`.

### 2. Make the Script Executable
Run the following command to make the script executable:
```bash
chmod +x install_docker.sh
```

### 3. Execute the Script
Run the script with superuser permissions:
```bash
sudo ./install_docker.sh
```

### 4. Restart Your Session
Log out and log back in, or restart your terminal session to apply group changes.

### 5. Verify Docker Installation
Run the following command to test Docker:
```bash
docker run hello-world
```
If successful, Docker will pull the `hello-world` image and run it in a container.

---

## Additional Information
- **Prerequisites**: Ensure your system is running Ubuntu and has an active internet connection.
- **What the Script Does**: It configures your system to install Docker from the official Docker repository, ensuring you get the latest and most secure version.
- **Security Note**: Adding a user to the `docker` group allows that user to execute commands with root privileges within Docker. Use this feature responsibly.

---

## Troubleshooting
If you encounter issues:
1. Ensure your system is up to date:
   ```bash
   sudo apt update && sudo apt upgrade -y
   ```
2. Verify your user is in the `docker` group:
   ```bash
   groups $USER
   ```
   If you don’t see `docker` in the output, run:
   ```bash
   sudo usermod -aG docker $USER
   ```
   Then log out and log back in.
3. Check the Docker service status:
   ```bash
   sudo systemctl status docker
   ```

---

## Uninstallation
To uninstall Docker and remove all related components:
```bash
sudo apt purge -y docker-ce docker-ce-cli containerd.io
sudo rm -rf /var/lib/docker
sudo rm -rf /etc/docker
sudo rm /usr/share/keyrings/docker-archive-keyring.gpg
```

---

## References
- [Docker Official Documentation](https://docs.docker.com/)
- [Docker CE for Ubuntu](https://docs.docker.com/engine/install/ubuntu/)

---

This script simplifies the process of setting up Docker on Ubuntu, making it accessible for beginners and experts alike.

