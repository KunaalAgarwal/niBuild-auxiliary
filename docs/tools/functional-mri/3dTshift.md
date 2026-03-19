# AFNI 3D Temporal Shift (3dTshift)

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Corrects for slice timing differences by shifting each voxel time series to a common temporal reference.

**Modality:** 4D fMRI NIfTI/AFNI time series.

**Typical Use:** Aligning all slices to the same temporal reference in fMRI data.

## Key Parameters

-prefix (output), -tpattern (slice timing pattern: alt+z, seq+z, etc.), -tzero (align to time zero), -TR (repetition time)

## Key Points

Auto-detects slice timing from header if available. Common patterns: alt+z (interleaved ascending), seq+z (sequential ascending).

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input 3D+time dataset |  |
| `prefix` | `string` | Yes | Output dataset prefix | `-prefix` |
| `TR` | `double` | No | TR in seconds (overrides header value) | `-TR` |
| `tzero` | `double` | No | Align each slice to this time offset | `-tzero` |
| `slice` | `int` | No | Align to temporal offset of this slice number | `-slice` |
| `tpattern` | `string` | No | Slice timing pattern (alt+z, alt-z, seq+z, seq-z, @filename) | `-tpattern` |
| `ignore` | `int` | No | Ignore the first N points (default 0) | `-ignore` |
| `rlt` | `boolean` | No | Remove mean and linear trend from output | `-rlt` |
| `rlt_plus` | `boolean` | No | Remove trend then restore only mean to output | `-rlt+` |
| `no_detrend` | `boolean` | No | Do not remove or restore linear trend | `-no_detrend` |
| `Fourier` | `boolean` | No | Fourier interpolation (default, most accurate) | `-Fourier` |
| `linear` | `boolean` | No | Linear interpolation (least accurate) | `-linear` |
| `cubic` | `boolean` | No | Cubic Lagrange polynomial interpolation | `-cubic` |
| `quintic` | `boolean` | No | Quintic Lagrange polynomial interpolation | `-quintic` |
| `heptic` | `boolean` | No | Heptic Lagrange polynomial interpolation | `-heptic` |
| `wsinc5` | `boolean` | No | Weighted sinc interpolation (plus/minus 5) | `-wsinc5` |
| `wsinc9` | `boolean` | No | Weighted sinc interpolation (plus/minus 9) | `-wsinc9` |
| `voxshift` | `File` | No | Dataset with voxel-wise shift fractions per TR | `-voxshift` |
| `verbose` | `boolean` | No | Print lots of messages while program runs | `-verbose` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **voxshift**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `shifted` | `File` | `$(inputs.prefix)+orig.HEAD`, `$(inputs.prefix)+tlrc.HEAD` |
| `log` | `File` | `$(inputs.prefix).log` |

### Output Extensions

- **shifted**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Functional MRI > AFNI > Slice Timing

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dTshift.html)
