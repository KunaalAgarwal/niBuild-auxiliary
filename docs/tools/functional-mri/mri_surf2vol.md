# FreeSurfer Surface to Volume Projection

**Library:** FreeSurfer | **Docker Image:** `freesurfer/freesurfer`

## Function

Projects surface-based data back to volumetric space using registration and template volume.

**Modality:** FreeSurfer surface overlay file plus template volume and registration.

**Typical Use:** Converting surface-based results back to volume space for reporting.

## Key Parameters

--surfval (surface data), --reg (registration), --template (output grid template), --hemi (hemisphere), --o (output volume)

## Key Points

Inverse of mri_vol2surf. Template defines output grid dimensions.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `subjects_dir` | `Directory` | Yes | FreeSurfer SUBJECTS_DIR |  |
| `fs_license` | `File` | Yes | FreeSurfer license file |  |
| `source_file` | `File` | Yes | Surface values file | `--surfval` |
| `hemi` | `enum` | Yes | Hemisphere (lh or rh) | `--hemi` |
| `output` | `string` | Yes | Output volume filename | `--o` |
| `reg` | `File` | No | Registration file | `--reg` |
| `identity` | `string` | No | Subject for identity registration | `--identity` |
| `template` | `File` | No | Template volume for output geometry | `--template` |
| `subject` | `string` | No | Subject name | `--subject` |
| `surf` | `string` | No | Surface name (default white) | `--surf` |
| `mkmask` | `boolean` | No | Create mask volume | `--mkmask` |
| `projfrac` | `double` | No | Projection fraction along normal | `--projfrac` |
| `projdist` | `string` | No | Projection distances (min max delta) | `--projdist` |
| `fill_projfrac` | `string` | No | Fill between projection fractions (start stop delta) | `--fill-projfrac` |
| `fillribbon` | `boolean` | No | Fill entire cortical ribbon | `--fillribbon` |
| `ribbon` | `File` | No | Ribbon volume file | `--ribbon` |
| `merge` | `File` | No | Merge with existing volume | `--merge` |
| `add` | `boolean` | No | Add to merged volume | `--add` |
| `vtxvol` | `boolean` | No | Create vertex volume | `--vtxvol` |

### Accepted Input Extensions

- **source_file**: `.mgh`, `.mgz`, `.nii`, `.nii.gz`, `.w`, `.curv`, `.sulc`, `.thickness`, `.area`
- **reg**: `.dat`, `.lta`
- **template**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`
- **ribbon**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`
- **merge**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `out_file` | `File` | `$(inputs.output)*` |
| `log` | `File` | `mri_surf2vol.log` |

### Output Extensions

- **out_file**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `8.1.0`, `8.0.0`, `7.2.0`, `7.3.0`, `7.3.1`, `7.3.2`, `7.4.1`, `7.1.1`, `6.0`

## Categories

- Functional MRI > FreeSurfer > Functional Analysis

## Documentation

[Official Documentation](https://surfer.nmr.mgh.harvard.edu/fswiki/mri_surf2vol)
