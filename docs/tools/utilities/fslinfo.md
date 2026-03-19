# FSL Image Info (fslinfo)

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Displays concise image dimension and voxel size information from a NIfTI header.

**Modality:** Any NIfTI image.

**Typical Use:** Quick inspection of image dimensions and voxel sizes for pipeline verification.

## Key Parameters

<input_file>

## Key Points

Compact output showing data type, dimensions (dim1-dim4), voxel sizes (pixdim1-pixdim4), and time step. Simpler than fslhd.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input NIfTI image |  |

### Accepted Input Extensions

- **input_file**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `image_info` | `File` | `fslinfo_output.txt` |
| `log` | `File` | `fslinfo.log` |

### Output Extensions

- **info**: `.txt`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Utilities > FSL > Image Info

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/Fslutils)
