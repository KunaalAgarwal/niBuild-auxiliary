# TBSS Step 1: Preprocessing

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Preprocesses FA images for TBSS by slightly eroding them and zeroing end slices to remove outlier voxels.

**Modality:** FA maps (3D NIfTI) from dtifit, placed in a common directory.

**Typical Use:** First step of TBSS pipeline for voxelwise diffusion analysis.

## Key Parameters

*.nii.gz (all FA images in current directory)

## Key Points

Run from directory containing all subjects FA images. Creates FA/ subdirectory with preprocessed images. Must be run before tbss_2_reg.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `fa_images` | `File[]` | Yes | Input FA images |  |

### Accepted Input Extensions

- **fa_images**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `FA_directory` | `Directory` | `FA` |
| `log` | `File` | `tbss_1_preproc.log` |

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Diffusion MRI > FSL > TBSS

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/TBSS/UserGuide)
