# AFNI 3D Deconvolve (GLM Analysis)

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Multiple linear regression analysis for fMRI with flexible hemodynamic response function models.

**Modality:** 4D fMRI NIfTI/AFNI time series plus stimulus timing files.

**Typical Use:** First-level GLM analysis with flexible HRF models.

## Key Parameters

-input (4D data), -polort (polynomial detrending order), -num_stimts (number of regressors), -stim_times (timing files with HRF model), -gltsym (contrasts)

## Key Points

Supports many HRF models (GAM, BLOCK, dmBLOCK, TENT, CSPLIN). Use -x1D_stop to generate design matrix only.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input 3D+time dataset | `-input` |
| `bucket` | `string` | Yes | Output bucket dataset prefix | `-bucket` |
| `polort` | `string` | No | Polynomial degree for baseline (default 1, 'A' for auto) | `-polort` |
| `num_stimts` | `int` | No | Number of stimulus regressors | `-num_stimts` |
| `stim_times` | `stim_times_spec[]` | Yes | Stimulus times specification (k tname Rmodel) |  |
| `stim_file` | `stim_file_spec[]` | Yes | Stimulus file specification (k sname) |  |
| `stim_label` | `stim_label_spec[]` | Yes | Stimulus labels (k label) |  |
| `ortvec` | `File` | No | Baseline vectors from file as nuisance regressors | `-ortvec` |
| `local_times` | `boolean` | No | Interpret stimulus times relative to run starts | `-local_times` |
| `global_times` | `boolean` | No | Interpret stimulus times relative to first run | `-global_times` |
| `fout` | `boolean` | No | Output F-statistics for stimulus coefficients | `-fout` |
| `tout` | `boolean` | No | Output t-statistics for individual coefficients | `-tout` |
| `rout` | `boolean` | No | Output R-squared for each stimulus | `-rout` |
| `gltsym` | `string[]` | No | General linear test symbolic specification | `-gltsym` |
| `glt_label` | `record(glt_label_spec)[]` | No | GLT labels (k label) |  |
| `x1D` | `string` | No | Export design matrix filename | `-x1D` |
| `x1D_stop` | `boolean` | No | Stop after matrix generation | `-x1D_stop` |
| `mask` | `File` | No | Mask dataset | `-mask` |
| `automask` | `boolean` | No | Automatically generate mask | `-automask` |
| `censor` | `File` | No | Censor file for excluding time points | `-censor` |
| `CENSORTR` | `string` | No | Censor specific TRs | `-CENSORTR` |
| `fitts` | `string` | No | Output fitted model prefix | `-fitts` |
| `errts` | `string` | No | Output residuals prefix | `-errts` |
| `jobs` | `int` | No | Number of parallel jobs | `-jobs` |
| `quiet` | `boolean` | No | Suppress progress messages | `-quiet` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **stim_times**: `.1D`, `.txt`
- **stim_file**: `.1D`, `.txt`
- **ortvec**: `.1D`, `.txt`
- **mask**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **censor**: `.1D`, `.txt`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `stats` | `File` | `$(inputs.bucket)+orig.HEAD`, `$(inputs.bucket)+tlrc.HEAD` |
| `design_matrix` | `File` | `$(inputs.x1D)` |
| `xmat` | `File` | `*.xmat.1D` |
| `fitted` | `File` | `$(inputs.fitts)+orig.HEAD`, `$(inputs.fitts)+tlrc.HEAD` |
| `residuals` | `File` | `$(inputs.errts)+orig.HEAD`, `$(inputs.errts)+tlrc.HEAD` |
| `log` | `File` | `$(inputs.bucket).log` |

### Output Extensions

- **stats**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **design_matrix**: `.1D`
- **xmat**: `.xmat.1D`
- **fitted**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **residuals**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Functional MRI > AFNI > Statistical Analysis

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dDeconvolve.html)
