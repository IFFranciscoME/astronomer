
#!/bin/bash
echo "Starting Progression's Server Script"

# ########################## Swap configuration (1 GB of memory) #########################

SWAP_FILE_SIZE="4GB"
SWAPPINESS=10

echo "Setting up a swap file (size: $SWAP_FILE_SIZE, swappiness: $SWAPPINESS)..."

# Create the swap file
sudo fallocate -l ${SWAP_FILE_SIZE} /swapfile

# Only root should be able to access to this file
sudo chmod 600 /swapfile

# Define the file as swap space
sudo mkswap /swapfile

# Enable the swap file, allowing the system to start using it
sudo swapon /swapfile

# Make the swap file permanent, otherwise, previous settings will be lost on reboot
# Create a backup of the existing fstab, JustInCase(tm)
sudo cp /etc/fstab /etc/fstab.bak
# Add the swap file information at the end of the fstab
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

# Adjust the swappiness
# With the default value of 10, the host will use swap if it has almost no other choice. Value is between 0 and 100.
# 100 will make the host use the swap as much as possible, 0 will make it use only in case of emergency.
# As swap access is slower than RAM access, having a low value here for a server is better.
sudo sysctl vm.swappiness=${SWAPPINESS}

# Make this setting permanent, to not lose it on reboot
sudo cp /etc/sysctl.conf /etc/sysctl.conf.bak
echo "vm.swappiness=${SWAPPINESS}" | sudo tee -a /etc/sysctl.conf

echo "Swap created" >> /var/log/startup-script.log

# ########################## Install Docker #########################

# https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-using-the-convenience-script
sudo apt update
curl -fsSL get.docker.com -o get-docker.sh
sudo sh get-docker.sh
rm get-docker.sh

# install using apt repository
# Add Docker's official GPG key:
# sudo apt-get update
# sudo apt-get install ca-certificates curl
# sudo install -m 0755 -d /etc/apt/keyrings
# sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
# sudo chmod a+r /etc/apt/keyrings/docker.asc

# # Add the repository to Apt sources:
# echo \
#   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
#   $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
#   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# sudo apt-get update

# sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Allow using docker without sudo
sudo usermod -aG docker $(whoami)

# https://success.docker.com/article/how-to-setup-log-rotation-post-installation
echo '{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "5"
  }
}
' | sudo tee /etc/docker/daemon.json

sudo service docker restart # restart the daemon so the settings take effect

echo "Docker installed and user added to docker group" >> /var/log/startup-script.log


# ###################

# Create new user
# Create a new user (replace 'username' with the desired username)
sudo adduser --disabled-password --gecos "" ubuntu

# Add the new user to the docker group
sudo usermod -aG docker ubuntu

# Set up SSH access for the new user
sudo mkdir -p /home/ubuntu/.ssh
sudo cp /root/.ssh/authorized_keys /home/ubuntu/.ssh/
sudo chown -R ubuntu:ubuntu /home/ubuntu/.ssh
sudo chmod 700 /home/ubuntu/.ssh
sudo chmod 600 /home/ubuntu/.ssh/authorized_keys

