#!/usr/bin/env bash
# Pre-download all tool container images as Singularity SIF files.
# Run this before executing the workflow to avoid download delays.
# Recommended on HPC compute nodes with limited internet access.
set -euo pipefail
echo "Pulling and converting Docker images to Singularity SIF format..."
singularity pull --force brainlife_fsl_6.0.4.sif docker://brainlife/fsl:6.0.4
singularity pull --force brainlife_fsl_6.0.4-patched2.sif docker://brainlife/fsl:6.0.4-patched2
singularity pull --force brainlife_fsl_latest.sif docker://brainlife/fsl:latest
echo "All images converted to SIF successfully."
echo ""
echo "Note: cwltool --singularity will also auto-pull images at runtime."
echo "Pre-pulling is recommended on HPC nodes with limited internet access."
