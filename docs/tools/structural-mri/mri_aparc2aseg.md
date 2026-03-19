# FreeSurfer Cortical Parcellation to Volume

**Library:** FreeSurfer | **Docker Image:** `freesurfer/freesurfer`

## Function

Combines surface-based cortical parcellation (aparc) with volumetric subcortical segmentation (aseg) into a single volume.

**Modality:** FreeSurfer subject directory (requires completed recon-all).

**Typical Use:** Creating volumetric parcellation from surface labels for ROI analysis.

## Key Parameters

--s (subject), --annot (annotation name, default aparc), --o (output volume)

## Key Points

Creates aparc+aseg.mgz combining ~80 cortical and subcortical regions. Different parcellation schemes available.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `subjects_dir` | `Directory` | Yes | FreeSurfer SUBJECTS_DIR |  |
| `fs_license` | `File` | Yes | FreeSurfer license file |  |
| `subject` | `string` | Yes | Subject name | `--s` |
| `output` | `string` | No | Output volume filename | `--o` |
| `volmask` | `File` | No | Volume mask for output | `--volmask` |
| `annot` | `string` | No | Parcellation name (default aparc) | `--annot` |
| `a2005s` | `boolean` | No | Use aparc.a2005s parcellation | `--a2005s` |
| `a2009s` | `boolean` | No | Use aparc.a2009s parcellation | `--a2009s` |
| `labelwm` | `boolean` | No | Also label white matter parcels | `--labelwm` |
| `rip_unknown` | `boolean` | No | Rip unknown label | `--rip-unknown` |
| `hypo_as_wm` | `boolean` | No | Label hypointensities as white matter | `--hypo-as-wm` |
| `noribbon` | `boolean` | No | Do not use ribbon constraint | `--noribbon` |
| `ribbon` | `File` | No | Use specified ribbon file | `--ribbon` |
| `ctxseg` | `boolean` | No | Create segmentation of cortex | `--ctxseg` |
| `wmparc_dmax` | `double` | No | Distance max for WM parcellation | `--wmparc-dmax` |
| `ctxgmrmax` | `double` | No | Radius for cortical GM assignment | `--crs-test` |

### Accepted Input Extensions

- **volmask**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`
- **ribbon**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `aparc_aseg` | `File` | `$(inputs.output)`, `*aparc+aseg*.mgz`, `*aparc+aseg*.nii.gz` |
| `log` | `File` | `mri_aparc2aseg.log` |

### Output Extensions

- **aparc_aseg**: `.mgz`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `8.1.0`, `8.0.0`, `7.2.0`, `7.3.0`, `7.3.1`, `7.3.2`, `7.4.1`, `7.1.1`, `6.0`

## Categories

- Structural MRI > FreeSurfer > Parcellation

## Documentation

[Official Documentation](https://surfer.nmr.mgh.harvard.edu/fswiki/mri_aparc2aseg)
