# AFNI 3D Affine Registration (3dAllineate)

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Linear (affine) registration with multiple cost functions and optimization methods.

**Modality:** Any 3D NIfTI/AFNI volume pair.

**Typical Use:** Affine alignment between modalities or to standard space.

## Key Parameters

-source (moving image), -base (reference), -prefix (output), -cost (cost function: lpc, mi, nmi), -1Dmatrix_save (save transform)

## Key Points

lpc cost recommended for EPI-to-T1 alignment. nmi for intra-modal.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `source` | `File` | Yes | Source dataset to be transformed | `-source` |
| `base` | `File` | Yes | Reference/base dataset | `-base` |
| `prefix` | `string` | Yes | Output dataset prefix | `-prefix` |
| `cost` | `enum` | No | Cost function for matching (default mi) | `-cost` |
| `warp` | `enum` | No | Transformation type (default affine_general) | `-warp` |
| `interp` | `enum` | No | Interpolation during matching (default linear) | `-interp` |
| `final` | `enum` | No | Interpolation for output (default cubic) | `-final` |
| `oned_matrix_save` | `string` | No | Save transformation matrix to file | `-1Dmatrix_save` |
| `oned_param_save` | `string` | No | Save warp parameters to file | `-1Dparam_save` |
| `oned_matrix_apply` | `File` | No | Apply transformation matrix from file | `-1Dmatrix_apply` |
| `oned_param_apply` | `File` | No | Apply warp parameters from file | `-1Dparam_apply` |
| `onepass` | `boolean` | No | Skip coarse resolution pass | `-onepass` |
| `twopass` | `boolean` | No | Apply two-pass strategy to all sub-bricks | `-twopass` |
| `twofirst` | `boolean` | No | Two-pass for first sub-brick only (default) | `-twofirst` |
| `twobest` | `int` | No | Number of best coarse candidates for fine pass (0-29, default 5) | `-twobest` |
| `twoblur` | `double` | No | Blurring radius for coarse pass in mm (default 11) | `-twoblur` |
| `fineblur` | `double` | No | Blurring radius for fine pass in mm (default 0) | `-fineblur` |
| `conv` | `double` | No | Convergence threshold in mm | `-conv` |
| `autoweight` | `boolean` | No | Compute weight from automask plus blurring | `-autoweight` |
| `automask` | `boolean` | No | Binary weight mask | `-automask` |
| `autobox` | `boolean` | No | Expand automask to rectangular box (default) | `-autobox` |
| `nomask` | `boolean` | No | Disable autoweight/mask computation | `-nomask` |
| `weight` | `File` | No | Custom weighting dataset | `-weight` |
| `emask` | `File` | No | Exclusion mask (nonzero voxels excluded) | `-emask` |
| `source_mask` | `File` | No | Mask for source dataset | `-source_mask` |
| `source_automask` | `boolean` | No | Automatically mask source dataset | `-source_automask` |
| `maxrot` | `double` | No | Maximum rotation limit in degrees (default 30) | `-maxrot` |
| `maxshf` | `double` | No | Maximum shift limit in mm | `-maxshf` |
| `maxscl` | `double` | No | Maximum scaling factor (default 1.4) | `-maxscl` |
| `maxshr` | `double` | No | Maximum shearing factor (default 0.1111) | `-maxshr` |
| `master` | `File` | No | Output uses grid of specified dataset | `-master` |
| `newgrid` | `double` | No | Output grid spacing in mm | `-newgrid` |
| `EPI` | `boolean` | No | Treat source as EPI with constrained warping | `-EPI` |
| `cmass` | `boolean` | No | Use center-of-mass for initial shift alignment | `-cmass` |
| `nocmass` | `boolean` | No | Disable center-of-mass calculation (default) | `-nocmass` |
| `floatize` | `boolean` | No | Write result as float format | `-floatize` |
| `zclip` | `boolean` | No | Replace negative values with zero | `-zclip` |
| `verb` | `boolean` | No | Print verbose progress reports | `-verb` |
| `quiet` | `boolean` | No | Suppress verbose output | `-quiet` |

### Accepted Input Extensions

- **source**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **base**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **oned_matrix_apply**: `.1D`, `.txt`
- **oned_param_apply**: `.1D`, `.txt`
- **weight**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **emask**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **source_mask**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **master**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `aligned` | `File` | `$(inputs.prefix)+orig.HEAD`, `$(inputs.prefix)+tlrc.HEAD` |
| `matrix` | `File` | `$(inputs.oned_matrix_save)` |
| `params` | `File` | `$(inputs.oned_param_save)` |
| `log` | `File` | `$(inputs.prefix).log` |

### Output Extensions

- **aligned**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **matrix**: `.aff12.1D`
- **params**: `.1D`

## Enum Options

**`cost`**: `ls`, `mi`, `crM`, `nmi`, `hel`, `lpc`

**`warp`**: `shift_only`, `shift_rotate`, `shift_rotate_scale`, `affine_general`

**`interp`**: `NN`, `linear`, `cubic`, `quintic`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Structural MRI > AFNI > Registration

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dAllineate.html)
