# AFNI 3D Nonlinear Warp Concatenate

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Concatenates multiple nonlinear warps and affine matrices into a single combined warp.

**Modality:** Multiple warp datasets and/or affine matrix files.

**Typical Use:** Combining transformations efficiently for one-step resampling.

## Key Parameters

-prefix (output), -warp1/-warp2/... (warps to concatenate), -iwarp (use inverse of a warp)

## Key Points

Reduces interpolation artifacts from multiple separate applications. Can invert individual warps in the chain.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `prefix` | `string` | Yes | Output dataset prefix for concatenated warp | `-prefix` |
| `warp1` | `File` | Yes | First warp input | `-warp1` |
| `warp2` | `File` | No | Second warp input | `-warp2` |
| `warp3` | `File` | No | Third warp input | `-warp3` |
| `warp4` | `File` | No | Fourth warp input | `-warp4` |
| `interp` | `enum` | No | Interpolation mode (default wsinc5) | `-interp` |
| `iwarp` | `boolean` | No | Invert final output warp before writing | `-iwarp` |
| `space` | `string` | No | Attach atlas space marker string | `-space` |
| `expad` | `int` | No | Pad nonlinear warps by specified voxels | `-expad` |
| `verb` | `boolean` | No | Enable verbose output | `-verb` |

### Accepted Input Extensions

- **warp1**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **warp2**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **warp3**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **warp4**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `concatenated_warp` | `File` | `$(inputs.prefix)+*.HEAD` |
| `log` | `File` | `$(inputs.prefix).log` |

### Output Extensions

- **concatenated_warp**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Enum Options

**`interp`**: `linear`, `quintic`, `wsinc5`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Utilities > AFNI > Warp Utilities

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dNwarpCat.html)
