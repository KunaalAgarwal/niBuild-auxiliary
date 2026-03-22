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
  echo "  fslmaths_1_add_file  (File)"
  echo "  fslmaths_1_sub_file  (File)"
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
  echo ""
  echo "All scalar parameters are pre-configured in job.yml."
  echo "Edit job.yml to set file paths before running."
  echo ""
  echo "Extra arguments are passed to cwltool (e.g. --verbose, --cachedir /cache)."
  exit 0
fi

cwltool --singularity --outdir /output "$@" \
  workflows/vbm_alzheimer.cwl \
  job.yml
