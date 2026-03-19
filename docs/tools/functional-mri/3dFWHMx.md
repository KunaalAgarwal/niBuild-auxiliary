# AFNI 3D Smoothness Estimation (3dFWHMx)

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Estimates spatial smoothness of data using the autocorrelation function (ACF) model.

**Modality:** Residual 4D NIfTI/AFNI from GLM analysis plus brain mask.

**Typical Use:** Getting smoothness estimates for 3dClustSim.

## Key Parameters

-input (residuals), -mask (brain mask), -acf (output ACF parameters), -detrend (detrend order)

## Key Points

Run on residuals (not original data). ACF model accounts for non-Gaussian spatial structure. Output feeds into 3dClustSim.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input dataset | `-input` |
| `mask` | `File` | No | Use only nonzero voxels in mask | `-mask` |
| `automask` | `boolean` | No | Generate mask automatically from input | `-automask` |
| `demed` | `boolean` | No | Subtract median of each voxel time series | `-demed` |
| `unif` | `boolean` | No | Normalize voxel time series to same MAD | `-unif` |
| `detrend` | `int` | No | Remove polynomial trends up to order q | `-detrend` |
| `detprefix` | `string` | No | Save detrended dataset with prefix | `-detprefix` |
| `geom` | `boolean` | No | Compute geometric mean of FWHM (default) | `-geom` |
| `arith` | `boolean` | No | Compute arithmetic mean of FWHM | `-arith` |
| `combine` | `boolean` | No | Combine measurements along each axis | `-combine` |
| `acf` | `string` | No | Compute ACF fit (output a b c parameters) | `-acf` |
| `ACF` | `string` | No | Same as -acf but with comment lines | `-ACF` |
| `out` | `string` | Yes | Output filename for FWHM results | `-out` |
| `compat` | `boolean` | No | Compatibility mode with older 3dFWHM | `-compat` |
| `difMAD` | `boolean` | No | Use first/second neighbor differences with MAD | `-2difMAD` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **mask**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `fwhm_output` | `File` | `$(inputs.out)` |
| `acf_output` | `File` | `$(inputs.acf)` |
| `detrended` | `File` | `$(inputs.detprefix)+orig.*`, `$(inputs.detprefix).nii*` |
| `log` | `File` | `3dFWHMx.log` |

### Output Extensions

- **fwhm_output**: `.1D`
- **acf_output**: `.1D`
- **detrended**: `+orig.HEAD`, `+orig.BRIK`, `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Functional MRI > AFNI > Multiple Comparisons

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dFWHMx.html)
