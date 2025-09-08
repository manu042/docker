#!/bin/bash

# Usage: ./create_remote_user.sh <remote_host> <remote_admin_user> <new_username> <ssh_public_key_file>

REMOTE_HOST="$1"
REMOTE_ADMIN="$2"
NEW_USER="$3"
PUB_KEY_FILE="$4"

if [ $# -ne 4 ]; then
  echo "Usage: $0 <remote_host> <remote_admin_user> <new_username> <ssh_public_key_file>"
  exit 1
fi

# Prompt for the new user's password securely
read -s -p "Enter password for new user $NEW_USER: " NEW_PASS
echo

if [ -z "$NEW_PASS" ]; then
  echo "Error: Password cannot be empty."
  exit 1
fi

# Read the public key
if [ ! -f "$PUB_KEY_FILE" ]; then
  echo "Error: Public key file not found: $PUB_KEY_FILE"
  exit 1
fi
PUB_KEY_CONTENT=$(cat "$PUB_KEY_FILE")

# Run commands on the remote server
ssh "${REMOTE_ADMIN}@${REMOTE_HOST}" bash -s <<EOF
  set -e

  # Create new user if not exists
  if id "$NEW_USER" &>/dev/null; then
    echo "User $NEW_USER already exists."
  else
    sudo useradd -m -s /bin/bash "$NEW_USER"
    echo "$NEW_USER:$NEW_PASS" | sudo chpasswd
    sudo usermod -aG sudo "$NEW_USER"
    echo "User $NEW_USER created and added to sudo group."
  fi

  # Setup SSH directory
  sudo mkdir -p /home/$NEW_USER/.ssh
  echo "$PUB_KEY_CONTENT" | sudo tee /home/$NEW_USER/.ssh/authorized_keys > /dev/null
  sudo chmod 700 /home/$NEW_USER/.ssh
  sudo chmod 600 /home/$NEW_USER/.ssh/authorized_keys
  sudo chown -R $NEW_USER:$NEW_USER /home/$NEW_USER/.ssh

  echo "SSH key added for $NEW_USER."
EOF
