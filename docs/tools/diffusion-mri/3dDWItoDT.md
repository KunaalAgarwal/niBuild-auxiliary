# AFNI Diffusion Tensor Fitting (3dDWItoDT)

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Fits a diffusion tensor model to DWI data using linear or nonlinear methods, outputting tensor components, eigenvalues, and eigenvectors.

**Modality:** 4D diffusion-weighted dataset with gradient vector file.

**Typical Use:** Computing diffusion tensor and derived scalar maps (FA, MD) from DWI data in AFNI workflows.

## Key Parameters

-prefix (output prefix), -mask (brain mask), -eigs (output eigenvalues/eigenvectors), -nonlinear, -automask

## Key Points

Supports linear (default) and nonlinear fitting. Use -eigs for eigenvalue/eigenvector output required by 3dTrackID. Gradient file needs 3 columns per direction.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `prefix` | `string` | Yes | Output dataset prefix | `-prefix` |
| `gradient_file` | `File` | Yes | Gradient vector file (3 columns per direction) |  |
| `input` | `File` | Yes | Input 4D DWI dataset |  |
| `mask` | `File` | No | Brain mask dataset | `-mask` |
| `automask` | `boolean` | No | Automatically compute brain mask from data | `-automask` |
| `eigs` | `boolean` | No | Output eigenvalues and eigenvectors | `-eigs` |
| `debug_briks` | `boolean` | No | Output additional debugging volumes | `-debug_briks` |
| `cumulative_wts` | `boolean` | No | Output cumulative weights | `-cumulative_wts` |
| `nonlinear` | `boolean` | No | Compute nonlinear tensor fit | `-nonlinear` |
| `linear` | `boolean` | No | Compute linear tensor fit (default) | `-linear` |
| `sep_dsets` | `boolean` | No | Output separate datasets for each DTI parameter (FA, MD, V1, etc.) | `-sep_dsets` |
| `reweight` | `boolean` | No | Reweight the data | `-reweight` |
| `max_iter` | `int` | No | Maximum number of iterations for nonlinear fit | `-max_iter` |
| `max_iter_rw` | `int` | No | Maximum iterations for reweight | `-max_iter_rw` |
| `opt` | `enum` | No | Optimization method for nonlinear | `-opt` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`, `.HEAD`
- **gradient_file**: `.1D`, `.txt`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `tensor` | `File[]` | `$(inputs.prefix)*+orig.HEAD`, `$(inputs.prefix)*+orig.BRIK`, `$(inputs.prefix)*+orig.BRIK.gz`, `$(inputs.prefix)*+tlrc.HEAD`, `$(inputs.prefix)*+tlrc.BRIK`, `$(inputs.prefix)*+tlrc.BRIK.gz` |
| `log` | `File` | `$(inputs.prefix).log` |

### Output Extensions

- **tensor**: `.HEAD`, `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Diffusion MRI > AFNI > Tensor Fitting

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dDWItoDT.html)
