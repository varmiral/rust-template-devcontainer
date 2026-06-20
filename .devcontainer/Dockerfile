ARG USERNAME=vscode

FROM debian:trixie AS base

RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    curl \
    wget \
    ca-certificates \
    git \
    git-lfs \
    openssh-client \
    gnupg \
    nano \
    build-essential \
    cmake \
    ninja-build \
    procps \
    htop \
    lsof \
    jq \
    && rm -rf /var/lib/apt/lists/*

ARG USERNAME
ARG USER_UID=1000
ARG USER_GID=1000

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m -s /bin/bash $USERNAME \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME


FROM varmiral/debian-vscode:trixie AS development

RUN apt-get update && apt-get install -y --no-install-recommends \
    pkg-config \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

ARG USERNAME
USER $USERNAME

ENV RUSTUP_HOME=/home/$USERNAME/.rustup
ENV CARGO_HOME=/home/$USERNAME/.cargo

RUN curl --proto '=https' --tlsv1.2 -sSf -o /tmp/rustup.sh https://sh.rustup.rs \
    && sh /tmp/rustup.sh -y --no-modify-path --component rust-src \
    && rm /tmp/rustup.sh

ENV PATH=$CARGO_HOME/bin:$PATH

RUN rustup toolchain install nightly --component rust-src

# RUN rustup +nightly target add x86_64-pc-windows-gnu \
#     && sudo apt-get update && sudo apt-get install -y \
#     gcc-mingw-w64-x86-64 \
#     && sudo rm -rf /var/lib/apt/lists/*

RUN mkdir -p $CARGO_HOME/registry $CARGO_HOME/git/db
