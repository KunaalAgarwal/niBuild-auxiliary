# TBSS Step 4: Pre-Statistics

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Projects all subjects FA data onto the mean FA skeleton, ready for voxelwise cross-subject statistics.

**Modality:** Mean FA skeleton from tbss_3_postreg plus registered FA images.

**Typical Use:** Final TBSS step before statistical analysis with randomise.

## Key Parameters

<threshold> (FA threshold for skeleton, typically 0.2)

## Key Points

Threshold determines which voxels are included in skeleton. Creates all_FA_skeletonised (4D) ready for randomise. Can also project non-FA data (MD, etc.) using tbss_non_FA.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `threshold` | `double` | Yes | FA threshold for skeleton (e.g., 0.2) |  |
| `fa_directory` | `Directory` | Yes | FA directory from tbss_3_postreg |  |
| `stats_directory` | `Directory` | Yes | stats directory from tbss_3_postreg |  |

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `all_FA_skeletonised` | `File` | `stats/all_FA_skeletonised.nii.gz` |
| `log` | `File` | `tbss_4_prestats.log` |

### Output Extensions

- **all_FA_skeletonised**: `.nii.gz`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Diffusion MRI > FSL > TBSS

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/TBSS/UserGuide)
