# AFNI 3D Intensity Uniformization (3dUnifize)

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Corrects intensity inhomogeneity (bias field) to produce uniform white matter intensity.

**Modality:** T1-weighted or T2-weighted 3D NIfTI/AFNI volume.

**Typical Use:** Bias correction before segmentation or registration.

## Key Parameters

-input (input), -prefix (output), -T2 (for T2-weighted input), -GM (also unifize gray matter)

## Key Points

Fast bias correction alternative to N4. Works well for T1 images by default. Use -T2 flag for T2-weighted images.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input dataset | `-input` |
| `prefix` | `string` | Yes | Output dataset prefix | `-prefix` |
| `T2` | `boolean` | No | Process input as T2-weighted (inverts contrast) | `-T2` |
| `EPI` | `boolean` | No | Process T2/T2* weighted EPI time series | `-EPI` |
| `GM` | `boolean` | No | Scale to unifize gray matter intensities | `-GM` |
| `Urad` | `double` | No | Radius in voxels for processing ball (default 18.3) | `-Urad` |
| `clfrac` | `double` | No | Automask clip level fraction (0.1-0.9, default 0.2) | `-clfrac` |
| `noduplo` | `boolean` | No | Disable half-size volume processing step | `-noduplo` |
| `nosquash` | `boolean` | No | Disable reduction of large intensity values | `-nosquash` |
| `T2up` | `double` | No | Upper percentile for T2-T1 inversion (90-100) | `-T2up` |
| `rbt` | `string` | No | Algorithm parameters (radius bottom_percentile top_percentile) | `-rbt` |
| `ssave` | `string` | No | Save white matter scale factors to dataset | `-ssave` |
| `amsave` | `string` | No | Save automask-ed input dataset | `-amsave` |
| `quiet` | `boolean` | No | Suppress progress messages | `-quiet` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `unifized` | `File` | `$(inputs.prefix)+orig.HEAD`, `$(inputs.prefix)+tlrc.HEAD` |
| `scale_factors` | `File` | `$(inputs.ssave)+orig.HEAD`, `$(inputs.ssave)+tlrc.HEAD` |
| `automask` | `File` | `$(inputs.amsave)+orig.HEAD`, `$(inputs.amsave)+tlrc.HEAD` |
| `log` | `File` | `$(inputs.prefix).log` |

### Output Extensions

- **unifized**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **scale_factors**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **automask**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Structural MRI > AFNI > Bias Correction

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dUnifize.html)
