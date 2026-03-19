# AFNI 3D Zero Padding (3dZeropad)

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Adds zero-valued slices around dataset boundaries to extend the image matrix.

**Modality:** 3D or 4D NIfTI/AFNI volume.

**Typical Use:** Matching matrix sizes between datasets, preventing edge effects.

## Key Parameters

-I/-S/-A/-P/-R/-L (add slices in each direction), -master (match grid of master dataset), -prefix (output)

## Key Points

Use -master to match another dataset grid. Can also crop with negative values.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input dataset |  |
| `prefix` | `string` | Yes | Output dataset prefix | `-prefix` |
| `I` | `int` | No | Add n planes at Inferior edge | `-I` |
| `S` | `int` | No | Add n planes at Superior edge | `-S` |
| `A` | `int` | No | Add n planes at Anterior edge | `-A` |
| `P` | `int` | No | Add n planes at Posterior edge | `-P` |
| `L` | `int` | No | Add n planes at Left edge | `-L` |
| `R` | `int` | No | Add n planes at Right edge | `-R` |
| `z` | `int` | No | Add planes on each z-axis face | `-z` |
| `RL` | `int` | No | Symmetric padding to achieve n slices in R/L | `-RL` |
| `AP` | `int` | No | Symmetric padding to achieve n slices in A/P | `-AP` |
| `IS` | `int` | No | Symmetric padding to achieve n slices in I/S | `-IS` |
| `pad2odds` | `boolean` | No | Add 0 or 1 plane per R/A/S for odd slice counts | `-pad2odds` |
| `pad2evens` | `boolean` | No | Add 0 or 1 plane per R/A/S for even slice counts | `-pad2evens` |
| `pad2mult` | `int` | No | Make each axis a multiple of N | `-pad2mult` |
| `mm` | `boolean` | No | Interpret padding counts as millimeters | `-mm` |
| `master` | `File` | No | Match volume extents from reference dataset | `-master` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **master**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `padded` | `File` | `$(inputs.prefix)+orig.HEAD`, `$(inputs.prefix)+tlrc.HEAD` |
| `log` | `File` | `$(inputs.prefix).log` |

### Output Extensions

- **padded**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Utilities > AFNI > Dataset Operations

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dZeropad.html)
