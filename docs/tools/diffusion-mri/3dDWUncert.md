# AFNI DWI Uncertainty Estimation (3dDWUncert)

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Estimates uncertainty of diffusion tensor parameters via jackknife or bootstrap resampling of DWI data.

**Modality:** 4D diffusion-weighted dataset with gradient vector file.

**Typical Use:** Generating uncertainty estimates for probabilistic tractography in AFNI diffusion pipelines.

## Key Parameters

-inset (input DWI), -prefix (output prefix), -grads (gradient file), -mask (brain mask), -iters (iterations, default 300)

## Key Points

Provides confidence intervals for FA and eigenvector directions. Output used as input for probabilistic tractography with 3dTrackID. Computationally intensive.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `inset` | `File` | Yes | Input DWI 4D dataset | `-inset` |
| `prefix` | `string` | Yes | Output dataset prefix | `-prefix` |
| `grads` | `File` | Yes | Gradient vector file | `-grads` |
| `mask` | `File` | No | Brain mask dataset | `-mask` |
| `iters` | `int` | No | Number of jackknife/bootstrap iterations (default 300) | `-iters` |
| `pt_choose_seed` | `int` | No | Seed for random number generator | `-pt_choose_seed` |

### Accepted Input Extensions

- **inset**: `.nii`, `.nii.gz`, `.HEAD`
- **grads**: `.1D`, `.txt`
- **mask**: `.nii`, `.nii.gz`, `.HEAD`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `uncertainty` | `File[]` | `$(inputs.prefix)+orig.HEAD`, `$(inputs.prefix)+orig.BRIK`, `$(inputs.prefix)+tlrc.HEAD`, `$(inputs.prefix)+tlrc.BRIK` |
| `log` | `File` | `$(inputs.prefix).log` |

### Output Extensions

- **uncertainty**: `.HEAD`, `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Diffusion MRI > AFNI > Uncertainty

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dDWUncert.html)
