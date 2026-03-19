# FSL Volume Split (fslsplit)

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Splits a 4D time series into individual 3D volumes or splits along any spatial axis.

**Modality:** 4D NIfTI time series.

**Typical Use:** Processing individual volumes separately, quality control inspection.

## Key Parameters

<input> [output_basename] -t/-x/-y/-z (split direction, default -t for time)

## Key Points

Default splits along time dimension. Output files are numbered sequentially (vol0000, vol0001, ...). Useful for per-volume quality control.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input 4D image |  |
| `output_basename` | `string` | No | Output basename for split files |  |
| `dimension` | `enum` | No | Dimension to split along (t=time, x, y, z) | `-` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `split_files` | `File[]` | `*.nii.gz`, `*.nii` |
| `log` | `File` | `fslsplit.log` |

### Output Extensions

- **split_files**: `.nii`, `.nii.gz`

## Enum Options

**`dimension`**: `t`, `x`, `y`, `z`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Utilities > FSL > Volume Operations

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/Fslutils)
