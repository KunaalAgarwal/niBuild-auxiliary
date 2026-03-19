# TBSS Step 2: Registration

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Registers all FA images to a target (best subject or standard-space template) using non-linear registration.

**Modality:** Preprocessed FA images from tbss_1_preproc.

**Typical Use:** Second step of TBSS pipeline: aligning all subjects to common space.

## Key Parameters

-T (use FMRIB58_FA as target), -t <target> (use specified target), -n (find best subject as target)

## Key Points

Use -T for standard target (recommended for most analyses). -n finds best representative subject but takes longer. Registration quality should be checked visually.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `fa_directory` | `Directory` | Yes | FA directory from tbss_1_preproc |  |
| `use_fmrib_target` | `boolean` | No | Use FMRIB58_FA standard-space image as target | `-T` |
| `target_image` | `File` | No | Use specified image as target | `-t` |
| `find_best_target` | `boolean` | No | Find best target from all subjects | `-n` |

### Accepted Input Extensions

- **target_image**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `FA_directory` | `Directory` | `FA` |
| `log` | `File` | `tbss_2_reg.log` |

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Diffusion MRI > FSL > TBSS

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/TBSS/UserGuide)
