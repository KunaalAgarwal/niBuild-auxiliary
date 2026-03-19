# AFNI 3D REML Fit (Improved GLM)

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

GLM with ARMA(1,1) temporal autocorrelation correction using restricted maximum likelihood estimation.

**Modality:** 4D fMRI NIfTI/AFNI time series plus design matrix from 3dDeconvolve.

**Typical Use:** More accurate first-level statistics than 3dDeconvolve OLS.

## Key Parameters

-matrix (design matrix from 3dDeconvolve -x1D), -input (4D data), -Rbuck (output stats), -Rvar (output variance)

## Key Points

More accurate statistics than 3dDeconvolve OLS. Run after 3dDeconvolve for improved inference.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input time series dataset | `-input` |
| `matrix` | `File` | Yes | Regression matrix from 3dDeconvolve (.xmat.1D file) | `-matrix` |
| `mask` | `File` | No | Mask dataset | `-mask` |
| `automask` | `boolean` | No | Automatically generate mask | `-automask` |
| `STATmask` | `File` | No | Separate mask for FDR curve computation | `-STATmask` |
| `Rbuck` | `string` | Yes | Output betas and statistics from REML | `-Rbuck` |
| `Rbeta` | `string` | No | Save beta weights from REML estimation | `-Rbeta` |
| `Rvar` | `string` | No | Save ARMA parameters and variance estimates | `-Rvar` |
| `Rfitts` | `string` | No | Save fitted model time series | `-Rfitts` |
| `Rerrts` | `string` | No | Save residuals (data minus fitted model) | `-Rerrts` |
| `Rwherr` | `string` | No | Save whitened residuals | `-Rwherr` |
| `Rglt` | `string` | No | Save GLT results | `-Rglt` |
| `MAXa` | `double` | No | Maximum AR parameter (default 0.8, range 0.1-0.9) | `-MAXa` |
| `MAXb` | `double` | No | Maximum MA parameter (default 0.8, range 0.1-0.9) | `-MAXb` |
| `Grid` | `int` | No | Grid resolution for (a,b) search (default 3, range 3-7) | `-Grid` |
| `NEGcor` | `boolean` | No | Allow negative correlations | `-NEGcor` |
| `ABfile` | `File` | No | Read pre-estimated (a,b) parameters from dataset | `-ABfile` |
| `addbase` | `File` | No | Append baseline columns from .1D file | `-addbase` |
| `slibase` | `File` | No | Append slice-specific baseline regressors | `-slibase` |
| `dsort` | `File` | No | Include voxel-wise baseline regressors | `-dsort` |
| `fout` | `boolean` | No | Include F-statistics in bucket | `-fout` |
| `tout` | `boolean` | No | Include t-statistics in bucket | `-tout` |
| `rout` | `boolean` | No | Include R-squared statistics in bucket | `-rout` |
| `noFDR` | `boolean` | No | Disable FDR curve computation | `-noFDR` |
| `gltsym` | `string[]` | No | Define custom contrasts (symbolic GLT) | `-gltsym` |
| `GOFORIT` | `boolean` | No | Force processing despite rank-deficiency warnings | `-GOFORIT` |
| `usetemp` | `boolean` | No | Write intermediate data to disk (reduces RAM) | `-usetemp` |
| `verb` | `boolean` | No | Enable verbose progress messages | `-verb` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **matrix**: `.1D`, `.txt`
- **mask**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **STATmask**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **ABfile**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **addbase**: `.1D`, `.txt`
- **slibase**: `.1D`, `.txt`
- **dsort**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `stats` | `File` | `$(inputs.Rbuck)+orig.HEAD`, `$(inputs.Rbuck)+tlrc.HEAD` |
| `betas` | `File` | `$(inputs.Rbeta)+orig.*`, `$(inputs.Rbeta)+tlrc.*`, `$(inputs.Rbeta).nii*` |
| `variance` | `File` | `$(inputs.Rvar)+orig.*`, `$(inputs.Rvar)+tlrc.*`, `$(inputs.Rvar).nii*` |
| `fitted` | `File` | `$(inputs.Rfitts)+orig.*`, `$(inputs.Rfitts)+tlrc.*`, `$(inputs.Rfitts).nii*` |
| `residuals` | `File` | `$(inputs.Rerrts)+orig.*`, `$(inputs.Rerrts)+tlrc.*`, `$(inputs.Rerrts).nii*` |
| `log` | `File` | `$(inputs.Rbuck).log` |

### Output Extensions

- **stats**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **betas**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`, `.nii`, `.nii.gz`
- **variance**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`, `.nii`, `.nii.gz`
- **fitted**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`, `.nii`, `.nii.gz`
- **residuals**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`, `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Functional MRI > AFNI > Statistical Analysis

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dREMLfit.html)
