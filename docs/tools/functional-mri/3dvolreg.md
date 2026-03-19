# AFNI 3D Volume Registration (3dvolreg)

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Rigid-body motion correction by registering all volumes in a 4D dataset to a base volume.

**Modality:** 4D fMRI NIfTI/AFNI time series.

**Typical Use:** Motion correction for fMRI; outputs 6 motion parameters for nuisance regression.

## Key Parameters

-base (reference volume index or dataset), -prefix (output), -1Dfile (motion parameters output), -maxdisp1D (max displacement output)

## Key Points

Default base is volume 0; use median volume for better results. Motion parameters output as 6 columns.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input 4D dataset |  |
| `prefix` | `string` | Yes | Output dataset prefix | `-prefix` |
| `base` | `int` | No | Base brick index (default 0) | `-base` |
| `base_file` | `File` | No | Base brick from external dataset | `-base` |
| `interpolation` | `enum` | No | Interpolation method | `-` |
| `dfile` | `string` | No | Save 9-column motion parameters (roll, pitch, yaw, dS, dL, dP, rmsold, rmsnew) | `-dfile` |
| `oned_file` | `string` | No | Save 6-column motion parameters for detrending | `-1Dfile` |
| `oned_matrix_save` | `string` | No | Save coordinate transformation matrix | `-1Dmatrix_save` |
| `float` | `boolean` | No | Force floating-point output format | `-float` |
| `clipit` | `boolean` | No | Clip output values to input range (default) | `-clipit` |
| `noclip` | `boolean` | No | Disable value clipping | `-noclip` |
| `maxdisp` | `boolean` | No | Print max brain voxel displacement in mm | `-maxdisp` |
| `nomaxdisp` | `boolean` | No | Disable max displacement calculation | `-nomaxdisp` |
| `maxdisp1D` | `string` | No | Write max displacement per sub-brick to file | `-maxdisp1D` |
| `zpad` | `int` | No | Zero-pad by n voxels during rotations (default 4) | `-zpad` |
| `maxite` | `int` | No | Maximum iterations for convergence (default 23) | `-maxite` |
| `x_thresh` | `double` | No | Convergence threshold in voxels (default 0.01) | `-x_thresh` |
| `rot_thresh` | `double` | No | Rotation convergence in degrees (default 0.02) | `-rot_thresh` |
| `final` | `enum` | No | Final interpolation method | `-final` |
| `weight` | `File` | No | Apply voxel weighting from specified brick | `-weight` |
| `twopass` | `boolean` | No | Perform two-pass registration (coarse then fine) | `-twopass` |
| `twoblur` | `double` | No | Blur factor for pass 1 (default 2.0) | `-twoblur` |
| `verbose` | `boolean` | No | Print progress reports | `-verbose` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **base_file**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **weight**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `registered` | `File` | `$(inputs.prefix)+orig.HEAD`, `$(inputs.prefix)+tlrc.HEAD` |
| `motion_params` | `File` | `$(inputs.dfile)` |
| `motion_1D` | `File` | `$(inputs.oned_file)` |
| `transform_matrix` | `File` | `$(inputs.oned_matrix_save)` |
| `max_displacement` | `File` | `$(inputs.maxdisp1D)` |
| `log` | `File` | `$(inputs.prefix).log` |

### Output Extensions

- **registered**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **motion_params**: `.1D`
- **motion_1D**: `.1D`
- **transform_matrix**: `.aff12.1D`
- **max_displacement**: `.1D`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Functional MRI > AFNI > Motion Correction

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dvolreg.html)
