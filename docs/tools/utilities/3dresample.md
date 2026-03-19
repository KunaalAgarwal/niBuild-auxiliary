# AFNI 3D Resample (3dresample)

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Resamples a dataset to match the grid of another dataset or to a specified voxel size.

**Modality:** 3D or 4D NIfTI/AFNI volume.

**Typical Use:** Matching resolution between datasets for analysis.

## Key Parameters

-master (template grid), -prefix (output), -dxyz (voxel size), -rmode (interpolation: NN, Li, Cu)

## Key Points

Use -rmode NN for label/mask images, Li or Cu for continuous data.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input dataset | `-input` |
| `prefix` | `string` | Yes | Output dataset prefix | `-prefix` |
| `master` | `File` | No | Align grid to master dataset | `-master` |
| `dxyz` | `double[]` | No | Resample to new voxel dimensions (dx dy dz in mm) |  |
| `orient` | `string` | No | Reorient to new axis order (3-char code from APS, IRL) | `-orient` |
| `rmode` | `enum` | No | Resampling method (NN=nearest neighbor, Li=linear, Cu=cubic, Bk=blocky) | `-rmode` |
| `bound_type` | `enum` | No | Boundary preservation method | `-bound_type` |
| `upsample` | `int` | No | Upsample voxels by factor (makes voxels smaller) | `-upsample` |
| `downsample` | `int` | No | Downsample voxels by factor (makes voxels larger) | `-downsample` |
| `delta_scale` | `double` | No | Generalized voxel size rescaling (<1 upsample, >1 downsample) | `-delta_scale` |
| `debug` | `int` | No | Debug level (0-2) | `-debug` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **master**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `resampled` | `File` | `$(inputs.prefix)+orig.HEAD`, `$(inputs.prefix)+tlrc.HEAD` |
| `log` | `File` | `$(inputs.prefix).log` |

### Output Extensions

- **resampled**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Enum Options

**`rmode`**: `NN`, `Li`, `Cu`, `Bk`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Utilities > AFNI > ROI Utilities

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dresample.html)
