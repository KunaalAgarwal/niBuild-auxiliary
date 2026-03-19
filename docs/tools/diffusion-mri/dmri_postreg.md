# FreeSurfer Diffusion Post-Registration Processing

**Library:** FreeSurfer | **Docker Image:** `freesurfer/freesurfer`

## Function

Post-registration processing for diffusion MRI data as part of the TRACULA tractography pipeline.

**Modality:** Registered diffusion MRI data within FreeSurfer/TRACULA directory structure.

**Typical Use:** Part of TRACULA pipeline for automated tractography.

## Key Parameters

--s (subject), --reg (registration method: bbr or manual)

## Key Points

Part of TRACULA pipeline. Handles diffusion-to-structural registration refinement. Usually called by trac-all.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `subjects_dir` | `Directory` | Yes | FreeSurfer SUBJECTS_DIR |  |
| `fs_license` | `File` | Yes | FreeSurfer license file |  |
| `input` | `File` | Yes | Input diffusion volume | `--i` |
| `output` | `string` | Yes | Output filename | `--o` |
| `reg` | `File` | No | Registration file (DWI to anatomy) | `--reg` |
| `xfm` | `File` | No | Transformation matrix | `--xfm` |
| `ref` | `File` | No | Reference volume | `--ref` |
| `mask` | `File` | No | Brain mask | `--mask` |
| `subject` | `string` | No | FreeSurfer subject name | `--s` |
| `interp` | `enum` | No | Interpolation method | `--interp` |
| `noresample` | `boolean` | No | Do not resample | `--noresample` |

### Accepted Input Extensions

- **input**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`
- **reg**: `.dat`, `.lta`
- **xfm**: `.xfm`, `.lta`, `.dat`
- **ref**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`
- **mask**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `out_file` | `File` | `$(inputs.output)*` |
| `log` | `File` | `dmri_postreg.log` |

### Output Extensions

- **out_file**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`

## Enum Options

**`interp`**: `nearest`, `trilin`, `cubic`

## Docker Tags

Available versions: `latest`, `8.1.0`, `8.0.0`, `7.2.0`, `7.3.0`, `7.3.1`, `7.3.2`, `7.4.1`, `7.1.1`, `6.0`

## Categories

- Diffusion MRI > FreeSurfer > Diffusion

## Documentation

[Official Documentation](https://surfer.nmr.mgh.harvard.edu/fswiki/dmri_postreg)
