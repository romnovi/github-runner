# Example: Custom GitHub Runner with additional tools
# This demonstrates how to extend the base github-runner image

FROM ghcr.io/romnovi/github-runner:latest

# Switch to root to install additional packages
USER root

# Update package lists and upgrade existing packages
# Note: --allow-releaseinfo-change handles repository codename transitions
RUN apt-get update --allow-releaseinfo-change && apt-get upgrade -y

# Install additional tools your workflows might need
# Example: Node.js, Python packages, AWS CLI, etc.
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js from NodeSource (more reliable than distro packages)
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install Python and pip
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

# Install additional Python packages
# Note: --break-system-packages is safe in containers and needed for Python 3.11+
RUN pip3 install --no-cache-dir --break-system-packages \
    awscli \
    requests

# Install global npm packages
RUN npm install -g yarn

# Add any custom scripts or tools
# COPY custom-script.sh /usr/local/bin/
# RUN chmod +x /usr/local/bin/custom-script.sh

# Switch back to docker user
USER docker

# The entrypoint from the base image will be inherited

