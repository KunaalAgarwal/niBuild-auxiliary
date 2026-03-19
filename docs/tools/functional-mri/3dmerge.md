# AFNI 3D Merge and Smooth (3dmerge)

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Combines spatial filtering and dataset merging operations, commonly used for Gaussian smoothing.

**Modality:** 3D or 4D NIfTI/AFNI volume.

**Typical Use:** Gaussian smoothing of functional data.

## Key Parameters

-1blur_fwhm (FWHM in mm), -doall (process all sub-bricks), -prefix (output)

## Key Points

Simple Gaussian smoothing with -1blur_fwhm. -doall applies to all volumes in 4D.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input dataset |  |
| `prefix` | `string` | Yes | Output dataset prefix | `-prefix` |
| `blur_fwhm` | `double` | No | Gaussian blur with FWHM (mm) | `-1blur_fwhm` |
| `blur_sigma` | `double` | No | Gaussian blur with sigma (mm) | `-1blur_sigma` |
| `blur_rms` | `double` | No | Gaussian blur with RMS deviation (mm) | `-1blur_rms` |
| `thtoin` | `boolean` | No | Copy threshold data over intensity data | `-1thtoin` |
| `noneg` | `boolean` | No | Zero out negative intensity voxels | `-1noneg` |
| `abs` | `boolean` | No | Take absolute values of intensities | `-1abs` |
| `clip` | `double` | No | Clip intensities in range (-val,val) to zero | `-1clip` |
| `thresh` | `double` | No | Use threshold data to censor intensities | `-1thresh` |
| `mult` | `double` | No | Multiply intensities by given factor | `-1mult` |
| `zscore` | `boolean` | No | Convert statistic to equivalent z-score | `-1zscore` |
| `clust` | `string` | No | Form clusters with rmm vmul (e.g., "5 100") | `-1clust` |
| `clust_mean` | `string` | No | Replace cluster voxels with average intensity | `-1clust_mean` |
| `clust_max` | `string` | No | Replace cluster voxels with maximum intensity | `-1clust_max` |
| `filter_mean` | `double` | No | Set each voxel to average intensity within radius (mm) | `-1filter_mean` |
| `filter_max` | `double` | No | Maximum intensity within radius (mm) | `-1filter_max` |
| `filter_blur` | `double` | No | Gaussian blur filter with FWHM (mm) | `-1filter_blur` |
| `erode` | `double` | No | Set voxel to zero unless pv% of nearby voxels are nonzero | `-1erode` |
| `dilate` | `boolean` | No | Restore voxels removed by erosion if neighbors exist | `-1dilate` |
| `dindex` | `int` | No | Use sub-brick j as data source | `-1dindex` |
| `tindex` | `int` | No | Use sub-brick k as threshold source | `-1tindex` |
| `doall` | `boolean` | No | Apply options to all sub-bricks uniformly | `-doall` |
| `datum` | `enum` | No | Output data storage type | `-datum` |
| `nozero` | `boolean` | No | Do not write output if all zero | `-nozero` |
| `quiet` | `boolean` | No | Reduce message output | `-quiet` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `merged` | `File` | `$(inputs.prefix)+orig.HEAD`, `$(inputs.prefix)+tlrc.HEAD` |
| `log` | `File` | `$(inputs.prefix).log` |

### Output Extensions

- **merged**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Functional MRI > AFNI > Smoothing

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dmerge.html)
