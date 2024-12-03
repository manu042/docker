# Wireguard


https://gist.github.com/qdm12/4e0e4f9d1a34db9cf63ebb0997827d0d
https://github.com/pirate/wireguard-docs


Generate QR Code:

```shell
qrencode -t ansiutf8 wg-client.conf
```



## Server Config
```conf
# WireGuard Server Configuration

[Interface]
Address = 10.0.0.1/24
ListenPort = 51820
PrivateKey = QINblxfkeBHbTdGe2bgQ32nD/O4WyFECtXirvv6GZ1I=

PostUp = iptables -A FORWARD -i %i -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE


[Peer]
PublicKey = W8AEL8IWnd/7wtID9MnCbTZ6LWMa1m0XHJdSwoHQCnM=
PresharedKey = JJ8IXdSevR0OMEhq5VcsEmiPOUXtm/3xK2EGlbDEE54=
AllowedIPs = 10.0.0.2/32
```

- `Interface`:
  - `Address`: Sets the IP address for the WireGuard interface
    - 10.0.0.1/24 means the server will have IP 10.0.0.1 with a 24-bit subnet mask (255.255.255.0)
  - `ListenPort`: The UDP port WireGuard will use to listen for incoming connections
    - 51820 is the standard WireGuard port
  - `PrivateKey`: The server's private key for encryption and authentication
  - `PostUp`:
  - `PostDown`:
- `Peer`: Section defines a specific client connecting to the WireGuard server
  - `PublicKey`: The public key of a allowed client
  - `PresharedKey`: An additional layer of pre-shared symmetric encryption
  - `AllowedIPs`: Defines the IP address range the client is allowed to use
    - It restricts which IP addresses this specific peer can access
    - 10.0.0.2/32 means exactly the IP 10.0.0.2 is allowed


## Client Config
```conf
# WireGuard Client Configuration

[Interface]
Address = 10.0.0.2/24
ListenPort = 51820
PrivateKey = KGtk00MCboJ6mflJvgTAPh21md/SH/sIqNtTqpXHTkM=
DNS = 1.1.1.1

[Peer]
PublicKey = /d/STyZwXPZL+1Clc8tU6bwuycKmtZLuGUUsMysSHR4=
PresharedKey = JJ8IXdSevR0OMEhq5VcsEmiPOUXtm/3xK2EGlbDEE54=
AllowedIPs = 0.0.0.0/0, ::/0
Endpoint = <server-public-ip>:51820
```

- `Interface`:
  - `Address`:
  - `ListenPort`:
  - `PrivateKey`:
  - `DNS`:
- `Peer`:
  - `PublicKey`:
  - `PresharedKey`:
  - `AllowedIPs`:
  - `Endpoint`:


## iptables Rule examples
`iptables` is a Linux firewall utility for configuring packet filtering rules.


This rule configures a firewall policy that allows forwarding of packets specifically through the `wg0` network interface.
```shell
iptables -A FORWARD -i wg0 -j ACCEPT
```
- `-A FORWARD`: Appends a rule to the FORWARD chain
- `-i wg0`: Specifies the input interface (in this case, a WireGuard interface)
- `-j ACCEPT`: Defines the action to jump to (in this case, accepting packets)


This rule implements Network Address Translation (NAT) to allow devices on a private network to access the internet through a single public IP address.
```shell
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
```
- `-t nat`: Specifies the table NAT (Network Address Translation)
- `-A POSTROUTING`: Appends a rule to the POSTROUTING chain
- `-o eth0`: Defines the output interface (in this case, the primary ethernet interface)
- `-j MASQUERADE`: Specifies the action of dynamically translating source addresses


This rule is adding a destination IP address constraint to the packet filtering.
```shell
iptables -A FORWARD -i wg0 -d 172.0.0.1/32 -j ACCEPT
```
- `-A FORWARD`: Appends a rule to the FORWARD chain
- `-i wg0`: Specifies the input interface (WireGuard interface)
- `-d 172.0.0.1/32`: Defines a specific destination IP address
- `-j ACCEPT`: Defines the action to jump to (accepting packets)
