#!/bin/bash

set -e  # Exit immediately if any command exits with a non-zero status.


echo "=== Uninstalling conflicting Docker packages ==="
sudo apt-get remove -y docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc


echo "=== Installing prerequisites ==="
sudo apt-get update -y
sudo apt-get install -y ca-certificates curl


echo "=== Adding Docker's official GPG key ==="
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc


echo "=== Adding Docker repository to APT sources ==="
DOCKER_REPO="https://download.docker.com/linux/ubuntu"
VERSION_CODENAME=$(lsb_release -cs)
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] $DOCKER_REPO $VERSION_CODENAME stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y


echo "=== Installing Docker and related components ==="
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin


echo "=== Hardening SSH configuration ==="
SSH_CONFIG="/etc/ssh/sshd_config"
function update_ssh_config {
    sudo sed -i -e "/^#\?$1/s/^.*$/$1 $2/" "$SSH_CONFIG"
}

update_ssh_config "PermitRootLogin" "no"
update_ssh_config "PasswordAuthentication" "no"
update_ssh_config "MaxAuthTries" "3"
update_ssh_config "LoginGraceTime" "60"
update_ssh_config "X11Forwarding" "no"
update_ssh_config "AllowAgentForwarding" "no"
update_ssh_config "KbdInteractiveAuthentication" "no"
update_ssh_config "ChallengeResponseAuthentication" "no"
update_ssh_config "KerberosAuthentication" "no"
update_ssh_config "GSSAPIAuthentication" "no"

echo "Restarting SSH service to apply changes."
sudo systemctl restart sshd

echo "=== Script execution completed successfully ==="
