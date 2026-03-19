# AFNI 3D Bandpass Filter (3dBandpass)

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Applies temporal bandpass filtering to fMRI time series with optional simultaneous nuisance regression.

**Modality:** 4D fMRI NIfTI/AFNI time series.

**Typical Use:** Resting-state frequency filtering (typically 0.01-0.1 Hz).

## Key Parameters

<fbot> <ftop> (frequency range in Hz), -prefix (output), -ort (nuisance regressors file)

## Key Points

Typical resting-state range: 0.01-0.1 Hz. Can simultaneously regress nuisance signals with -ort.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input 3D+time dataset |  |
| `prefix` | `string` | Yes | Output dataset prefix | `-prefix` |
| `fbot` | `double` | Yes | Lowest frequency in passband (Hz), can be 0 for lowpass |  |
| `ftop` | `double` | Yes | Highest frequency in passband (Hz) |  |
| `band` | `string` | No | Alternative passband specification (fbot ftop) | `-band` |
| `despike` | `boolean` | No | Remove spikes from time series before processing | `-despike` |
| `nodetrend` | `boolean` | No | Skip quadratic detrending before FFT bandpassing | `-nodetrend` |
| `notrans` | `boolean` | No | Skip initial transient checking | `-notrans` |
| `ort` | `File` | No | Orthogonalize input to columns in 1D file | `-ort` |
| `dsort` | `File` | No | Orthogonalize each voxel to matching voxel in dataset | `-dsort` |
| `dt` | `double` | No | Set time step in seconds (default from header) | `-dt` |
| `nfft` | `int` | No | Specify FFT length | `-nfft` |
| `mask` | `File` | No | Apply mask dataset | `-mask` |
| `automask` | `boolean` | No | Generate mask from input dataset | `-automask` |
| `blur` | `double` | No | Apply spatial filtering with specified FWHM (mm) | `-blur` |
| `localPV` | `double` | No | Replace vectors with local principal vector (radius in mm) | `-localPV` |
| `norm` | `boolean` | No | Normalize output time series to L2 norm = 1 | `-norm` |
| `quiet` | `boolean` | No | Suppress informational messages | `-quiet` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **ort**: `.1D`, `.txt`
- **dsort**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **mask**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `filtered` | `File` | `$(inputs.prefix)+orig.HEAD`, `$(inputs.prefix)+tlrc.HEAD` |
| `log` | `File` | `$(inputs.prefix).log` |

### Output Extensions

- **filtered**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Functional MRI > AFNI > Denoising

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dBandpass.html)
