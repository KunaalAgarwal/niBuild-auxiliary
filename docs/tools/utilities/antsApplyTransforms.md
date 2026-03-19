# ANTs Apply Transforms

**Library:** ANTs | **Docker Image:** `antsx/ants`

## Function

Applies one or more precomputed transformations (affine + warp) to images, applying transforms in reverse order of specification.

**Modality:** 3D or 4D NIfTI volume plus transform files (affine .mat and/or warp .nii.gz).

**Typical Use:** Applying registration transforms to data, labels, or ROIs.

## Key Parameters

-d (dimension), -i (input), -r (reference), -o (output), -t (transforms, applied last-to-first), -n (interpolation: Linear, NearestNeighbor, BSpline)

## Key Points

Transforms applied in REVERSE order listed. Use -n NearestNeighbor for label images. -e flag for time series.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `dimensionality` | `int` | Yes | Image dimensionality (2, 3, or 4) | `-d` |
| `input_image` | `File` | Yes | Input image to transform | `-i` |
| `reference_image` | `File` | Yes | Reference image defining output space | `-r` |
| `output_image` | `string` | Yes | Output transformed image filename | `-o` |
| `transforms` | `File[]` | Yes | Transform files (applied in reverse order - last specified first) | `-t` |
| `interpolation` | `enum` | No | Interpolation method | `-n` |
| `default_value` | `double` | No | Default voxel value for out-of-bounds points | `-f` |
| `input_image_type` | `enum` | No | Input image type (0=scalar, 1=vector, 2=tensor, 3=time-series) | `-e` |
| `use_float` | `boolean` | No | Use float instead of double for computations | `--float` |
| `verbose` | `boolean` | No | Enable verbose output | `-v` |

### Accepted Input Extensions

- **input_image**: `.nii`, `.nii.gz`
- **reference_image**: `.nii`, `.nii.gz`
- **transforms**: `.mat`, `.h5`, `.nii.gz`, `.txt`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `transformed_image` | `File` | `$(inputs.output_image)` |
| `log` | `File` | `antsApplyTransforms.log` |

### Output Extensions

- **transformed_image**: `.nii`, `.nii.gz`

## Enum Options

**`interpolation`**: `Linear`, `NearestNeighbor`, `Gaussian`, `BSpline`, `GenericLabel`

**`input_image_type`**: `0`, `1`, `2`, `3`

## Docker Tags

Available versions: `latest`, `master`, `v2.6.5`, `2.6.5`, `v2.6.4`, `2.6.4`, `v2.6.3`, `2.6.3`, `v2.6.2`, `2.6.2`
 and 5 more

## Categories

- Utilities > ANTs > Transform Utilities

## Documentation

[Official Documentation](https://github.com/ANTsX/ANTs/wiki/Anatomy-of-an-antsRegistration-call)
