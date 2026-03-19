# FreeSurfer General Linear Model (mri_glmfit)

**Library:** FreeSurfer | **Docker Image:** `freesurfer/freesurfer`

## Function

Fits a general linear model on surface or volume data for group-level statistical analysis.

**Modality:** Concatenated surface data from mris_preproc or stacked volume data.

**Typical Use:** Surface-based or volume-based group statistical analysis.

## Key Parameters

--y (input data), --fsgd (FreeSurfer group descriptor), --C (contrast file), --surf (surface subject), --glmdir (output directory)

## Key Points

Uses FSGD file for design specification. Supports DODS and DOSS design types. Can run on surface or volume data.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `subjects_dir` | `Directory` | Yes | FreeSurfer SUBJECTS_DIR |  |
| `fs_license` | `File` | Yes | FreeSurfer license file |  |
| `y` | `File` | Yes | Input data file | `--y` |
| `glmdir` | `string` | Yes | Output GLM directory | `--glmdir` |
| `fsgd` | `File` | No | FreeSurfer Group Descriptor file | `--fsgd` |
| `design` | `File` | No | Design matrix file | `--X` |
| `osgm` | `boolean` | No | One-sample group mean | `--osgm` |
| `C` | `File[]` | No | Contrast matrix file(s) | `--C` |
| `surface` | `string` | No | Surface subject and hemisphere (e.g., fsaverage lh) | `--surface` |
| `cortex` | `boolean` | No | Use cortex label as mask | `--cortex` |
| `fwhm` | `double` | No | Smooth input by FWHM in mm | `--fwhm` |
| `var_fwhm` | `double` | No | Smooth variance by FWHM in mm | `--var-fwhm` |
| `mask` | `File` | No | Mask volume or label | `--mask` |
| `mask_inv` | `boolean` | No | Invert mask | `--mask-inv` |
| `prune` | `boolean` | No | Prune design matrix | `--prune` |
| `no_prune` | `boolean` | No | Do not prune | `--no-prune` |
| `wls` | `File` | No | Weighted least squares variance file | `--wls` |
| `self` | `int` | No | Self regressor column | `--self` |
| `pca` | `boolean` | No | Perform PCA on residuals | `--pca` |
| `save_eres` | `boolean` | No | Save residual error | `--eres-save` |
| `save_yhat` | `boolean` | No | Save signal estimate | `--yhat-save` |
| `nii` | `boolean` | No | Use NIfTI output format | `--nii` |
| `nii_gz` | `boolean` | No | Use compressed NIfTI output | `--nii.gz` |
| `sim` | `string` | No | Simulation parameters (nulltype nsim thresh csd) | `--sim` |
| `sim_sign` | `enum` | No | Simulation sign | `--sim-sign` |
| `seed` | `int` | No | Random seed | `--seed` |
| `synth` | `boolean` | No | Replace input with Gaussian noise | `--synth` |
| `allowsubjrep` | `boolean` | No | Allow subject repetition in FSGD | `--allowsubjrep` |

### Accepted Input Extensions

- **y**: `.mgh`, `.mgz`, `.nii`, `.nii.gz`
- **fsgd**: `.fsgd`
- **design**: `.mat`, `.txt`
- **C**: `.mat`, `.txt`, `.mtx`
- **mask**: `.mgh`, `.mgz`, `.nii`, `.nii.gz`, `.label`
- **wls**: `.mgh`, `.mgz`, `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `glm_dir` | `Directory` | `$(inputs.glmdir)` |
| `log` | `File` | `mri_glmfit.log` |

## Docker Tags

Available versions: `latest`, `8.1.0`, `8.0.0`, `7.2.0`, `7.3.0`, `7.3.1`, `7.3.2`, `7.4.1`, `7.1.1`, `6.0`

## Categories

- Functional MRI > FreeSurfer > Functional Analysis

## Documentation

[Official Documentation](https://surfer.nmr.mgh.harvard.edu/fswiki/mri_glmfit)
