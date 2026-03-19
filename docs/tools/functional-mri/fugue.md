# FMRIB's Utility for Geometrically Unwarping EPIs (FUGUE)

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Corrects geometric distortions in EPI images caused by magnetic field inhomogeneity using acquired fieldmap data.

**Modality:** 3D/4D EPI NIfTI plus preprocessed fieldmap (in rad/s).

**Typical Use:** Distortion correction when fieldmap data is available.

## Key Parameters

--loadfmap (fieldmap), --dwell (echo spacing in seconds), --unwarpdir (phase-encode direction: x/y/z/-x/-y/-z)

## Key Points

Requires preprocessed fieldmap (e.g., from fsl_prepare_fieldmap). Dwell time and unwarp direction must match acquisition parameters.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | EPI image to unwarp | `-i` |
| `phasemap` | `File` | No | Unwrapped phase image (or two-echo phase difference) | `-p` |
| `loadfmap` | `File` | No | Pre-calculated fieldmap in rad/s | `--loadfmap=` |
| `loadshift` | `File` | No | Pre-calculated voxel shift map | `--loadshift=` |
| `unwarp` | `string` | No | Output unwarped image filename | `-u` |
| `warp` | `string` | No | Output forward warped image filename | `-w` |
| `savefmap` | `string` | No | Save fieldmap in rad/s | `--savefmap=` |
| `saveshift` | `string` | No | Save voxel shift map | `--saveshift=` |
| `dwell` | `double` | No | EPI dwell time / echo spacing (seconds) | `--dwell=` |
| `asym` | `double` | No | Asymmetry time (echo time difference) in ms | `--asym=` |
| `unwarpdir` | `enum` | No | Phase-encode / unwarp direction | `--unwarpdir=` |
| `mask` | `File` | No | Brain mask image | `--mask=` |
| `smooth2` | `double` | No | 2D Gaussian smoothing sigma | `-s` |
| `smooth3` | `double` | No | 3D Gaussian smoothing sigma | `--smooth3=` |
| `median` | `boolean` | No | Apply 2D median filter | `-m` |
| `poly` | `int` | No | 3D polynomial fitting degree | `--poly=` |
| `fourier` | `int` | No | 3D sinusoidal fitting degree | `--fourier=` |
| `despike` | `boolean` | No | Apply despiking filter | `--despike` |
| `phaseconj` | `boolean` | No | Use phase conjugate method | `--phaseconj` |
| `nokspace` | `boolean` | No | Use image-space forward warping | `--nokspace` |
| `icorr` | `boolean` | No | Apply intensity correction | `--icorr` |
| `icorronly` | `boolean` | No | Only apply intensity correction (no unwarp) | `--icorronly` |
| `noextend` | `boolean` | No | Do not extend shifted voxels outside FOV | `--noextend` |
| `verbose` | `boolean` | No | Verbose output | `-v` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`
- **phasemap**: `.nii`, `.nii.gz`
- **loadfmap**: `.nii`, `.nii.gz`
- **loadshift**: `.nii`, `.nii.gz`
- **mask**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `unwarped_image` | `File` | `$(inputs.unwarp).nii.gz`, `$(inputs.unwarp).nii` |
| `warped_image` | `File` | `$(inputs.warp).nii.gz`, `$(inputs.warp).nii` |
| `fieldmap_output` | `File` | `$(inputs.savefmap).nii.gz`, `$(inputs.savefmap).nii` |
| `shiftmap_output` | `File` | `$(inputs.saveshift).nii.gz`, `$(inputs.saveshift).nii` |
| `log` | `File` | `fugue.log` |

### Output Extensions

- **unwarped_image**: `.nii`, `.nii.gz`
- **warped_image**: `.nii`, `.nii.gz`
- **fieldmap_output**: `.nii`, `.nii.gz`
- **shiftmap_output**: `.nii`, `.nii.gz`

## Enum Options

**`unwarpdir`**: `x`, `y`, `z`, `x-`, `y-`, `z-`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Functional MRI > FSL > Distortion Correction

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FUGUE)
