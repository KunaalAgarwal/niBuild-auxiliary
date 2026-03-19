# FSL Mathematical Image Operations (fslmaths)

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Performs a wide range of voxelwise mathematical operations on NIfTI images including arithmetic, filtering, thresholding, and morphological operations.

**Modality:** 3D or 4D NIfTI volume(s).

**Typical Use:** Mathematical operations, masking, thresholding, temporal filtering.

## Key Parameters

-add/-sub/-mul/-div (arithmetic), -thr/-uthr (thresholding), -bin (binarize), -s (smoothing sigma mm), -bptf (bandpass temporal filter)

## Key Points

Swiss army knife of neuroimaging. Operations are applied left to right. Use -odt to control output data type. -bptf values are in volumes not seconds.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input image |  |
| `abs` | `boolean` | No | Absolute value | `-abs` |
| `bin` | `boolean` | No | Binarize (non-zero -> 1) | `-bin` |
| `binv` | `boolean` | No | Binarize and invert (zero -> 1, non-zero -> 0) | `-binv` |
| `recip` | `boolean` | No | Reciprocal (1/x) | `-recip` |
| `sqrt` | `boolean` | No | Square root | `-sqrt` |
| `sqr` | `boolean` | No | Square | `-sqr` |
| `exp` | `boolean` | No | Exponential | `-exp` |
| `log` | `boolean` | No | Natural logarithm | `-log` |
| `nan` | `boolean` | No | Replace NaN with 0 | `-nan` |
| `nanm` | `boolean` | No | Make NaN mask (1 where NaN) | `-nanm` |
| `fillh` | `boolean` | No | Fill holes in binary mask | `-fillh` |
| `fillh26` | `boolean` | No | Fill holes using 26-connectivity | `-fillh26` |
| `edge` | `boolean` | No | Edge detection | `-edge` |
| `add_value` | `double` | No | Add value to all voxels | `-add` |
| `sub_value` | `double` | No | Subtract value from all voxels | `-sub` |
| `mul_value` | `double` | No | Multiply all voxels by value | `-mul` |
| `div_value` | `double` | No | Divide all voxels by value | `-div` |
| `rem_value` | `double` | No | Remainder after dividing by value | `-rem` |
| `thr` | `double` | No | Threshold below (set to 0) | `-thr` |
| `thrp` | `double` | No | Threshold below percentage of robust range | `-thrp` |
| `thrP` | `double` | No | Threshold below percentage of non-zero voxels | `-thrP` |
| `uthr` | `double` | No | Upper threshold (set to 0 if above) | `-uthr` |
| `uthrp` | `double` | No | Upper threshold percentage of robust range | `-uthrp` |
| `uthrP` | `double` | No | Upper threshold percentage of non-zero voxels | `-uthrP` |
| `add_file` | `File` | No | Add image | `-add` |
| `sub_file` | `File` | No | Subtract image | `-sub` |
| `mul_file` | `File` | No | Multiply by image | `-mul` |
| `div_file` | `File` | No | Divide by image | `-div` |
| `mas` | `File` | No | Apply mask (zero outside mask) | `-mas` |
| `max_file` | `File` | No | Take maximum with image | `-max` |
| `min_file` | `File` | No | Take minimum with image | `-min` |
| `s` | `double` | No | Gaussian smoothing (sigma in mm) | `-s` |
| `kernel_type` | `enum` | No | Kernel type for morphological operations | `-kernel` |
| `kernel_size` | `double` | No | Kernel size parameter |  |
| `dilM` | `boolean` | No | Mean dilation | `-dilM` |
| `dilD` | `boolean` | No | Modal dilation | `-dilD` |
| `dilF` | `boolean` | No | Full dilation (non-zero -> max) | `-dilF` |
| `dilall` | `boolean` | No | Dilate all voxels | `-dilall` |
| `ero` | `boolean` | No | Erosion (min) | `-ero` |
| `eroF` | `boolean` | No | Erosion with filter | `-eroF` |
| `fmedian` | `boolean` | No | Median filter | `-fmedian` |
| `fmean` | `boolean` | No | Mean filter | `-fmean` |
| `fmeanu` | `boolean` | No | Mean filter using non-zero neighbors only | `-fmeanu` |
| `Tmean` | `boolean` | No | Mean across time | `-Tmean` |
| `Tstd` | `boolean` | No | Standard deviation across time | `-Tstd` |
| `Tmax` | `boolean` | No | Maximum across time | `-Tmax` |
| `Tmaxn` | `boolean` | No | Time index of maximum | `-Tmaxn` |
| `Tmin` | `boolean` | No | Minimum across time | `-Tmin` |
| `Tmedian` | `boolean` | No | Median across time | `-Tmedian` |
| `Tar1` | `boolean` | No | AR(1) coefficient across time | `-Tar1` |
| `bptf` | `string` | No | Bandpass temporal filter (hp_sigma lp_sigma in volumes) | `-bptf` |
| `odt` | `enum` | No | Output data type | `-odt` |
| `output` | `string` | Yes | Output filename |  |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`
- **add_file**: `.nii`, `.nii.gz`
- **sub_file**: `.nii`, `.nii.gz`
- **mul_file**: `.nii`, `.nii.gz`
- **div_file**: `.nii`, `.nii.gz`
- **mas**: `.nii`, `.nii.gz`
- **max_file**: `.nii`, `.nii.gz`
- **min_file**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `output_image` | `File` | `$(inputs.output).nii.gz`, `$(inputs.output).nii`, `$(inputs.output)` |
| `log` | `File` | `fslmaths.log` |

### Output Extensions

- **output_image**: `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Utilities > FSL > Image Math

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/Fslutils)
