# FreeSurfer Surface Data Preprocessing for Group Analysis

**Library:** FreeSurfer | **Docker Image:** `freesurfer/freesurfer`

## Function

Concatenates surface data across subjects onto a common template surface for group-level analysis.

**Modality:** Per-subject surface overlays (thickness, area, etc.) from FreeSurfer processing.

**Typical Use:** Preparing surface data for group statistical analysis.

## Key Parameters

--s (subject list), --meas (measure: thickness, area, volume), --target (target subject/template), --hemi (hemisphere), --o (output)

## Key Points

Resamples all subjects to common surface (fsaverage). Can smooth on surface with --fwhm.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `subjects_dir` | `Directory` | Yes | FreeSurfer SUBJECTS_DIR |  |
| `fs_license` | `File` | Yes | FreeSurfer license file |  |
| `output` | `string` | Yes | Output concatenated surface file | `--out` |
| `target` | `string` | Yes | Target subject (e.g., fsaverage) | `--target` |
| `hemi` | `enum` | Yes | Hemisphere (lh or rh) | `--hemi` |
| `subjects` | `string[]` | No | List of subject names |  |
| `fsgd` | `File` | No | FreeSurfer Group Descriptor file | `--fsgd` |
| `f` | `File` | No | Text file with list of subjects | `--f` |
| `meas` | `string` | No | Surface measure name (e.g., thickness, area) | `--meas` |
| `area` | `string` | No | Extract vertex area from surface | `--area` |
| `iv` | `string[]` | No | Volume and registration pairs | `--iv` |
| `projfrac` | `double` | No | Projection fraction for vol2surf (default 0.5) | `--projfrac` |
| `fwhm` | `double` | No | Smooth on target surface by FWHM in mm | `--fwhm` |
| `fwhm_src` | `double` | No | Smooth on source surface by FWHM in mm | `--fwhm-src` |
| `niters` | `int` | No | Smooth by N nearest neighbor iterations | `--niters` |
| `niters_src` | `int` | No | Smooth source by N iterations | `--niters-src` |
| `cache_in` | `string` | No | Use qcache data (e.g., thickness.fwhm10.fsaverage) | `--cache-in` |
| `paired_diff` | `boolean` | No | Compute paired differences | `--paired-diff` |
| `paired_diff_norm1` | `boolean` | No | Paired diff normalized by average | `--paired-diff-norm1` |
| `paired_diff_norm2` | `boolean` | No | Paired diff normalized by first timepoint | `--paired-diff-norm2` |
| `mask` | `File` | No | Mask label file | `--mask` |
| `cortex` | `boolean` | No | Use cortex label as mask | `--cortex` |

### Accepted Input Extensions

- **fsgd**: `.fsgd`
- **f**: `.txt`
- **mask**: `.label`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `out_file` | `File` | `$(inputs.output)*` |
| `log` | `File` | `mris_preproc.log` |

### Output Extensions

- **out_file**: `.mgh`, `.mgz`, `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `8.1.0`, `8.0.0`, `7.2.0`, `7.3.0`, `7.3.1`, `7.3.2`, `7.4.1`, `7.1.1`, `6.0`

## Categories

- Functional MRI > FreeSurfer > Functional Analysis

## Documentation

[Official Documentation](https://surfer.nmr.mgh.harvard.edu/fswiki/mris_preproc)
