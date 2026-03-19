# FSL Image Statistics (fslstats)

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Computes various summary statistics from image data, optionally within a mask region.

**Modality:** 3D or 4D NIfTI volume, optional mask.

**Typical Use:** Extracting summary statistics from ROIs or whole-brain.

## Key Parameters

-k (mask image), -m (mean), -s (standard deviation), -r (min max), -V (volume in voxels and mm3), -p (nth percentile)

## Key Points

Apply -k mask before other options. Use -t for per-volume stats on 4D data. Outputs to stdout for easy scripting.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `split_4d` | `boolean` | No | Generate separate statistics for each 3D volume | `-t` |
| `input` | `File` | Yes | Input image |  |
| `mask` | `File` | No | Mask image for statistics | `-k` |
| `index_mask` | `File` | No | Generate separate statistics for each integer label | `-K` |
| `robust_range` | `boolean` | No | Output robust min and max (2nd and 98th percentiles) | `-r` |
| `absolute_range` | `boolean` | No | Output absolute min and max | `-R` |
| `mean` | `boolean` | No | Output mean | `-m` |
| `mean_nonzero` | `boolean` | No | Output mean of non-zero voxels | `-M` |
| `std` | `boolean` | No | Output standard deviation | `-s` |
| `std_nonzero` | `boolean` | No | Output standard deviation of non-zero voxels | `-S` |
| `volume` | `boolean` | No | Output number of voxels | `-v` |
| `volume_nonzero` | `boolean` | No | Output number of non-zero voxels | `-V` |
| `entropy` | `boolean` | No | Output entropy of image | `-e` |
| `entropy_nonzero` | `boolean` | No | Output entropy of non-zero voxels | `-E` |
| `histogram` | `int` | No | Output histogram with specified number of bins | `-h` |
| `percentile` | `double` | No | Output nth percentile value | `-p` |
| `abs_percentile` | `double` | No | Output nth percentile of absolute values | `-P` |
| `cog_voxels` | `boolean` | No | Output center of gravity in voxel coordinates | `-c` |
| `cog_mm` | `boolean` | No | Output center of gravity in mm coordinates | `-C` |
| `lower_threshold` | `double` | No | Set lower threshold | `-l` |
| `upper_threshold` | `double` | No | Set upper threshold | `-u` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`
- **mask**: `.nii`, `.nii.gz`
- **index_mask**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `stats_output` | `File` | `fslstats_output.txt` |
| `log` | `File` | `fslstats.log` |

### Output Extensions

- **stats_output**: `.txt`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Utilities > FSL > Image Math

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/Fslutils)
