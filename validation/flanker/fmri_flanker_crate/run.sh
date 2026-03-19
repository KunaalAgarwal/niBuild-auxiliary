#!/usr/bin/env bash
set -euo pipefail

# If --help is passed, show usage
if [ "${1:-}" = "--help" ] || [ "${1:-}" = "-h" ]; then
  echo "=== niBuild Workflow Runner ==="
  echo ""
  echo "Usage: docker run -v /path/to/data:/data -v /path/to/output:/output <image>"
  echo ""
  echo "File inputs (edit job.yml before running):"
  echo "  t1w  (File[])"
  echo "  bold  (File[])"
  echo "  mcflirt_ref_file  (File)"
  echo "  mcflirt_init  (File)"
  echo "  flirt_1_reference  (File)"
  echo "  flirt_1_init_matrix  (File)"
  echo "  flirt_1_in_weight  (File)"
  echo "  flirt_1_ref_weight  (File)"
  echo "  flirt_1_wm_seg  (File)"
  echo "  flirt_1_fieldmap  (File)"
  echo "  flirt_1_fieldmapmask  (File)"
  echo "  flirt_1_schedule  (File)"
  echo "  flirt_2_init_matrix  (File)"
  echo "  flirt_2_in_weight  (File)"
  echo "  flirt_2_ref_weight  (File)"
  echo "  flirt_2_wm_seg  (File)"
  echo "  flirt_2_fieldmap  (File)"
  echo "  flirt_2_fieldmapmask  (File)"
  echo "  flirt_2_schedule  (File)"
  echo "  fnirt_reference  (File)"
  echo "  fnirt_inwarp  (File)"
  echo "  fnirt_intin  (File)"
  echo "  fnirt_config  (File)"
  echo "  fnirt_refmask  (File)"
  echo "  fnirt_inmask  (File)"
  echo "  fslmaths_1_add_file  (File)"
  echo "  fslmaths_1_sub_file  (File)"
  echo "  fslmaths_1_mul_file  (File)"
  echo "  fslmaths_1_div_file  (File)"
  echo "  fslmaths_1_mas  (File)"
  echo "  fslmaths_1_max_file  (File)"
  echo "  fslmaths_1_min_file  (File)"
  echo "  fslmaths_2_add_file  (File)"
  echo "  fslmaths_2_sub_file  (File)"
  echo "  fslmaths_2_mul_file  (File)"
  echo "  fslmaths_2_div_file  (File)"
  echo "  fslmaths_2_mas  (File)"
  echo "  fslmaths_2_max_file  (File)"
  echo "  fslmaths_2_min_file  (File)"
  echo "  fslmaths_3_sub_file  (File)"
  echo "  fslmaths_3_mul_file  (File)"
  echo "  fslmaths_3_div_file  (File)"
  echo "  fslmaths_3_mas  (File)"
  echo "  fslmaths_3_max_file  (File)"
  echo "  fslmaths_3_min_file  (File)"
  echo "  applywarp_reference  (File)"
  echo "  applywarp_postmat  (File)"
  echo "  applywarp_mask  (File)"
  echo ""
  echo "All scalar parameters are pre-configured in job.yml."
  echo "Edit job.yml to set file paths before running."
  echo ""
  echo "BIDS mode: ./run.sh --bids /absolute/path/to/bids/dataset"
  echo "  (the BIDS path must be absolute)"
  echo ""
  echo "Extra arguments are passed to cwltool (e.g. --verbose, --cachedir /cache)."
  exit 0
fi

# BIDS mode: resolve dataset paths automatically
if [ "${1:-}" = "--bids" ]; then
  BIDS_DIR="${2:-}"
  if [ -z "${BIDS_DIR:-}" ]; then
    echo "Error: --bids requires a path to a BIDS dataset directory"
    exit 1
  fi
  shift 2
  echo "Resolving BIDS inputs from: $BIDS_DIR"
  python3 resolve_bids.py \
    --bids-dir "$BIDS_DIR" \
    --query bids_query.json \
    --job job.yml \
    --output job.yml \
    --relative-to .
  cwltool --outdir /output "$@" \
    workflows/fmri_flanker.cwl \
    job.yml
  exit 0
fi

cwltool --outdir /output "$@" \
  workflows/fmri_flanker.cwl \
  job.yml
