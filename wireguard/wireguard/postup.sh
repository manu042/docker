WIREGUARD_INTERFACE=wg0
WIREGUARD_LAN=10.0.0.0/24
MASQUERADE_INTERFACE=eth0


# Apply NAT (masquerading) to traffic from the WireGuard LAN going out through the specified interface.
# ================================================
iptables -t nat -I POSTROUTING -o $MASQUERADE_INTERFACE -j MASQUERADE -s $WIREGUARD_LAN


# Add a WIREGUARD_wg0 chain to the FORWARD chain
# ================================================
CHAIN_NAME="WIREGUARD_$WIREGUARD_INTERFACE"
iptables -N $CHAIN_NAME
iptables -A FORWARD -j $CHAIN_NAME


# Accept traffic from any Wireguard IP address connected to the Wireguard server
# ================================================
iptables -A $CHAIN_NAME -s $WIREGUARD_LAN -i $WIREGUARD_INTERFACE -j ACCEPT


# Drop everything else coming through the Wireguard interface
# ================================================
iptables -A $CHAIN_NAME -i $WIREGUARD_INTERFACE -j DROP


# Return to FORWARD chain
# ================================================
iptables -A $CHAIN_NAME -j RETURN
