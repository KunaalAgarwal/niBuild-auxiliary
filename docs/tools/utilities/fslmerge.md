# FSL Volume Merge (fslmerge)

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Concatenates multiple 3D volumes into a 4D time series or merges along any spatial axis.

**Modality:** Multiple 3D NIfTI volumes.

**Typical Use:** Combining processed volumes back into 4D, concatenating runs.

## Key Parameters

-t/-x/-y/-z/-a (merge direction), <output> <input1> <input2> ...

## Key Points

Use -t for temporal concatenation (most common). -a auto-detects axis. Input images must have matching spatial dimensions when merging in time.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `dimension` | `enum` | Yes | Dimension to merge along (t=time, x, y, z, a=auto) | `-` |
| `output` | `string` | Yes | Output merged filename |  |
| `input_files` | `File[]` | Yes | Input files to merge |  |
| `tr` | `double` | No | TR in seconds (when merging in time) |  |

### Accepted Input Extensions

- **input_files**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `merged_image` | `File` | `$(inputs.output).nii.gz`, `$(inputs.output).nii` |
| `log` | `File` | `$(inputs.output).log` |

### Output Extensions

- **merged_image**: `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Utilities > FSL > Volume Operations

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/Fslutils)
