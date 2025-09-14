FROM ubuntu:24.04


# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    ca-certificates \
    curl \
    git \
    sudo \
    zsh \
    && rm -rf /var/lib/apt/lists/*


# Install code-server (standalone into /usr/local)
RUN curl -fsSL https://code-server.dev/install.sh | sh -s -- --method=standalone --prefix=/usr/local


# Remove user "ubuntu"
RUN userdel -r ubuntu


# Create user 'coder' with home directory and bash shell
RUN useradd -m -s /bin/bash coder \
    && echo "coder:coder" | chpasswd \
    && usermod -aG sudo coder


# Configure sudo: require password for coder (no NOPASSWD)
RUN echo "coder ALL=(ALL:ALL) ALL" > /etc/sudoers.d/coder && chmod 0440 /etc/sudoers.d/coder


# Create /workspace directory and give permissions to coder
RUN mkdir -p /home/coder/workspace \
    && chown coder:coder /home/coder/workspace \
    && chmod 755 /home/coder/workspace


# Copy entrypoint
COPY --chmod=755 entrypoint.sh /usr/local/bin/entrypoint.sh


# Start as root (so entrypoint can set password)
USER root
WORKDIR /home/coder


# Expose code-server default port
EXPOSE 8080


# CMD ["tail", "-f", "/dev/null"]
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
