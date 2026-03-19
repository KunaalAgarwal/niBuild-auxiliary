# FMRIB's Slice Timing Correction (SliceTimer)

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Corrects for differences in slice acquisition times within each volume using sinc interpolation.

**Modality:** 4D fMRI NIfTI time series.

**Typical Use:** Temporal alignment of slices acquired at different times within each TR.

## Key Parameters

-r (TR in seconds), --odd (interleaved odd slices first), --down (reverse slice order), --tcustom (custom timing file)

## Key Points

Must match actual acquisition order. Important for event-related designs with short TRs. Less critical for long TRs or block designs.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input 4D timeseries | `--in=` |
| `output` | `string` | Yes | Output filename | `--out=` |
| `tr` | `double` | No | TR in seconds | `--repeat=` |
| `global_shift` | `double` | No | Global shift as fraction of TR (0-1, default 0.5) | `--tglobal=` |
| `slice_order` | `record(interleaved) | record(down) | record(custom_order) | record(custom_timings)` | No |  |  |
| `direction` | `int` | No | Slice acquisition direction (1=x, 2=y, 3=z, default 3) | `--direction=` |
| `verbose` | `boolean` | No | Verbose output | `-v` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`
- **custom_order**: `.txt`
- **custom_timings**: `.txt`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `slice_time_corrected` | `File` | `$(inputs.output).nii.gz`, `$(inputs.output).nii` |
| `log` | `File` | `slicetimer.log` |

### Output Extensions

- **slice_time_corrected**: `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Functional MRI > FSL > Slice Timing

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/SliceTimer)
