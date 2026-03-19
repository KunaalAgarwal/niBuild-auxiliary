# AFNI Skull Strip and Nonlinear Warp (@SSwarper)

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Combined skull stripping and non-linear warping to template in a single optimized pipeline.

**Modality:** T1-weighted 3D NIfTI volume plus reference template.

**Typical Use:** Modern anatomical preprocessing for afni_proc.py pipelines.

## Key Parameters

-input (T1 image), -base (template), -subid (subject ID), -odir (output dir)

## Key Points

Preferred over separate skull-strip + registration. Output compatible with afni_proc.py.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input anatomical dataset (non-skull-stripped, ~1mm resolution) | `-input` |
| `base` | `File` | Yes | Base template dataset with similar contrast | `-base` |
| `subid` | `string` | Yes | Subject ID code for output datasets | `-subid` |
| `odir` | `string` | No | Output directory (default is input directory) | `-odir` |
| `minp` | `int` | No | Minimum patch size for 3dQwarp (default 11) | `-minp` |
| `warpscale` | `double` | No | Control warp flexibility (0.1-1.0, default 1.0) | `-warpscale` |
| `skipwarp` | `boolean` | No | Stop after skull-stripping, skip warping to template | `-skipwarp` |
| `deoblique` | `boolean` | No | Apply obliquity correction using 3dWarp | `-deoblique` |
| `deoblique_refitly` | `boolean` | No | Remove obliquity information via 3drefit | `-deoblique_refitly` |
| `unifize_off` | `boolean` | No | Skip intensity uniformization step | `-unifize_off` |
| `aniso_off` | `boolean` | No | Skip anisotropic smoothing preprocessing | `-aniso_off` |
| `ceil_off` | `boolean` | No | Skip ceiling value capping at 98th percentile | `-ceil_off` |
| `init_skullstr_off` | `boolean` | No | Skip initial skull-stripping pass | `-init_skullstr_off` |
| `cost_nl_init` | `string` | No | Cost function for initial nonlinear alignment (default lpa) | `-cost_nl_init` |
| `cost_nl_final` | `string` | No | Cost function for final nonlinear alignment (default pcl) | `-cost_nl_final` |
| `giant_move` | `boolean` | No | Apply expanded parameter alignment for extreme angles | `-giant_move` |
| `mask_ss` | `File` | No | Provide mask instead of performing skull-stripping | `-mask_ss` |
| `SSopt` | `string` | No | Additional options passed to 3dSkullStrip | `-SSopt` |
| `extra_qc_off` | `boolean` | No | Omit extra QC JPEG images | `-extra_qc_off` |
| `nolite` | `boolean` | No | Disable lite option in 3dQwarp | `-nolite` |
| `verb` | `boolean` | No | Enable verbose 3dQwarp output | `-verb` |
| `noclean` | `boolean` | No | Preserve temporary files after completion | `-noclean` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **base**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **mask_ss**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `skull_stripped` | `File` | `anatSS.$(inputs.subid).nii`, `anatSS.$(inputs.subid).nii.gz` |
| `warped` | `File` | `anatQQ.$(inputs.subid)+tlrc.HEAD`, `anatQQ.$(inputs.subid)+tlrc.BRIK`, `anatQQ.$(inputs.subid)+tlrc.BRIK.gz`, `anatQQ.$(inputs.subid).nii`, `anatQQ.$(inputs.subid).nii.gz` |
| `warp` | `File` | `anatQQ.$(inputs.subid)_WARP+tlrc.HEAD`, `anatQQ.$(inputs.subid)_WARP+tlrc.BRIK`, `anatQQ.$(inputs.subid)_WARP+tlrc.BRIK.gz`, `anatQQ.$(inputs.subid)_WARP.nii`, `anatQQ.$(inputs.subid)_WARP.nii.gz` |
| `affine` | `File` | `anatQQ.$(inputs.subid).aff12.1D` |
| `log` | `File` | `$(inputs.subid)_SSwarper.log` |

### Output Extensions

- **skull_stripped**: `.nii`, `.nii.gz`
- **warped**: `+tlrc.HEAD`, `+tlrc.BRIK`, `.nii`, `.nii.gz`
- **warp**: `+tlrc.HEAD`, `+tlrc.BRIK`, `.nii`, `.nii.gz`
- **affine**: `.aff12.1D`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Structural MRI > AFNI > Brain Extraction

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/@SSwarper.html)
