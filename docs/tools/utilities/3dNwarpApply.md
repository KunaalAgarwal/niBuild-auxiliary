# AFNI 3D Nonlinear Warp Apply

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Applies precomputed nonlinear warps (from 3dQwarp) to transform datasets.

**Modality:** 3D or 4D NIfTI/AFNI volume plus warp dataset.

**Typical Use:** Applying 3dQwarp transformations to functional or other data.

## Key Parameters

-nwarp (warp dataset), -source (input), -master (reference grid), -prefix (output), -interp (interpolation method)

## Key Points

Can concatenate multiple warps in -nwarp string. Use wsinc5 interpolation for best quality.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `nwarp` | `File` | Yes | 3D warp dataset to apply | `-nwarp` |
| `source` | `File` | Yes | Source dataset to be warped | `-source` |
| `prefix` | `string` | Yes | Output dataset prefix | `-prefix` |
| `master` | `string` | No | Master dataset defining output grid (or WARP/NWARP) | `-master` |
| `newgrid` | `double` | No | New grid spacing in mm for cubical voxels | `-newgrid` |
| `dxyz` | `double` | No | Same as -newgrid | `-dxyz` |
| `iwarp` | `boolean` | No | Invert computed warp | `-iwarp` |
| `interp` | `enum` | No | Interpolation mode (default wsinc5) | `-interp` |
| `ainterp` | `enum` | No | Alternate interpolation for data | `-ainterp` |
| `suffix` | `string` | No | Custom suffix for auto-generated output names | `-suffix` |
| `short` | `boolean` | No | Write output as 16-bit integers | `-short` |
| `wprefix` | `string` | No | Save intermediate warps with prefix | `-wprefix` |
| `quiet` | `boolean` | No | Suppress verbose output | `-quiet` |
| `verb` | `boolean` | No | Enable extra verbose output | `-verb` |

### Accepted Input Extensions

- **nwarp**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **source**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `warped` | `File` | `$(inputs.prefix)+*.HEAD` |
| `log` | `File` | `$(inputs.prefix).log` |

### Output Extensions

- **warped**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Enum Options

**`interp`**: `NN`, `linear`, `cubic`, `quintic`, `wsinc5`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Utilities > AFNI > Warp Utilities

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dNwarpApply.html)
