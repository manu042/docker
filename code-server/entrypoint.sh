#!/usr/bin/env bash
set -e

CONFIG_FILE="/home/coder/.config/code-server/config.yaml"

TARGET_UID=${CODER_UID:-1000}
TARGET_GID=${CODER_GID:-1000}

CURRENT_UID=$(id -u coder)
CURRENT_GID=$(id -g coder)

# Update GID if needed
if [ "$CURRENT_GID" -ne "$TARGET_GID" ]; then
    groupmod -g "$TARGET_GID" coder
fi

# Update UID if needed
if [ "$CURRENT_UID" -ne "$TARGET_UID" ]; then
    usermod -u "$TARGET_UID" coder
    # Important: fix ownership
    chown -R "$TARGET_UID":"$TARGET_GID" /home/coder /home/coder/workspace
fi

# If SUDO_PASSWORD_HASH env is provided, set password for the user coder to it
if [ -n "${SUDO_PASSWORD_HASH}" ]; then
  echo "Setting password for coder using provided hash..."
  echo "coder:${SUDO_PASSWORD_HASH}" | chpasswd -e
fi

# Ensure code-server config directory exists
mkdir -p /home/coder/.config/code-server

# If HASHED_PASSWORD is set, configure code-server to use it
if [ -n "${HASHED_PASSWORD}" ]; then
  echo "Configuring code-server to use HASHED_PASSWORD..."
  cat > "$CONFIG_FILE" <<EOF
bind-addr: 0.0.0.0:8080
auth: password
hashed-password: ${HASHED_PASSWORD}
EOF
  chown coder:coder "$CONFIG_FILE"
fi

# Drop privileges and run as user 'coder'
exec /bin/su - coder -c "code-server --disable-telemetry"
