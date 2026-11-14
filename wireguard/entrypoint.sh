#!/bin/bash
set -e

# Check if the configuration file exists
WG_CONFIG="/etc/wireguard/wg0.conf"
if [ ! -f "$WG_CONFIG" ]; then
  echo "Configuration file $WG_CONFIG not found!"
  exit 1
fi

# Bring up the WireGuard interface
echo "Starting WireGuard..."
wg-quick up wg0

# Run dnsmasq in the foreground as the main process.
# It keeps the container alive and receives the stop signal directly.
echo "WireGuard is running. Starting dnsmasq..."
exec dnsmasq -k

# Alternative without dnsmasq: keep the container running with a dummy process
# echo "WireGuard is running. Keeping the container alive..."
# tail -f /dev/null
