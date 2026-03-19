# FSL Change File Type (fslchfiletype)

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Converts neuroimaging files between NIfTI and ANALYZE file formats.

**Modality:** Any NIfTI or ANALYZE image.

**Typical Use:** Converting between compressed and uncompressed NIfTI formats, or to legacy ANALYZE format.

## Key Parameters

<filetype> (NIFTI_GZ, NIFTI, NIFTI_PAIR, ANALYZE), <input_file>, [output_file]

## Key Points

Supports NIFTI_GZ (.nii.gz), NIFTI (.nii), NIFTI_PAIR (.hdr/.img), and ANALYZE formats. Quick utility for format interoperability.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `filetype` | `enum` | Yes | Output file type |  |
| `input` | `File` | Yes | Input image file |  |
| `output` | `string` | No | Output filename (default overwrites input) |  |

### Accepted Input Extensions

- **input_file**: `.nii`, `.nii.gz`, `.hdr`, `.img`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `converted_file` | `File[]` | `*.nii.gz`, `*.nii`, `*.hdr`, `*.img` |
| `log` | `File` | `fslchfiletype.log` |

### Output Extensions

- **output**: `.nii`, `.nii.gz`, `.hdr`, `.img`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Utilities > FSL > Volume Operations

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/Fslutils)
