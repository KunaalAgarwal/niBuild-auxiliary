# AFNI Automated Talairach Transformation (@auto_tlrc)

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Automated Talairach transformation using affine registration to a template atlas.

**Modality:** T1-weighted 3D NIfTI/AFNI volume.

**Typical Use:** Legacy Talairach normalization.

## Key Parameters

-base (template), -input (anatomical), -no_ss (skip skull strip)

## Key Points

Legacy tool for Talairach normalization. For modern analyses, prefer @SSwarper or 3dQwarp.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input anatomical dataset |  |
| `base` | `File` | Yes | Reference template in standard space (e.g., TT_N27+tlrc) |  |
| `suffix` | `string` | No | Output dataset suffix |  |
| `no_ss` | `boolean` | No | Do not strip skull of input dataset |  |
| `warp_orig_vol` | `boolean` | No | Preserve skull in output by warping original volume |  |
| `dxyz` | `double` | No | Cubic voxel size in mm (default matches template) |  |
| `dx` | `double` | No | X voxel dimension in mm |  |
| `dy` | `double` | No | Y voxel dimension in mm |  |
| `dz` | `double` | No | Z voxel dimension in mm |  |
| `pad_base` | `double` | No | Padding in mm to prevent cropping (default 15) |  |
| `xform` | `enum` | No | Warping transformation type |  |
| `init_xform` | `File` | No | Apply preliminary affine transform before registration |  |
| `maxite` | `int` | No | Maximum iterations for alignment algorithm |  |
| `use_3dAllineate` | `boolean` | No | Use 3dAllineate instead of 3dWarpDrive |  |
| `apar` | `File` | No | Reference anatomical for applying transform |  |
| `onewarp` | `boolean` | No | Single interpolation step |  |
| `twowarp` | `boolean` | No | Dual interpolation steps |  |
| `overwrite` | `boolean` | No | Replace existing outputs |  |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **base**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **init_xform**: `.1D`, `.txt`
- **apar**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `tlrc_anat` | `File` | `*+tlrc.HEAD`, `*_at.nii`, `*_at.nii.gz` |
| `transform` | `File` | `*.Xat.1D` |
| `log` | `File` | `auto_tlrc_stdout.log` |
| `err_log` | `File` | `auto_tlrc_stderr.log` |

### Output Extensions

- **tlrc_anat**: `+tlrc.HEAD`, `+tlrc.BRIK`, `.nii`, `.nii.gz`
- **transform**: `.Xat.1D`

## Enum Options

**`xform`**: `affine_general`, `shift_rotate_scale`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Structural MRI > AFNI > Registration

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/@auto_tlrc.html)
