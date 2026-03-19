# FreeSurfer MRI Intensity Normalization

**Library:** FreeSurfer | **Docker Image:** `freesurfer/freesurfer`

## Function

Normalizes T1 image intensities so that white matter has a target intensity value (default 110).

**Modality:** T1-weighted 3D volume (MGZ format, within FreeSurfer pipeline).

**Typical Use:** Preparing T1 for segmentation within FreeSurfer pipeline.

## Key Parameters

-n (number of iterations), -b (bias field smoothing sigma), -aseg (use aseg for normalization regions)

## Key Points

Part of recon-all autorecon1. Creates nu.mgz (non-uniformity corrected) and T1.mgz (intensity normalized).

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `subjects_dir` | `Directory` | Yes | FreeSurfer SUBJECTS_DIR |  |
| `fs_license` | `File` | Yes | FreeSurfer license file |  |
| `input` | `File` | Yes | Input volume |  |
| `output` | `string` | Yes | Output normalized volume filename |  |
| `gradient` | `double` | No | Max intensity/mm gradient (default 1) | `-g` |
| `niters` | `int` | No | Number of 3D normalization iterations | `-n` |
| `mask` | `File` | No | Input mask file | `-mask` |
| `noskull` | `boolean` | No | Do not normalize skull regions | `-noskull` |
| `aseg` | `File` | No | Input segmentation for guidance | `-aseg` |
| `noaseg` | `boolean` | No | Do not use aseg for normalization | `-noaseg` |
| `control_points` | `File` | No | Control points file | `-f` |
| `seed` | `int` | No | Random seed | `-seed` |
| `bias` | `double` | No | Bias field FWHM | `-b` |
| `sigma` | `double` | No | Sigma for bias field smoothing | `-sigma` |
| `brain_mask` | `File` | No | Brain mask volume | `-brainmask` |
| `mprage` | `boolean` | No | Assume darker gray matter (MPRAGE) | `-mprage` |
| `conform` | `boolean` | No | Conform to 256^3 and 1mm | `-conform` |
| `gentle` | `boolean` | No | Perform gentler normalization | `-gentle` |
| `disable_logging` | `boolean` | No | Disable logging | `-nolog` |

### Accepted Input Extensions

- **input**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`
- **mask**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`
- **aseg**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`
- **control_points**: `.dat`
- **brain_mask**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `normalized` | `File` | `$(inputs.output)*` |
| `log` | `File` | `mri_normalize.log` |

### Output Extensions

- **normalized**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `8.1.0`, `8.0.0`, `7.2.0`, `7.3.0`, `7.3.1`, `7.3.2`, `7.4.1`, `7.1.1`, `6.0`

## Categories

- Structural MRI > FreeSurfer > Surface Reconstruction

## Documentation

[Official Documentation](https://surfer.nmr.mgh.harvard.edu/fswiki/mri_normalize)
