# AFNI 3D T-Test (3dttest++)

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Two-sample t-test with support for covariates, paired tests, and cluster-level inference.

**Modality:** Subject-level 3D NIfTI/AFNI volumes.

**Typical Use:** Group comparisons with covariate control.

## Key Parameters

-setA/-setB (group datasets), -prefix (output), -covariates (covariate file), -paired (paired test), -Clustsim (cluster simulation)

## Key Points

Use -Clustsim for built-in cluster-level correction. -covariates allows continuous covariates.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `prefix` | `string` | Yes | Output dataset prefix | `-prefix` |
| `setA` | `File | File[]` | Yes | Primary sample set (required) | `-setA` |
| `setB` | `File | File[]` | No | Secondary sample set for 2-sample comparison | `-setB` |
| `labelA` | `string` | No | Name for set A in output labels | `-labelA` |
| `labelB` | `string` | No | Name for set B in output labels | `-labelB` |
| `covariates` | `File` | No | Text file with covariate table | `-covariates` |
| `center` | `enum` | No | Covariate centering method | `-center` |
| `paired` | `boolean` | No | Conduct paired-sample t-test | `-paired` |
| `unpooled` | `boolean` | No | Compute variance separately for each set | `-unpooled` |
| `BminusA` | `boolean` | No | Reverse subtraction order to B - A | `-BminusA` |
| `rankize` | `boolean` | No | Convert data and covariates into ranks | `-rankize` |
| `toz` | `boolean` | No | Convert t-statistics to z-scores | `-toz` |
| `zskip` | `int` | No | Skip zero values in voxel analysis | `-zskip` |
| `resid` | `string` | No | Save residuals to separate dataset | `-resid` |
| `no1sam` | `boolean` | No | Omit 1-sample test results in 2-sample analysis | `-no1sam` |
| `nomeans` | `boolean` | No | Exclude mean sub-bricks from output | `-nomeans` |
| `notests` | `boolean` | No | Exclude statistical test sub-bricks | `-notests` |
| `mask` | `File` | No | Restrict analysis to mask region | `-mask` |
| `exblur` | `double` | No | Apply additional Gaussian smoothing (FWHM in mm) | `-exblur` |
| `Clustsim` | `int` | No | Run cluster simulations for thresholding | `-Clustsim` |
| `ETAC` | `int` | No | Multi-threshold clustering with equitable FPR control | `-ETAC` |
| `brickwise` | `boolean` | No | Process multiple sub-bricks separately | `-brickwise` |
| `singletonA` | `string` | No | Test single value against group mean | `-singletonA` |
| `debug` | `boolean` | No | Print detailed analysis information | `-debug` |

### Accepted Input Extensions

- **setA**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **setB**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **covariates**: `.1D`, `.txt`
- **mask**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `stats` | `File` | `$(inputs.prefix)+orig.HEAD`, `$(inputs.prefix)+tlrc.HEAD` |
| `residuals` | `File` | `$(inputs.resid)+orig.*`, `$(inputs.resid)+tlrc.*`, `$(inputs.resid).nii*` |
| `clustsim` | `File` | `*.ClustSim.*` |
| `log` | `File` | `$(inputs.prefix).log` |

### Output Extensions

- **stats**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **residuals**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`, `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Functional MRI > AFNI > Statistical Analysis

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dttest++.html)
