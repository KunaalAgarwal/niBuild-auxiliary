# AFNI Tractography (3dTrackID)

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Performs deterministic, mini-probabilistic, or full probabilistic white matter tractography using diffusion tensor data.

**Modality:** DTI parameter volumes (from 3dDWItoDT with -eigs) and integer-labeled ROI mask.

**Typical Use:** White matter tractography and structural connectivity analysis in AFNI diffusion pipelines.

## Key Parameters

-mode (DET/MINIP/PROB), -dti_in (DTI prefix), -netrois (ROI file), -prefix (output prefix), -mask (brain/WM mask)

## Key Points

Three tracking modes with different speed/accuracy tradeoffs. Outputs tract files, connectivity matrices, and statistics. Requires 3dDWItoDT output with -eigs flag.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `mode` | `enum` | Yes | Tracking mode (DET=deterministic, MINIP=mini-probabilistic, PROB=probabilistic) | `-mode` |
| `dti_in` | `string` | Yes | DTI input prefix (basename, files staged via dti_files) | `-dti_in` |
| `dti_files` | `File[]` | Yes | DTI parameter files from 3dDWItoDT (HEAD/BRIK pairs, staged into working dir) |  |
| `netrois` | `File` | Yes | Network ROI file (integer-labeled mask) | `-netrois` |
| `prefix` | `string` | Yes | Output prefix | `-prefix` |
| `mask` | `File` | No | Brain mask (WM mask recommended) | `-mask` |
| `logic` | `enum` | No | Logic for multi-ROI tracking (default OR) | `-logic` |
| `algopt` | `File` | No | Algorithm options file | `-algopt` |
| `unc_min_FA` | `double` | No | Minimum FA for uncertainty calc | `-unc_min_FA` |
| `unc_min_V` | `double` | No | Minimum confidence for uncertainty | `-unc_min_V` |
| `alg_Thresh_FA` | `double` | No | FA threshold for tracking | `-alg_Thresh_FA` |
| `alg_Thresh_ANG` | `double` | No | Angle threshold (degrees) for tracking | `-alg_Thresh_ANG` |
| `alg_Thresh_Len` | `double` | No | Minimum tract length (mm) | `-alg_Thresh_Len` |
| `alg_Nseed_X` | `int` | No | Number of seeds per voxel (X direction) | `-alg_Nseed_X` |
| `alg_Nseed_Y` | `int` | No | Number of seeds per voxel (Y direction) | `-alg_Nseed_Y` |
| `alg_Nseed_Z` | `int` | No | Number of seeds per voxel (Z direction) | `-alg_Nseed_Z` |
| `nifti` | `boolean` | No | Output in NIfTI format | `-nifti` |
| `no_indipair_out` | `boolean` | No | Do not output individual pairwise maps | `-no_indipair_out` |
| `write_rois` | `boolean` | No | Write out ROI volumes | `-write_rois` |
| `write_opts` | `boolean` | No | Write out tracking options | `-write_opts` |
| `pair_out_power` | `boolean` | No | Output power-averaged map | `-pair_out_power` |

### Accepted Input Extensions

- **netrois**: `.nii`, `.nii.gz`, `.HEAD`
- **mask**: `.nii`, `.nii.gz`, `.HEAD`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `tracts` | `File` | `$(inputs.prefix)*.trk`, `$(inputs.prefix)*.niml.tract` |
| `connectivity_matrix` | `File` | `$(inputs.prefix)*.grid` |
| `stats` | `File` | `$(inputs.prefix)*.stats` |
| `log` | `File` | `$(inputs.prefix).log` |

### Output Extensions

- **tracts**: `.trk`, `.niml.tract`
- **connectivity_matrix**: `.grid`
- **stats**: `.stats`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Diffusion MRI > AFNI > Tractography

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dTrackID.html)
