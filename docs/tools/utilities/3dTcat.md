# AFNI 3D Temporal Concatenate (3dTcat)

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Concatenates datasets along the time dimension or selects specific sub-bricks from 4D data.

**Modality:** 3D or 4D NIfTI/AFNI volumes.

**Typical Use:** Combining runs, removing initial steady-state volumes.

## Key Parameters

-prefix (output), <dataset>[selector] (input with optional sub-brick selector)

## Key Points

Sub-brick selectors allow flexible volume selection: [0..5] for first 6, [0..$-3] to skip last 3.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File | File[]` | Yes | Input dataset(s) to concatenate |  |
| `prefix` | `string` | Yes | Output dataset prefix | `-prefix` |
| `session` | `string` | No | Output dataset session directory | `-session` |
| `glueto` | `File` | No | Append bricks to the end of this dataset | `-glueto` |
| `rlt` | `boolean` | No | Remove linear trends in each voxel time series | `-rlt` |
| `rlt_plus` | `boolean` | No | Remove trends while restoring individual dataset means | `-rlt+` |
| `rlt_plusplus` | `boolean` | No | Remove trends while restoring overall mean | `-rlt++` |
| `relabel` | `boolean` | No | Replace sub-brick labels with input dataset name | `-relabel` |
| `tpattern` | `string` | No | Timing pattern for output dataset | `-tpattern` |
| `tr` | `double` | No | Repetition time in seconds for output dataset | `-tr` |
| `verb` | `boolean` | No | Enable verbose output | `-verb` |
| `dry` | `boolean` | No | Test run without making changes | `-dry` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **glueto**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `concatenated` | `File` | `$(inputs.prefix)+orig.HEAD`, `$(inputs.prefix)+tlrc.HEAD` |
| `log` | `File` | `$(inputs.prefix).log` |

### Output Extensions

- **concatenated**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Utilities > AFNI > Dataset Operations

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dTcat.html)
