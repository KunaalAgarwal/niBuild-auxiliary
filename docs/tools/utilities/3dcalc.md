# AFNI 3D Voxelwise Calculator (3dcalc)

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Voxelwise mathematical calculator supporting extensive expression syntax for operations on one or more datasets.

**Modality:** 3D or 4D NIfTI/AFNI volume(s).

**Typical Use:** Mathematical operations, masking, thresholding, combining datasets.

## Key Parameters

-a/-b/-c (input datasets), -expr (mathematical expression), -prefix (output), -datum (output data type)

## Key Points

Extremely flexible expression syntax. Supports conditionals, trigonometric, and logical operations. Up to 26 inputs (a-z).

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `a` | `File` | Yes | Input dataset a | `-a` |
| `b` | `File` | No | Input dataset b | `-b` |
| `c` | `File` | No | Input dataset c | `-c` |
| `d` | `File` | No | Input dataset d | `-d` |
| `expr` | `string` | Yes | Mathematical expression to evaluate | `-expr` |
| `prefix` | `string` | Yes | Output dataset prefix | `-prefix` |
| `session` | `string` | No | Output session directory | `-session` |
| `datum` | `enum` | No | Output data type | `-datum` |
| `float` | `boolean` | No | Force float output format | `-float` |
| `short` | `boolean` | No | Force short output format | `-short` |
| `byte` | `boolean` | No | Force byte output format | `-byte` |
| `fscale` | `boolean` | No | Force scaling to maximum integer range | `-fscale` |
| `gscale` | `boolean` | No | Force single scaling factor across all sub-bricks | `-gscale` |
| `nscale` | `boolean` | No | Disable scaling | `-nscale` |
| `dt` | `double` | No | TR for manufactured 3D+time datasets (seconds) | `-dt` |
| `taxis` | `string` | No | Create time axis (N:tstep) | `-taxis` |
| `verbose` | `boolean` | No | Display program progress | `-verbose` |
| `usetemp` | `boolean` | No | Use temporary file for intermediate results | `-usetemp` |
| `isola` | `boolean` | No | Remove isolated non-zero voxels | `-isola` |
| `dicom` | `boolean` | No | Use DICOM/RAI coordinate order | `-dicom` |
| `SPM` | `boolean` | No | Use SPM/LPI coordinate order | `-SPM` |

### Accepted Input Extensions

- **a**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **b**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **c**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **d**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `result` | `File` | `$(inputs.prefix)+orig.HEAD`, `$(inputs.prefix)+tlrc.HEAD` |
| `log` | `File` | `$(inputs.prefix).log` |

### Output Extensions

- **result**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Enum Options

**`datum`**: `byte`, `short`, `float`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Utilities > AFNI > Image Math

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dcalc.html)
