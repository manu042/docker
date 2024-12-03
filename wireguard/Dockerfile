FROM ubuntu:25.04


# ==== Set a non-interactive frontend to avoid prompts during installation ====
ENV DEBIAN_FRONTEND=noninteractive


# ==== Update and install necessary packages ====
RUN apt-get update && apt-get install -y --no-install-recommends \
    dnsmasq \
    dnsutils \
    iproute2 \
    iptables \
    net-tools \
    qrencode \
    wireguard-tools 
    # && \
    # apt-get clean && rm -rf /var/lib/apt/lists/*


# Enable IPv4 forwarding
# and create a backup of dnsmasq.conf
RUN echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf && sysctl -p && \
    cp /etc/dnsmasq.conf /etc/dnsmasq.conf.backup


# ==== Copy the dnsmasq config files ====
COPY ./dnsmasq/dnsmasq.conf /etc/dnsmasq.conf
COPY ./dnsmasq/local_dns.conf /etc/dnsmasq.d/dnsmasq.conf


# ==== Copy the wiregurad config files and ensure the script are executable ====
COPY ./wireguard /etc/wireguard
RUN chmod +x /etc/wireguard/postup.sh && chmod +x /etc/wireguard/postdown.sh


# ==== Copy the entrypoint script and ensure the script is executable ====
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh


# ==== Use the entrypoint script ====
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]


# ==== Expose the WireGuard port ====
EXPOSE 51820/udp


# CMD [ "tail", "-f", "/dev/null" ]
