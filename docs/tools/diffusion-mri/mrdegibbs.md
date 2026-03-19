# MRtrix3 Gibbs Ringing Removal

**Library:** MRtrix3 | **Docker Image:** `mrtrix3/mrtrix3`

## Function

Removes Gibbs ringing artifacts (truncation artifacts) from MRI data using a local subvoxel-shift method.

**Modality:** 3D or 4D NIfTI volume (structural or diffusion).

**Typical Use:** Removing Gibbs ringing after denoising, before other preprocessing.

## Key Parameters

<input> <output>, -axes (axes along which data was acquired, default 0,1)

## Key Points

Run after dwidenoise but before any interpolation-based processing. Only effective if data was NOT zero-filled in k-space.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input image |  |
| `output` | `string` | Yes | Output corrected image |  |
| `axes` | `string` | No | Slice axes (comma-separated, e.g., 0,1) | `-axes` |
| `nshifts` | `int` | No | Number of sub-voxel shifts | `-nshifts` |
| `minW` | `int` | No | Minimum window size | `-minW` |
| `maxW` | `int` | No | Maximum window size | `-maxW` |

### Accepted Input Extensions

- **input**: `.mif`, `.nii`, `.nii.gz`, `.mgh`, `.mgz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `degibbs` | `File` | `$(inputs.output)` |
| `log` | `File` | `mrdegibbs.log` |

### Output Extensions

- **degibbs**: `.mif`, `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `3.0.8`, `3.0.7`, `3.0.5`, `3.0.4`, `3.0.3`

## Categories

- Diffusion MRI > MRtrix3 > Preprocessing

## Documentation

[Official Documentation](https://mrtrix.readthedocs.io/en/latest/reference/commands/mrdegibbs.html)
