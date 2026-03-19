# ANTs Multi-Stage Image Registration

**Library:** ANTs | **Docker Image:** `antsx/ants`

## Function

State-of-the-art image registration supporting multiple stages (rigid, affine, SyN) with configurable metrics and convergence.

**Modality:** Any 3D NIfTI volume pair (fixed and moving images).

**Typical Use:** High-quality multi-stage registration with full parameter control.

## Key Parameters

-d (dimension), -f (fixed), -m (moving), -t (transform type), -c (convergence), -s (smoothing sigmas), -o (output)

## Key Points

Multi-stage approach: rigid then affine then SyN. SyN is symmetric diffeomorphic. CC metric best for intra-modal, MI for inter-modal.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `dimensionality` | `int` | Yes | Image dimensionality (2 or 3) | `-d` |
| `output_prefix` | `string` | Yes | Output transform prefix | `-o` |
| `fixed_image` | `File` | Yes | Fixed/reference image |  |
| `moving_image` | `File` | Yes | Moving image to register |  |
| `metric` | `string` | Yes | Metric specification (e.g., MI[fixed,moving,1,32,Regular,0.25]) | `-m` |
| `transform` | `string` | Yes | Transform specification (e.g., Rigid[0.1]) | `-t` |
| `convergence` | `string` | Yes | Convergence specification (e.g., [1000x500x250x100,1e-6,10]) | `-c` |
| `shrink_factors` | `string` | Yes | Shrink factors per level (e.g., 8x4x2x1) | `-f` |
| `smoothing_sigmas` | `string` | Yes | Smoothing sigmas per level (e.g., 3x2x1x0vox) | `-s` |
| `initial_moving_transform` | `File` | No | Initial transform for moving image | `-r` |
| `masks` | `string` | No | Mask specification (fixedMask,movingMask or single mask) | `-x` |
| `use_histogram_matching` | `boolean` | No | Use histogram matching | `-u` |
| `winsorize_image_intensities` | `string` | No | Winsorize intensities (e.g., [0.005,0.995]) | `-w` |
| `use_float` | `boolean` | No | Use float precision instead of double | `--float` |
| `interpolation` | `enum` | No | Interpolation method | `-n` |
| `verbose` | `boolean` | No | Enable verbose output | `-v` |
| `write_composite_transform` | `boolean` | No | Write composite transform | `-z` |

### Accepted Input Extensions

- **fixed_image**: `.nii`, `.nii.gz`
- **moving_image**: `.nii`, `.nii.gz`
- **initial_moving_transform**: `.mat`, `.h5`, `.nii.gz`, `.txt`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `warped_image` | `File` | `$(inputs.output_prefix)Warped.nii.gz` |
| `inverse_warped_image` | `File` | `$(inputs.output_prefix)InverseWarped.nii.gz` |
| `forward_transforms` | `File[]` | `$(inputs.output_prefix)*GenericAffine.mat`, `$(inputs.output_prefix)*Warp.nii.gz` |
| `inverse_transforms` | `File[]` | `$(inputs.output_prefix)*InverseWarp.nii.gz` |
| `log` | `File` | `antsRegistration.log` |

### Output Extensions

- **warped_image**: `.nii.gz`
- **inverse_warped_image**: `.nii.gz`
- **forward_transforms**: `.mat`, `.nii.gz`
- **inverse_transforms**: `.nii.gz`

## Enum Options

**`interpolation`**: `Linear`, `NearestNeighbor`, `BSpline`, `Gaussian`

## Docker Tags

Available versions: `latest`, `master`, `v2.6.5`, `2.6.5`, `v2.6.4`, `2.6.4`, `v2.6.3`, `2.6.3`, `v2.6.2`, `2.6.2`
 and 5 more

## Categories

- Structural MRI > ANTs > Registration

## Documentation

[Official Documentation](https://github.com/ANTsX/ANTs/wiki/Anatomy-of-an-antsRegistration-call)
