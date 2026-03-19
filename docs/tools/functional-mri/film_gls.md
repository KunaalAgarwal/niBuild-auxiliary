# FMRIB's Improved Linear Model (FILM)

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Fits general linear model to fMRI time series with prewhitening using autocorrelation correction.

**Modality:** 4D fMRI NIfTI time series plus design matrix and contrast files.

**Typical Use:** First-level statistical analysis within FEAT or standalone.

## Key Parameters

--in (input 4D), --pd (design matrix), --con (contrast file), --thr (threshold), --sa (smoothed autocorrelation)

## Key Points

Core statistical engine of FEAT. Design matrix must be pre-generated (e.g., via Feat_model). When --con is provided, directly computes COPEs, VARCOPEs, T-statistics, and Z-statistics alongside parameter estimates (pe) and residuals.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input 4D data file | `--in=` |
| `design_file` | `File` | Yes | Design matrix file (.mat) | `--pd=` |
| `contrast_file` | `File` | No | Contrast definition file (.con) | `--con=` |
| `threshold` | `double` | No | Threshold for FILM estimation (default 1000) | `--thr=` |
| `results_dir` | `string` | No | Results directory name | `--rn=` |
| `autocorr_noestimate` | `boolean` | No | Do not estimate autocorrelation | `--noest` |
| `autocorr_estimate_only` | `boolean` | No | Only estimate autocorrelation (no GLM) | `--ac` |
| `smooth_autocorr` | `boolean` | No | Smooth autocorrelation estimates | `--sa` |
| `fit_armodel` | `boolean` | No | Fit autoregressive model | `--ar` |
| `use_pava` | `boolean` | No | Estimate autocorrelation using PAVA | `--pava` |
| `tukey_window` | `int` | No | Tukey window size for autocorrelation | `--tukey=` |
| `multitaper_product` | `int` | No | Multitaper with slepian tapers | `--mt=` |
| `brightness_threshold` | `int` | No | Susan brightness threshold | `--epith=` |
| `mask_size` | `int` | No | Susan mask size | `--ms=` |
| `full_data` | `boolean` | No | Output full data/verbose | `-v` |
| `output_pwdata` | `boolean` | No | Output prewhitened data | `--outputPWdata` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`
- **design_file**: `.mat`
- **contrast_file**: `.con`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `results` | `Directory` | `$(inputs.results_dir || 'results')` |
| `dof` | `File` | `$(inputs.results_dir || 'results')/dof` |
| `residual4d` | `File` | `$(inputs.results_dir || 'results')/res4d.nii.gz`, `$(inputs.results_dir || 'results')/res4d.nii` |
| `param_estimates` | `File[]` | `$(inputs.results_dir || 'results')/pe*.nii.gz`, `$(inputs.results_dir || 'results')/pe*.nii` |
| `sigmasquareds` | `File` | `$(inputs.results_dir || 'results')/sigmasquareds.nii.gz`, `$(inputs.results_dir || 'results')/sigmasquareds.nii` |
| `threshac1` | `File` | `$(inputs.results_dir || 'results')/threshac1.nii.gz`, `$(inputs.results_dir || 'results')/threshac1.nii` |
| `cope` | `File[]` | `$(inputs.results_dir || 'results')/cope*.nii.gz`, `$(inputs.results_dir || 'results')/cope*.nii` |
| `varcope` | `File[]` | `$(inputs.results_dir || 'results')/varcope*.nii.gz`, `$(inputs.results_dir || 'results')/varcope*.nii` |
| `tstat` | `File[]` | `$(inputs.results_dir || 'results')/tstat*.nii.gz`, `$(inputs.results_dir || 'results')/tstat*.nii` |
| `zstat` | `File[]` | `$(inputs.results_dir || 'results')/zstat*.nii.gz`, `$(inputs.results_dir || 'results')/zstat*.nii` |
| `log` | `File` | `film_gls.log` |

### Output Extensions

- **residual4d**: `.nii`, `.nii.gz`
- **param_estimates**: `.nii`, `.nii.gz`
- **sigmasquareds**: `.nii`, `.nii.gz`
- **threshac1**: `.nii`, `.nii.gz`
- **cope**: `.nii`, `.nii.gz`
- **varcope**: `.nii`, `.nii.gz`
- **tstat**: `.nii`, `.nii.gz`
- **zstat**: `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Functional MRI > FSL > Statistical Analysis

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FILM)
