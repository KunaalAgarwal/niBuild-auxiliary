# FSL Region of Interest Extraction (fslroi)

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Extracts a spatial or temporal sub-region from NIfTI images.

**Modality:** 3D or 4D NIfTI volume.

**Typical Use:** Cropping images spatially or selecting specific time points from 4D data.

## Key Parameters

<input> <output> <xmin> <xsize> <ymin> <ysize> <zmin> <zsize> [<tmin> <tsize>]

## Key Points

Indices are 0-based. For temporal extraction only, use: fslroi input output tmin tsize. Useful for extracting reference volumes from 4D data.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input image |  |
| `output` | `string` | Yes | Output filename |  |
| `x_min` | `int` | No | Minimum x index |  |
| `x_size` | `int` | No | Size in x dimension |  |
| `y_min` | `int` | No | Minimum y index |  |
| `y_size` | `int` | No | Size in y dimension |  |
| `z_min` | `int` | No | Minimum z index |  |
| `z_size` | `int` | No | Size in z dimension |  |
| `t_min` | `int` | No | Minimum time index |  |
| `t_size` | `int` | No | Number of time points to extract |  |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `roi_image` | `File` | `$(inputs.output).nii.gz`, `$(inputs.output).nii` |
| `log` | `File` | `$(inputs.output).log` |

### Output Extensions

- **roi_image**: `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Utilities > FSL > Image Math

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/Fslutils)
