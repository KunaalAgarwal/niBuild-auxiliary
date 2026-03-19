# AFNI 3D Dataset Copy (3dcopy)

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Copies a dataset with optional format conversion between AFNI and NIfTI formats.

**Modality:** Any NIfTI or AFNI format dataset.

**Typical Use:** Format conversion between AFNI and NIfTI, making editable copies.

## Key Parameters

<input> <output> (format determined by output extension)

## Key Points

Output format determined by extension. Simple way to convert between formats.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `old_dataset` | `File` | Yes | Source dataset to copy |  |
| `new_prefix` | `string` | Yes | New dataset prefix |  |
| `verb` | `boolean` | No | Print progress reports | `-verb` |
| `denote` | `boolean` | No | Remove Notes from the file | `-denote` |

### Accepted Input Extensions

- **old_dataset**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `copied` | `File` | `$(inputs.new_prefix)+orig.HEAD`, `$(inputs.new_prefix)+tlrc.HEAD` |
| `log` | `File` | `$(inputs.new_prefix).log` |

### Output Extensions

- **copied**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Utilities > AFNI > Dataset Operations

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dcopy.html)
