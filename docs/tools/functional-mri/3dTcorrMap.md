# AFNI 3D Whole-Brain Correlation Map (3dTcorrMap)

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Computes various whole-brain voxelwise correlation metrics including average correlation and global connectivity.

**Modality:** 4D fMRI NIfTI/AFNI time series plus brain mask.

**Typical Use:** Global connectivity metrics, whole-brain correlation exploration.

## Key Parameters

-input (4D data), -mask (brain mask), -Mean (mean correlation map), -Hist (histogram outputs)

## Key Points

Computes every-voxel-to-every-voxel correlations. Memory intensive.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input 3D+time dataset | `-input` |
| `seed` | `File` | No | Seed 3D+time dataset for cross-correlation | `-seed` |
| `mask` | `File` | No | Voxel mask for processing | `-mask` |
| `automask` | `boolean` | No | Create mask from input dataset | `-automask` |
| `polort` | `int` | No | Remove polynomial trends (-1 to 19, default 1) | `-polort` |
| `bpass` | `string` | No | Bandpass frequencies L H in Hz | `-bpass` |
| `ort` | `File` | No | Remove reference time series via regression | `-ort` |
| `Gblur` | `double` | No | Gaussian blur kernel width in mm | `-Gblur` |
| `Mseed` | `double` | No | Average seed over radius in mm | `-Mseed` |
| `Mean` | `string` | No | Save average correlations prefix | `-Mean` |
| `Zmean` | `string` | No | Save Fisher-transformed mean prefix | `-Zmean` |
| `Qmean` | `string` | No | Save RMS correlation prefix | `-Qmean` |
| `Thresh` | `string` | No | Count voxels exceeding threshold (tt pp) | `-Thresh` |
| `CorrMap` | `string` | No | Output complete correlation map prefix | `-CorrMap` |
| `Aexpr` | `string` | No | Average custom correlation expression (expr ppp) | `-Aexpr` |
| `Hist` | `string` | No | Generate correlation histogram (N ppp) | `-Hist` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **seed**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **mask**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **ort**: `.1D`, `.txt`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `mean_corr` | `File` | `$(inputs.Mean)+orig.HEAD`, `$(inputs.Mean)+tlrc.HEAD` |
| `zmean_corr` | `File` | `$(inputs.Zmean)+orig.HEAD`, `$(inputs.Zmean)+tlrc.HEAD` |
| `corrmap` | `File` | `$(inputs.CorrMap)+orig.HEAD`, `$(inputs.CorrMap)+tlrc.HEAD` |
| `log` | `File` | `3dTcorrMap.log` |

### Output Extensions

- **mean_corr**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **zmean_corr**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **corrmap**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Functional MRI > AFNI > Connectivity

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dTcorrMap.html)
