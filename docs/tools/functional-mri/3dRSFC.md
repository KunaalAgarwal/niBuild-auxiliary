# AFNI 3D Resting State Functional Connectivity (3dRSFC)

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Computes resting-state frequency-domain metrics including ALFF, fALFF, mALFF, and RSFA from bandpass-filtered data.

**Modality:** 4D resting-state fMRI NIfTI/AFNI time series plus brain mask.

**Typical Use:** Amplitude of low-frequency fluctuations analysis in resting-state fMRI.

## Key Parameters

<fbot> <ftop> (frequency range), -prefix (output), -input (4D data), -mask (brain mask)

## Key Points

Computes ALFF (amplitude of low-frequency fluctuations), fALFF (fractional ALFF), and RSFA.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input 3D+time dataset |  |
| `prefix` | `string` | Yes | Output dataset prefix | `-prefix` |
| `fbot` | `double` | Yes | Lowest frequency in passband (Hz) |  |
| `ftop` | `double` | Yes | Highest frequency in passband (Hz) |  |
| `band` | `string` | No | Alternative passband specification (fbot ftop) | `-band` |
| `despike` | `boolean` | No | Despike each time series before processing | `-despike` |
| `nodetrend` | `boolean` | No | Skip quadratic detrending before FFT | `-nodetrend` |
| `notrans` | `boolean` | No | Skip initial transient checking | `-notrans` |
| `ort` | `File` | No | Orthogonalize input to columns in 1D file | `-ort` |
| `dsort` | `File` | No | Orthogonalize each voxel to matching voxel in dataset | `-dsort` |
| `dt` | `double` | No | Set time step in seconds (default from header) | `-dt` |
| `nfft` | `int` | No | FFT length | `-nfft` |
| `mask` | `File` | No | Mask dataset | `-mask` |
| `automask` | `boolean` | No | Create mask from input dataset | `-automask` |
| `blur` | `double` | No | Blur filter width FWHM in mm | `-blur` |
| `localPV` | `double` | No | Replace vectors with local principal vector (radius in mm) | `-localPV` |
| `norm` | `boolean` | No | Make output time series have L2 norm = 1 | `-norm` |
| `no_rs_out` | `boolean` | No | Skip time series output, calculate parameters only | `-no_rs_out` |
| `un_bp_out` | `boolean` | No | Output un-bandpassed series | `-un_bp_out` |
| `no_rsfa` | `boolean` | No | Skip RSFA parameter calculation | `-no_rsfa` |
| `bp_at_end` | `boolean` | No | Perform bandpassing as final step | `-bp_at_end` |
| `quiet` | `boolean` | No | Suppress informational messages | `-quiet` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **ort**: `.1D`, `.txt`
- **dsort**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **mask**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `filtered` | `File` | `$(inputs.prefix)_LFF+orig.HEAD`, `$(inputs.prefix)_LFF+tlrc.HEAD` |
| `alff` | `File` | `$(inputs.prefix)_ALFF+orig.HEAD`, `$(inputs.prefix)_ALFF+tlrc.HEAD` |
| `falff` | `File` | `$(inputs.prefix)_fALFF+orig.HEAD`, `$(inputs.prefix)_fALFF+tlrc.HEAD` |
| `rsfa` | `File` | `$(inputs.prefix)_RSFA+orig.HEAD`, `$(inputs.prefix)_RSFA+tlrc.HEAD` |
| `log` | `File` | `$(inputs.prefix).log` |

### Output Extensions

- **filtered**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **alff**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **falff**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **rsfa**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Functional MRI > AFNI > Connectivity

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dRSFC.html)
