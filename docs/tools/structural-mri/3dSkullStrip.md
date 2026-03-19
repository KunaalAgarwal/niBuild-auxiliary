# AFNI 3D Skull Strip

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Removes non-brain tissue using a modified spherical surface expansion algorithm adapted from BET.

**Modality:** T1-weighted or T2-weighted 3D NIfTI/AFNI volume.

**Typical Use:** Brain extraction for structural or functional images in AFNI pipelines.

## Key Parameters

-input (input dataset), -prefix (output prefix), -push_to_edge (expand mask), -orig_vol (output original volume)

## Key Points

Often more aggressive than BET. Use -push_to_edge if too much brain is removed. Works on T1 or T2 images.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input volume | `-input` |
| `prefix` | `string` | Yes | Output volume prefix | `-prefix` |
| `mask_vol` | `boolean` | No | Output mask volume instead of skull-stripped volume | `-mask_vol` |
| `orig_vol` | `boolean` | No | Preserve original intensity values | `-orig_vol` |
| `skulls` | `boolean` | No | Output skull surface models | `-skulls` |
| `niter` | `int` | No | Iteration count (default 250) | `-niter` |
| `shrink_fac` | `double` | No | Brain/non-brain intensity threshold (0-1, default 0.6) | `-shrink_fac` |
| `var_shrink_fac` | `boolean` | No | Vary shrink factor across iterations (default) | `-var_shrink_fac` |
| `no_var_shrink_fac` | `boolean` | No | Keep constant shrink factor | `-no_var_shrink_fac` |
| `shrink_fac_bot_lim` | `double` | No | Minimum shrink factor (default 0.65-0.4) | `-shrink_fac_bot_lim` |
| `init_radius` | `double` | No | Initial sphere radius in mm | `-init_radius` |
| `exp_frac` | `double` | No | Expansion speed (default 0.1) | `-exp_frac` |
| `push_to_edge` | `boolean` | No | Aggressive push to brain edges | `-push_to_edge` |
| `no_push_to_edge` | `boolean` | No | Disable aggressive edge push (default) | `-no_push_to_edge` |
| `touchup` | `boolean` | No | Include uncovered areas (default) | `-touchup` |
| `no_touchup` | `boolean` | No | Skip touchup operations | `-no_touchup` |
| `fill_hole` | `double` | No | Fill holes up to R pixels | `-fill_hole` |
| `smooth_final` | `int` | No | Final smoothing iterations (default 20) | `-smooth_final` |
| `avoid_vent` | `boolean` | No | Avoid ventricles (default) | `-avoid_vent` |
| `no_avoid_vent` | `boolean` | No | Disable ventricle avoidance | `-no_avoid_vent` |
| `avoid_eyes` | `boolean` | No | Avoid eyes (default) | `-avoid_eyes` |
| `no_avoid_eyes` | `boolean` | No | Disable eye avoidance | `-no_avoid_eyes` |
| `use_edge` | `boolean` | No | Edge detection to reduce leakage (default) | `-use_edge` |
| `no_use_edge` | `boolean` | No | Disable edge detection | `-no_use_edge` |
| `blur_fwhm` | `double` | No | Blur kernel width (recommended 2-4) | `-blur_fwhm` |
| `monkey` | `boolean` | No | Process monkey brain data | `-monkey` |
| `marmoset` | `boolean` | No | Process marmoset brain data | `-marmoset` |
| `rat` | `boolean` | No | Process rat brain data | `-rat` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `skull_stripped` | `File` | `$(inputs.prefix)+orig.HEAD`, `$(inputs.prefix)+tlrc.HEAD` |
| `mask` | `File` | `$(inputs.prefix)_mask+orig.HEAD`, `$(inputs.prefix)_mask+tlrc.HEAD` |
| `log` | `File` | `$(inputs.prefix).log` |

### Output Extensions

- **skull_stripped**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **mask**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Parameter Bounds

| Parameter | Min | Max |
|---|---|---|
| `shrink_fac` | 0 | 1 |

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Structural MRI > AFNI > Brain Extraction

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dSkullStrip.html)
