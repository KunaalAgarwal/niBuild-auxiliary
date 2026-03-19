# AFNI 3D Automatic Mask Creation (3dAutomask)

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Creates a brain mask automatically from EPI data by finding connected high-intensity voxels.

**Modality:** 3D or 4D EPI NIfTI/AFNI volume.

**Typical Use:** Generating functional brain masks from EPI data.

## Key Parameters

-prefix (output mask), -dilate (number of dilation steps), -erode (number of erosion steps), -clfrac (clip fraction)

## Key Points

Works on EPI data directly (no structural needed). Lower -clfrac includes more voxels.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input dataset |  |
| `prefix` | `string` | Yes | Output mask dataset prefix | `-prefix` |
| `clfrac` | `double` | No | Clip level fraction (0.1-0.9, default 0.5) | `-clfrac` |
| `nograd` | `boolean` | No | Use fixed clip level instead of gradual method | `-nograd` |
| `peels` | `int` | No | Erode then dilate mask N times to remove thin protrusions (default 1) | `-peels` |
| `dilate` | `int` | No | Dilate the mask outwards N times | `-dilate` |
| `erode` | `int` | No | Erode the mask inwards N times | `-erode` |
| `NN1` | `boolean` | No | Use face neighbors only (6 neighbors) | `-NN1` |
| `NN2` | `boolean` | No | Use face and edge neighbors (18 neighbors, default) | `-NN2` |
| `NN3` | `boolean` | No | Use face, edge, and corner neighbors (26 neighbors) | `-NN3` |
| `nbhrs` | `int` | No | Number of neighbors needed to not erode (6-26, default 17) | `-nbhrs` |
| `eclip` | `boolean` | No | Remove exterior voxels below the clip threshold | `-eclip` |
| `SI` | `double` | No | Zero out voxels more than N mm inferior to superior voxel | `-SI` |
| `apply_prefix` | `string` | No | Apply mask to input and save masked dataset | `-apply_prefix` |
| `depth` | `string` | No | Produce dataset showing peel operations to reach each voxel | `-depth` |
| `quiet` | `boolean` | No | Suppress progress messages | `-q` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `mask` | `File` | `$(inputs.prefix)+orig.HEAD`, `$(inputs.prefix)+tlrc.HEAD` |
| `masked_input` | `File` | `$(inputs.apply_prefix)+orig.HEAD`, `$(inputs.apply_prefix)+tlrc.HEAD` |
| `depth_map` | `File` | `$(inputs.depth)+orig.HEAD`, `$(inputs.depth)+tlrc.HEAD` |
| `log` | `File` | `$(inputs.prefix).log` |

### Output Extensions

- **mask**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **masked_input**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **depth_map**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Parameter Bounds

| Parameter | Min | Max |
|---|---|---|
| `clfrac` | 0.1 | 0.9 |

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Functional MRI > AFNI > Masking

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dAutomask.html)
