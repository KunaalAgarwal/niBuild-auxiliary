#!/usr/bin/env bash
set -euo pipefail
# Pre-download all tool container images used by this workflow.
# Run this before 'docker build' to speed up the first workflow execution.

# Optional: set DOCKER_PLATFORM=linux/amd64 on Apple Silicon Macs
PLATFORM_FLAG=""
if [ -n "${DOCKER_PLATFORM:-}" ]; then
  PLATFORM_FLAG="--platform ${DOCKER_PLATFORM}"
fi

echo "Pulling neuroimaging tool images..."
docker pull $PLATFORM_FLAG brainlife/fsl:6.0.4
echo "All images pulled successfully."
