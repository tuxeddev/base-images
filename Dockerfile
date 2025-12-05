# hadolint ignore=DL3007
FROM registry.access.redhat.com/ubi9/nodejs-20:latest

LABEL maintainer="base-images"
LABEL description="Bun runtime based on Red Hat UBI9"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install required dependencies for Bun
# hadolint ignore=DL3041
RUN microdnf install -y \
    unzip \
    curl \
    && microdnf clean all \
    && rm -rf /var/cache/yum

# Install Bun
ENV BUN_INSTALL=/usr/local
RUN curl -fsSL https://bun.sh/install | bash

# Verify Bun installation
RUN bun --version

# Set working directory
WORKDIR /app

# Default command
CMD ["bun"]
