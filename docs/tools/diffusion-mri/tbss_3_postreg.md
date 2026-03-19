# TBSS Step 3: Post-Registration

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Creates mean FA image and FA skeleton by projecting registered FA data onto a mean tract center.

**Modality:** Registered FA images from tbss_2_reg.

**Typical Use:** Third step of TBSS: creating the white matter skeleton for analysis.

## Key Parameters

-S (use study-specific mean FA and skeleton), -T (use FMRIB58_FA mean and skeleton)

## Key Points

Creates mean_FA, mean_FA_skeleton, and all_FA (4D). Skeleton threshold typically 0.2 FA. -S recommended for study-specific analysis.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `fa_directory` | `Directory` | Yes | FA directory from tbss_2_reg |  |
| `study_specific` | `boolean` | No | Derive mean FA and skeleton from study data | `-S` |
| `use_fmrib` | `boolean` | No | Use FMRIB58_FA mean FA and skeleton | `-T` |

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `mean_FA` | `File` | `stats/mean_FA.nii.gz` |
| `mean_FA_skeleton` | `File` | `stats/mean_FA_skeleton.nii.gz` |
| `all_FA` | `File` | `stats/all_FA.nii.gz` |
| `FA_directory` | `Directory` | `FA` |
| `stats_directory` | `Directory` | `stats` |
| `log` | `File` | `tbss_3_postreg.log` |

### Output Extensions

- **mean_FA**: `.nii.gz`
- **mean_FA_skeleton**: `.nii.gz`
- **all_FA**: `.nii.gz`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Diffusion MRI > FSL > TBSS

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/TBSS/UserGuide)
