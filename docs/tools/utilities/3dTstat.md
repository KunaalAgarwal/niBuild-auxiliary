# AFNI 3D Temporal Statistics (3dTstat)

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Computes voxelwise temporal statistics (mean, stdev, median, etc.) across a 4D time series.

**Modality:** 4D NIfTI/AFNI time series.

**Typical Use:** Creating mean functional images, variance maps, temporal SNR.

## Key Parameters

-prefix (output), -mean/-stdev/-median/-max/-min (statistic type), -mask (optional mask)

## Key Points

Default computes mean. Can compute multiple statistics in one run.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input 3D+time dataset |  |
| `prefix` | `string` | Yes | Output dataset prefix | `-prefix` |
| `mean` | `boolean` | No | Compute mean of input voxels | `-mean` |
| `sum` | `boolean` | No | Compute sum of input voxels | `-sum` |
| `abssum` | `boolean` | No | Compute absolute sum | `-abssum` |
| `sos` | `boolean` | No | Compute sum of squares | `-sos` |
| `l2norm` | `boolean` | No | Compute L2 norm (sqrt of sum of squares) | `-l2norm` |
| `stdev` | `boolean` | No | Standard deviation (with detrending) | `-stdev` |
| `stdevNOD` | `boolean` | No | Standard deviation (without detrending) | `-stdevNOD` |
| `cvar` | `boolean` | No | Coefficient of variation (with detrending) | `-cvar` |
| `cvarNOD` | `boolean` | No | Coefficient of variation (without detrending) | `-cvarNOD` |
| `MAD` | `boolean` | No | Median absolute deviation | `-MAD` |
| `tsnr` | `boolean` | No | Temporal signal-to-noise ratio | `-tsnr` |
| `min` | `boolean` | No | Compute minimum | `-min` |
| `max` | `boolean` | No | Compute maximum | `-max` |
| `absmax` | `boolean` | No | Compute absolute maximum | `-absmax` |
| `argmin` | `boolean` | No | Index of minimum | `-argmin` |
| `argmax` | `boolean` | No | Index of maximum | `-argmax` |
| `median` | `boolean` | No | Median of input voxels | `-median` |
| `nzmedian` | `boolean` | No | Median of non-zero voxels | `-nzmedian` |
| `nzmean` | `boolean` | No | Mean of non-zero voxels | `-nzmean` |
| `percentile` | `double` | No | P-th percentile point | `-percentile` |
| `zcount` | `boolean` | No | Count zero values | `-zcount` |
| `nzcount` | `boolean` | No | Count non-zero values | `-nzcount` |
| `slope` | `boolean` | No | Compute slope vs time | `-slope` |
| `autocorr` | `int` | No | Autocorrelation function (first n coefficients) | `-autocorr` |
| `autoreg` | `int` | No | Autoregression coefficients (first n) | `-autoreg` |
| `DW` | `boolean` | No | Durbin-Watson statistic | `-DW` |
| `skewness` | `boolean` | No | Measure of asymmetry | `-skewness` |
| `kurtosis` | `boolean` | No | Fourth standardized moment | `-kurtosis` |
| `tdiff` | `boolean` | No | Take first difference before processing | `-tdiff` |
| `datum` | `enum` | No | Output data type (default float) | `-datum` |
| `nscale` | `boolean` | No | Do not scale output | `-nscale` |
| `mask` | `File` | No | Use as voxel mask | `-mask` |
| `mrange` | `string` | No | Restrict mask values to range (a b) | `-mrange` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **mask**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `stats` | `File` | `$(inputs.prefix)+orig.HEAD`, `$(inputs.prefix)+tlrc.HEAD` |
| `log` | `File` | `$(inputs.prefix).log` |

### Output Extensions

- **stats**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Utilities > AFNI > Image Math

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dTstat.html)
