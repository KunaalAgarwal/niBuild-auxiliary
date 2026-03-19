# FSL Reorient to Standard Orientation

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Reorients images to match standard (MNI) orientation using 90-degree rotations and flips only.

**Modality:** 3D or 4D NIfTI volume in any orientation.

**Typical Use:** Ensuring consistent orientation before processing.

## Key Parameters

<input> [output]

## Key Points

Only applies 90-degree rotations/flips (no interpolation). Does not register to standard space. Should be run as first step before any processing.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input image to reorient |  |
| `output` | `string` | Yes | Output filename |  |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `reoriented_image` | `File` | `$(inputs.output).nii.gz`, `$(inputs.output).nii` |
| `log` | `File` | `$(inputs.output).log` |

### Output Extensions

- **reoriented_image**: `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Utilities > FSL > Volume Operations

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/Orientation%20Explained)
