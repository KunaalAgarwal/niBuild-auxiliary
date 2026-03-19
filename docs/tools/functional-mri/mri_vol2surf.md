# FreeSurfer Volume to Surface Projection

**Library:** FreeSurfer | **Docker Image:** `freesurfer/freesurfer`

## Function

Projects volumetric data (fMRI, PET, etc.) onto the cortical surface using specified sampling method.

**Modality:** 3D or 4D NIfTI/MGZ volume plus FreeSurfer subject registration.

**Typical Use:** Mapping functional or PET data to cortical surface for surface-based analysis.

## Key Parameters

--mov (input volume), --reg (registration), --hemi (hemisphere), --projfrac (fraction of cortical thickness), --o (output)

## Key Points

Use --projfrac 0.5 to sample at mid-cortical depth. Can average across depths with --projfrac-avg.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `subjects_dir` | `Directory` | Yes | FreeSurfer SUBJECTS_DIR |  |
| `fs_license` | `File` | Yes | FreeSurfer license file |  |
| `source_file` | `File` | Yes | Volume to sample from | `--src` |
| `hemi` | `enum` | Yes | Hemisphere (lh or rh) | `--hemi` |
| `output` | `string` | Yes | Output surface file | `--out` |
| `reg_file` | `File` | No | Registration file (tkregister format) | `--reg` |
| `reg_header` | `string` | No | Subject name for header registration | `--regheader` |
| `mni152reg` | `boolean` | No | Use MNI152 registration | `--mni152reg` |
| `subject` | `string` | No | Source subject name | `--srcsubject` |
| `trgsubject` | `string` | No | Target subject (for resampling) | `--trgsubject` |
| `projfrac` | `double` | No | Projection fraction along normal (0=white, 1=pial) | `--projfrac` |
| `projfrac_avg` | `string` | No | Average along normal (start stop delta) | `--projfrac-avg` |
| `projfrac_max` | `string` | No | Maximum along normal (start stop delta) | `--projfrac-max` |
| `projdist` | `double` | No | Projection distance in mm | `--projdist` |
| `interp` | `enum` | No | Interpolation method | `--interp` |
| `surf` | `string` | No | Surface name (default white) | `--surf` |
| `surf_file` | `File` | No | Explicit surface file | `--surfval` |
| `mask_label` | `File` | No | Only sample within label | `--mask` |
| `cortex` | `boolean` | No | Use cortex label as mask | `--cortex` |
| `frame` | `int` | No | Only convert this frame | `--frame` |
| `out_type` | `enum` | No | Output file format | `--out_type` |

### Accepted Input Extensions

- **source_file**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`
- **reg_file**: `.dat`, `.lta`
- **surf_file**: `.white`, `.pial`, `.inflated`, `.smoothwm`, `.orig`
- **mask_label**: `.label`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `out_file` | `File` | `$(inputs.output)*` |
| `log` | `File` | `mri_vol2surf.log` |

### Output Extensions

- **out_file**: `.mgh`, `.mgz`, `.nii`, `.nii.gz`, `.w`

## Enum Options

**`interp`**: `nearest`, `trilinear`

## Docker Tags

Available versions: `latest`, `8.1.0`, `8.0.0`, `7.2.0`, `7.3.0`, `7.3.1`, `7.3.2`, `7.4.1`, `7.1.1`, `6.0`

## Categories

- Functional MRI > FreeSurfer > Functional Analysis

## Documentation

[Official Documentation](https://surfer.nmr.mgh.harvard.edu/fswiki/mri_vol2surf)
