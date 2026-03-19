# ANTs N4 Bias Field Correction

**Library:** ANTs | **Docker Image:** `antsx/ants`

## Function

Advanced bias field (intensity inhomogeneity) correction using the N4 algorithm with iterative B-spline fitting.

**Modality:** 3D NIfTI volume (any MRI contrast), optional brain mask.

**Typical Use:** Removing intensity inhomogeneity before segmentation or registration.

## Key Parameters

-d (dimension), -i (input), -o (output [,bias_field]), -x (mask), -s (shrink factor), -c (convergence)

## Key Points

Gold standard for bias correction. Use mask to restrict correction to brain. -s 4 speeds up computation.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input_image` | `File` | Yes | Input image for bias correction | `-i` |
| `output_prefix` | `string` | Yes | Output image prefix | `-o` |
| `dimensionality` | `int` | No | Image dimensionality (2, 3, or 4) | `-d` |
| `mask_image` | `File` | No | Binary mask to restrict correction region | `-x` |
| `weight_image` | `File` | No | Weight image for voxel weighting during fitting | `-w` |
| `shrink_factor` | `int` | No | Shrink factor for faster processing (1-4 typical) | `-s` |
| `convergence` | `string` | No | Convergence parameters [iterations,threshold] e.g. [50x50x50x50,0.0] | `-c` |
| `bspline_fitting` | `string` | No | B-spline fitting parameters [splineDistance,splineOrder] e.g. [180,3] | `-b` |
| `histogram_sharpening` | `string` | No | Histogram sharpening [FWHM,wienerNoise,numBins] e.g. [0.15,0.01,200] | `-t` |
| `rescale_intensities` | `boolean` | No | Rescale intensities between 0 and 1 | `-r` |
| `verbose` | `boolean` | No | Enable verbose output | `-v` |

### Accepted Input Extensions

- **input_image**: `.nii`, `.nii.gz`
- **mask_image**: `.nii`, `.nii.gz`
- **weight_image**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `corrected_image` | `File` | `$(inputs.output_prefix)_corrected.nii.gz` |
| `bias_field` | `File` | `$(inputs.output_prefix)_biasfield.nii.gz` |
| `log` | `File` | `N4BiasFieldCorrection.log` |

### Output Extensions

- **corrected_image**: `.nii.gz`
- **bias_field**: `.nii.gz`

## Docker Tags

Available versions: `latest`, `master`, `v2.6.5`, `2.6.5`, `v2.6.4`, `2.6.4`, `v2.6.3`, `2.6.3`, `v2.6.2`, `2.6.2`
 and 5 more

## Categories

- Utilities > ANTs > Preprocessing Utilities

## Documentation

[Official Documentation](https://github.com/ANTsX/ANTs/wiki/Atropos-and-N4)
