# TBSS Non-FA Image Projection

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Projects non-FA diffusion images (MD, AD, RD, etc.) onto the mean FA skeleton using the same registration from the FA-based TBSS pipeline.

**Modality:** Non-FA diffusion scalar maps (3D NIfTI) in same space as FA images used for TBSS.

**Typical Use:** Analyzing MD, AD, RD, or other diffusion metrics on the FA-derived skeleton.

## Key Parameters

<non_FA_image> (e.g., all_MD) - run after tbss_4_prestats with non-FA data in stats directory

## Key Points

Must run full TBSS pipeline on FA first. Non-FA images must be in same native space as original FA. Creates all_<measure>_skeletonised for use with randomise.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `measure` | `string` | Yes | Non-FA measure name (e.g., MD, AD, RD, L1, L2, L3) |  |
| `fa_directory` | `Directory` | Yes | FA directory from TBSS pipeline (contains per-subject FA images and warps) |  |
| `stats_directory` | `Directory` | Yes | stats directory (mean_FA_skeleton, skeleton_mask, all_FA, all_FA_skeletonised) |  |
| `measure_directory` | `Directory` | Yes | Directory containing per-subject non-FA images (filenames must match FA subjects without _FA suffix) |  |

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `skeletonised_data` | `File` | `stats/all_$(inputs.measure)_skeletonised.nii.gz` |
| `log` | `File` | `tbss_non_FA.log` |
| `err_log` | `File` | `tbss_non_FA.err.log` |

### Output Extensions

- **skeletonised_data**: `.nii.gz`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Diffusion MRI > FSL > TBSS

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/TBSS/UserGuide#Using_non-FA_Images_in_TBSS)
