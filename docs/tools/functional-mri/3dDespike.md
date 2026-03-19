# AFNI 3D Despike (3dDespike)

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Removes transient signal spikes from fMRI time series using an L1-norm fitting approach.

**Modality:** 4D fMRI NIfTI/AFNI time series.

**Typical Use:** Artifact removal before other preprocessing steps.

## Key Parameters

-prefix (output), -ssave (save spike fit), -nomask (process all voxels), -NEW (updated algorithm)

## Key Points

Run early in preprocessing pipeline (before motion correction). -NEW algorithm recommended.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input 3D+time dataset |  |
| `prefix` | `string` | Yes | Output dataset prefix | `-prefix` |
| `ignore` | `int` | No | Ignore the first I points in the time series | `-ignore` |
| `corder` | `int` | No | Curve fit order (default NT/30) | `-corder` |
| `cut` | `string` | No | Spike threshold values (default "2.5 4.0") | `-cut` |
| `nomask` | `boolean` | No | Process all voxels instead of using auto-mask | `-nomask` |
| `dilate` | `int` | No | Dilation iterations for automask (default 4) | `-dilate` |
| `localedit` | `boolean` | No | Use alternative spike replacement method | `-localedit` |
| `NEW` | `boolean` | No | Use faster fitting method for long series | `-NEW` |
| `NEW25` | `boolean` | No | More aggressive despiking than NEW | `-NEW25` |
| `OLD` | `boolean` | No | Disable NEW processing if enabled | `-OLD` |
| `ssave` | `string` | No | Save spikiness measure to 3D+time dataset | `-ssave` |
| `quiet` | `boolean` | No | Suppress informational messages | `-quiet` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `despiked` | `File` | `$(inputs.prefix)+orig.HEAD`, `$(inputs.prefix)+tlrc.HEAD` |
| `spikiness` | `File` | `$(inputs.ssave)+orig.HEAD`, `$(inputs.ssave)+tlrc.HEAD` |
| `log` | `File` | `$(inputs.prefix).log` |

### Output Extensions

- **despiked**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **spikiness**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Functional MRI > AFNI > Denoising

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dDespike.html)
