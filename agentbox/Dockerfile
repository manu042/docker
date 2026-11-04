FROM debian:trixie-slim

ARG UID=1000
ARG GID=1000
ARG USERNAME=dev
ARG NODE_MAJOR=24

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        pkg-config \
        libssl-dev \
        ca-certificates \
        curl \
        git \
        openssh-client \
        less \
        tini \
        ripgrep \
        fd-find \
        jq \
        procps \
        unzip \
        xz-utils \
        python3 \
    && ln -s /usr/bin/fdfind /usr/local/bin/fd \
    && rm -rf /var/lib/apt/lists/*

# Node.js via NodeSource
RUN curl -fsSL "https://deb.nodesource.com/setup_${NODE_MAJOR}.x" | bash - \
    && apt-get install -y --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/*

# Create user with UID/GID
RUN (getent group "${GID}" || groupadd -g "${GID}" "${USERNAME}") \
    && useradd -l -m -u "${UID}" -g "${GID}" -s /bin/bash "${USERNAME}" \
    && mkdir -p /projects && chown "${UID}:${GID}" /projects

USER ${USERNAME}
WORKDIR /home/${USERNAME}

ENV PATH=/home/${USERNAME}/.local/bin:/home/${USERNAME}/.cargo/bin:${PATH} \
    NPM_CONFIG_PREFIX=/home/${USERNAME}/.local \
    CLAUDE_CONFIG_DIR=/home/${USERNAME}/.claude \
    UV_LINK_MODE=copy

# Create volume mount points, owned by the user
RUN mkdir -p ~/.local/bin ~/.claude ~/.pi ~/.cache ~/.npm ~/.cargo/registry ~/.cargo/git

# Rust
RUN curl -fsSL https://sh.rustup.rs | sh -s -- -y --profile minimal --component clippy,rustfmt --no-modify-path

# uv
RUN curl -LsSf https://astral.sh/uv/install.sh | env UV_NO_MODIFY_PATH=1 sh

# Pi Coding Agent
RUN curl -fsSL https://pi.dev/install.sh | sh

# Claude Code
# RUN curl -fsSL https://claude.ai/install.sh | sh

WORKDIR /projects
ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["sleep", "infinity"]
FROM debian:trixie-slim

ARG UID=1000
ARG GID=1000
ARG USERNAME=dev
ARG NODE_MAJOR=24

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        pkg-config \
        libssl-dev \
        ca-certificates \
        curl \
        git \
        openssh-client \
        less \
        tini \
        ripgrep \
        fd-find \
        jq \
        procps \
        unzip \
        xz-utils \
        python3 \
    && ln -s /usr/bin/fdfind /usr/local/bin/fd \
    && rm -rf /var/lib/apt/lists/*

# Node.js via NodeSource
RUN curl -fsSL "https://deb.nodesource.com/setup_${NODE_MAJOR}.x" | bash - \
    && apt-get install -y --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/*

# Create user with UID/GID
RUN (getent group "${GID}" || groupadd -g "${GID}" "${USERNAME}") \
    && useradd -l -m -u "${UID}" -g "${GID}" -s /bin/bash "${USERNAME}" \
    && mkdir -p /Projects && chown "${UID}:${GID}" /Projects

USER ${USERNAME}
WORKDIR /home/${USERNAME}

ENV PATH=/home/${USERNAME}/.local/bin:/home/${USERNAME}/.cargo/bin:${PATH} \
    NPM_CONFIG_PREFIX=/home/${USERNAME}/.local \
    CLAUDE_CONFIG_DIR=/home/${USERNAME}/.claude \
    UV_LINK_MODE=copy

# Create volume mount points, owned by the user
RUN mkdir -p ~/.local/bin ~/.claude ~/.pi ~/.cache ~/.npm ~/.cargo/registry ~/.cargo/git

# Rust
RUN curl -fsSL https://sh.rustup.rs | sh -s -- -y --profile minimal --component clippy,rustfmt --no-modify-path

# uv
RUN curl -LsSf https://astral.sh/uv/install.sh | env UV_NO_MODIFY_PATH=1 sh

# Pi Coding Agent
RUN curl -fsSL https://pi.dev/install.sh | sh

# Claude Code
# RUN curl -fsSL https://claude.ai/install.sh | sh

WORKDIR /Projects
ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["sleep", "infinity"]
