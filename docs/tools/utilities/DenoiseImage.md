# ANTs Non-Local Means Denoising

**Library:** ANTs | **Docker Image:** `antsx/ants`

## Function

Reduces noise in MRI images using an adaptive non-local means algorithm that preserves structural details.

**Modality:** 3D NIfTI volume (any MRI contrast).

**Typical Use:** Noise reduction while preserving structural edges.

## Key Parameters

-d (dimension), -i (input), -o (output [,noise_image]), -v (verbose)

## Key Points

Preserves edges better than Gaussian smoothing. Can output estimated noise image. Apply before bias correction.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input_image` | `File` | Yes | Input image for denoising | `-i` |
| `output_prefix` | `string` | Yes | Output image prefix | `-o` |
| `dimensionality` | `int` | No | Image dimensionality (2, 3, or 4) | `-d` |
| `noise_model` | `enum` | No | Noise model to employ | `-n` |
| `mask_image` | `File` | No | Mask image to limit denoising region | `-x` |
| `shrink_factor` | `int` | No | Shrink factor for faster processing (default 1) | `-s` |
| `patch_radius` | `string` | No | Patch radius (e.g., 1 or 1x1x1) | `-p` |
| `search_radius` | `string` | No | Search radius (e.g., 3 or 3x3x3) | `-r` |
| `verbose` | `boolean` | No | Enable verbose output | `-v` |

### Accepted Input Extensions

- **input_image**: `.nii`, `.nii.gz`
- **mask_image**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `denoised_image` | `File` | `$(inputs.output_prefix)_denoised.nii.gz` |
| `noise_image` | `File` | `$(inputs.output_prefix)_noise.nii.gz` |
| `log` | `File` | `DenoiseImage.log` |

### Output Extensions

- **denoised_image**: `.nii.gz`
- **noise_image**: `.nii.gz`

## Enum Options

**`noise_model`**: `Rician`, `Gaussian`

## Docker Tags

Available versions: `latest`, `master`, `v2.6.5`, `2.6.5`, `v2.6.4`, `2.6.4`, `v2.6.3`, `2.6.3`, `v2.6.2`, `2.6.2`
 and 5 more

## Categories

- Utilities > ANTs > Preprocessing Utilities

## Documentation

[Official Documentation](https://github.com/ANTsX/ANTs/wiki/DenoiseImage)
