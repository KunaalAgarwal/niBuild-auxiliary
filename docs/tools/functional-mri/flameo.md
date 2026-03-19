# FMRIB's Local Analysis of Mixed Effects (FLAME)

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Group-level mixed-effects analysis accounting for both within-subject and between-subject variance using MCMC-based Bayesian estimation.

**Modality:** 4D NIfTI of stacked subject-level COPEs, VARCOPEs, plus group design matrix and contrast files.

**Typical Use:** Second-level group analyses with proper random effects.

## Key Parameters

--cope (cope image), --vc (varcope image), --dm (design matrix), --cs (contrast file), --runmode (fe/ols/flame1/flame12)

## Key Points

FLAME1 is recommended (good accuracy with reasonable speed). OLS is fast but ignores within-subject variance. FLAME1+2 is most accurate but slowest.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `cope_file` | `File` | Yes | COPE (contrast of parameter estimates) file | `--copefile=` |
| `var_cope_file` | `File` | No | Variance of COPE file | `--varcopefile=` |
| `mask_file` | `File` | Yes | Mask file | `--maskfile=` |
| `design_file` | `File` | Yes | Design matrix file (.mat) | `--designfile=` |
| `t_con_file` | `File` | Yes | T-contrast file (.con) | `--tcontrastsfile=` |
| `cov_split_file` | `File` | Yes | Covariance split file | `--covsplitfile=` |
| `run_mode` | `enum` | Yes | Inference mode (fe=fixed effects, ols=OLS, flame1=FLAME stage 1, flame12=FLAME stages 1+2) | `--runmode=` |
| `log_dir` | `string` | No | Output directory name (default stats) | `--ld=` |
| `f_con_file` | `File` | No | F-contrast file (.fts) | `--fcontrastsfile=` |
| `dof_var_cope_file` | `File` | No | Degrees of freedom for varcope | `--dofvarcopefile=` |
| `n_jumps` | `int` | No | Number of MCMC jumps | `--njumps=` |
| `burnin` | `int` | No | Number of MCMC burnin jumps | `--burnin=` |
| `sample_every` | `int` | No | MCMC sample every N jumps | `--sampleevery=` |
| `infer_outliers` | `boolean` | No | Infer outliers | `--inferoutliers` |
| `outlier_iter` | `int` | No | Outlier inference iterations | `--ioni=` |
| `fix_mean` | `boolean` | No | Fix mean for tfit | `--fixmean` |
| `no_pe_outputs` | `boolean` | No | Do not output parameter estimates | `--nopeoutput` |
| `sigma_dofs` | `int` | No | Sigma for DOF Gaussian smoothing | `--sigma_dofs=` |

### Accepted Input Extensions

- **cope_file**: `.nii`, `.nii.gz`
- **var_cope_file**: `.nii`, `.nii.gz`
- **mask_file**: `.nii`, `.nii.gz`
- **design_file**: `.mat`
- **t_con_file**: `.con`
- **cov_split_file**: `.grp`
- **f_con_file**: `.fts`
- **dof_var_cope_file**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `stats_dir` | `Directory` | `$(inputs.log_dir || 'stats')` |
| `copes` | `File[]` | `$(inputs.log_dir || 'stats')/cope*.nii.gz`, `$(inputs.log_dir || 'stats')/cope*.nii` |
| `var_copes` | `File[]` | `$(inputs.log_dir || 'stats')/varcope*.nii.gz`, `$(inputs.log_dir || 'stats')/varcope*.nii` |
| `tstats` | `File[]` | `$(inputs.log_dir || 'stats')/tstat*.nii.gz`, `$(inputs.log_dir || 'stats')/tstat*.nii` |
| `zstats` | `File[]` | `$(inputs.log_dir || 'stats')/zstat*.nii.gz`, `$(inputs.log_dir || 'stats')/zstat*.nii` |
| `fstats` | `File[]` | `$(inputs.log_dir || 'stats')/fstat*.nii.gz`, `$(inputs.log_dir || 'stats')/fstat*.nii` |
| `zfstats` | `File[]` | `$(inputs.log_dir || 'stats')/zfstat*.nii.gz`, `$(inputs.log_dir || 'stats')/zfstat*.nii` |
| `tdof` | `File` | `$(inputs.log_dir || 'stats')/tdof_t*.nii.gz`, `$(inputs.log_dir || 'stats')/tdof_t*.nii` |
| `res4d` | `File` | `$(inputs.log_dir || 'stats')/res4d.nii.gz`, `$(inputs.log_dir || 'stats')/res4d.nii` |
| `weights` | `File` | `$(inputs.log_dir || 'stats')/weights*.nii.gz`, `$(inputs.log_dir || 'stats')/weights*.nii` |
| `log` | `File` | `flameo.log` |

### Output Extensions

- **copes**: `.nii`, `.nii.gz`
- **var_copes**: `.nii`, `.nii.gz`
- **tstats**: `.nii`, `.nii.gz`
- **zstats**: `.nii`, `.nii.gz`
- **fstats**: `.nii`, `.nii.gz`
- **zfstats**: `.nii`, `.nii.gz`
- **tdof**: `.nii`, `.nii.gz`
- **res4d**: `.nii`, `.nii.gz`
- **weights**: `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Functional MRI > FSL > Statistical Analysis

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FLAME)
