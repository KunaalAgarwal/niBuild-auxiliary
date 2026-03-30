#!/usr/bin/env bash
set -euo pipefail

# If --help is passed, show usage
if [ "${1:-}" = "--help" ] || [ "${1:-}" = "-h" ]; then
  echo "=== niBuild Workflow Runner (Singularity) ==="
  echo ""
  echo "Usage:"
  echo "  Direct:    ./run_singularity.sh"
  echo "  Container: singularity run my-pipeline.sif"
  echo ""
  echo "File inputs (edit job.yml before running):"
  echo "  bet_input  (File[])"
  echo "  fast_manualseg  (File)"
  echo "  flirt_reference  (File)"
  echo "  flirt_init_matrix  (File)"
  echo "  flirt_in_weight  (File)"
  echo "  flirt_ref_weight  (File)"
  echo "  flirt_wm_seg  (File)"
  echo "  flirt_fieldmap  (File)"
  echo "  flirt_fieldmapmask  (File)"
  echo "  flirt_schedule  (File)"
  echo "  fnirt_reference  (File)"
  echo "  fnirt_inwarp  (File)"
  echo "  fnirt_intin  (File)"
  echo "  fnirt_config  (File)"
  echo "  fnirt_refmask  (File)"
  echo "  fnirt_inmask  (File)"
  echo "  applywarp_reference  (File)"
  echo "  applywarp_premat  (File)"
  echo "  applywarp_postmat  (File)"
  echo "  applywarp_mask  (File)"
  echo "  fslmaths_add_file  (File)"
  echo "  fslmaths_sub_file  (File)"
  echo "  fslmaths_div_file  (File)"
  echo "  fslmaths_mas  (File)"
  echo "  fslmaths_max_file  (File)"
  echo "  fslmaths_min_file  (File)"
  echo "  randomise_design_mat  (File)"
  echo "  randomise_tcon  (File)"
  echo "  randomise_fcon  (File)"
  echo "  randomise_mask  (File)"
  echo "  randomise_x_block_labels  (File)"
  echo ""
  echo "All scalar parameters are pre-configured in job.yml."
  echo "Edit job.yml to set file paths before running."
  echo ""
  echo "Extra arguments are passed to cwltool (e.g. --verbose, --cachedir /cache)."
  exit 0
fi

cwltool --singularity --outdir /output "$@" \
  workflows/vbm_analysis.cwl \
  job.yml
