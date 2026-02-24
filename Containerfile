FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# ---- Base packages ----
RUN apt-get update && apt-get install -y \
    sudo \
    curl \
    git \
    pipx \
    ca-certificates \
    python3-virtualenv \
    wireshark \
    python3-pip \
    unzip \
    less \
    vim \
    tshark \
    nmap \
    binwalk \
    gnupg \
    build-essential \
    adb \
    && rm -rf /var/lib/apt/lists/*

# ---- Sudo for ubuntu user ----
RUN echo "ubuntu ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ubuntu \
    && chmod 0440 /etc/sudoers.d/ubuntu

# ---- Switch user ----
USER ubuntu

# Pipx install 
RUN pipx install frida-tools 
RUN pipx install impacket

# ---- Install Copilot CLI ----
RUN curl -fsSL https://gh.io/copilot-install | bash

# ---- Get nice shell ----
COPY --chown=ubuntu:ubuntu .bashrc /home/ubuntu/

# ---- Entrypoint in working directory ----
ENTRYPOINT ["/bin/bash", "-lc", "cd \"$(find /home/ubuntu -mindepth 1 -maxdepth 1 -type d ! -name '.copilot' | head -n1)\" && exec bash"]
