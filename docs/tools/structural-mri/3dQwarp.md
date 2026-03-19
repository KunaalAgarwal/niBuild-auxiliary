# AFNI 3D Nonlinear Warp (3dQwarp)

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Non-linear registration using cubic polynomial basis functions for precise anatomical alignment.

**Modality:** T1-weighted 3D NIfTI/AFNI volumes (source and base, both skull-stripped).

**Typical Use:** High-accuracy normalization to template.

## Key Parameters

-source (moving), -base (reference), -prefix (output), -blur (smoothing), -minpatch (minimum patch size)

## Key Points

Both images should be skull-stripped. Use -blur 0 3 for typical T1 registration. Usually preceded by 3dAllineate.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `source` | `File` | Yes | Source dataset to be warped | `-source` |
| `base` | `File` | Yes | Base/template dataset | `-base` |
| `prefix` | `string` | Yes | Output dataset prefix | `-prefix` |
| `allineate` | `boolean` | No | Perform preliminary affine alignment via 3dAllineate | `-allineate` |
| `allin` | `boolean` | No | Short form of -allineate | `-allin` |
| `allinfast` | `boolean` | No | Fast affine alignment | `-allinfast` |
| `blur` | `string` | No | Gaussian smoothing in voxels FWHM (one or two values) | `-blur` |
| `pblur` | `boolean` | No | Progressive blurring scaled with patch size | `-pblur` |
| `minpatch` | `int` | No | Minimum patch size (odd integer, default 25) | `-minpatch` |
| `maxlev` | `int` | No | Maximum refinement level | `-maxlev` |
| `inilev` | `int` | No | Initial refinement level | `-inilev` |
| `iniwarp` | `File` | No | Initial warp dataset | `-iniwarp` |
| `duplo` | `boolean` | No | Start with coarse resolution warping | `-duplo` |
| `nowarp` | `boolean` | No | Do not save the warp transformation | `-nowarp` |
| `iwarp` | `boolean` | No | Compute and save inverse warp | `-iwarp` |
| `nodset` | `boolean` | No | Do not save warped source dataset | `-nodset` |
| `emask` | `File` | No | Exclusion mask dataset | `-emask` |
| `noweight` | `boolean` | No | Do not use weighting | `-noweight` |
| `penfac` | `double` | No | Penalty factor for warp smoothness | `-penfac` |
| `verb` | `boolean` | No | Verbose output | `-verb` |
| `quiet` | `boolean` | No | Suppress progress messages | `-quiet` |

### Accepted Input Extensions

- **source**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **base**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **iniwarp**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`, `.1D`, `.txt`
- **emask**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `warped` | `File` | `$(inputs.prefix)+*.HEAD` |
| `warp` | `File` | `$(inputs.prefix)_WARP+*.HEAD` |
| `inverse_warp` | `File` | `$(inputs.prefix)_WARPINV+*.HEAD` |
| `log` | `File` | `$(inputs.prefix).log` |

### Output Extensions

- **warped**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **warp**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **inverse_warp**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Structural MRI > AFNI > Registration

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dQwarp.html)
