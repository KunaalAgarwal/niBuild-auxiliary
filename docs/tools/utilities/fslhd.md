# FSL Header Display (fslhd)

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Displays NIfTI/ANALYZE image header information including dimensions, voxel sizes, data type, and orientation.

**Modality:** Any NIfTI or ANALYZE image.

**Typical Use:** Inspecting image metadata for quality control and debugging preprocessing issues.

## Key Parameters

<input_file>, -x (XML output format)

## Key Points

Reports full header including sform/qform matrices, intent codes, and auxiliary info. XML output useful for programmatic parsing.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input NIfTI image |  |
| `xml` | `boolean` | No | Output in XML format | `-x` |

### Accepted Input Extensions

- **input_file**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `header_info` | `File` | `fslhd_output.txt` |
| `log` | `File` | `fslhd.log` |

### Output Extensions

- **header_info**: `.txt`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Utilities > FSL > Image Info

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/Fslutils)
