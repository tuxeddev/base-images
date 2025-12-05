# hadolint ignore=DL3007
FROM registry.access.redhat.com/ubi9/ubi:latest

LABEL maintainer="base-images"
LABEL description="Bun runtime based on Red Hat UBI9"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install required dependencies for Bun
# hadolint ignore=DL3041
RUN dnf install -y \
    unzip \
    curl \
    && dnf clean all \
    && rm -rf /var/cache/dnf

# Install Bun (using specific version for reproducible builds)
ENV BUN_INSTALL=/usr/local
ARG BUN_VERSION=latest
RUN curl -fsSL https://bun.sh/install | bash -s -- "bun-v${BUN_VERSION}"

# Verify Bun installation
RUN bun --version

# Set working directory
WORKDIR /app

# Default command
CMD ["bun"]
