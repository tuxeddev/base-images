# hadolint ignore=DL3007
FROM registry.access.redhat.com/ubi9/nodejs-22-minimal:latest

LABEL maintainer="base-images"
LABEL description="Bun runtime based on Red Hat UBI9 Minimal"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER 0
# Install dependencies and Bun
ENV BUN_INSTALL=/usr/local
# hadolint ignore=DL3041
RUN microdnf install -y \
    unzip \
    curl \
    && microdnf clean all \
    && rm -rf /var/cache/yum \
    && curl -fsSL https://bun.sh/install | bash \
    && bun --version

USER 1001
# Set working directory
WORKDIR $HOME

# Default command
CMD ["bun"]
