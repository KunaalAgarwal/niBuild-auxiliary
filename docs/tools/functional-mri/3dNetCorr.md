# AFNI 3D Network Correlation Matrix (3dNetCorr)

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Computes pairwise correlation matrices between ROI time series extracted from a parcellation atlas.

**Modality:** 4D fMRI NIfTI/AFNI time series plus integer-labeled parcellation volume.

**Typical Use:** Creating functional connectivity matrices from parcellations.

## Key Parameters

-inset (4D time series), -in_rois (parcellation), -prefix (output), -fish_z (Fisher z-transform), -ts_out (output time series)

## Key Points

Outputs correlation matrix as text file. Use -fish_z for Fisher z-transformed values.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `prefix` | `string` | Yes | Output file name prefix | `-prefix` |
| `inset` | `File` | Yes | Input 4D time series dataset | `-inset` |
| `in_rois` | `File` | Yes | ROI mask with distinct integer labels | `-in_rois` |
| `mask` | `File` | No | Brain mask for correlation calculation | `-mask` |
| `fish_z` | `boolean` | No | Fisher Z-transform correlation coefficients | `-fish_z` |
| `part_corr` | `boolean` | No | Calculate partial correlation matrices | `-part_corr` |
| `ts_out` | `boolean` | No | Output mean time series per ROI | `-ts_out` |
| `ts_label` | `boolean` | No | Insert ROI label at start of each time series line | `-ts_label` |
| `ts_indiv` | `boolean` | No | Create directories with individual ROI time series | `-ts_indiv` |
| `ts_wb_corr` | `boolean` | No | Generate whole brain correlation maps per ROI | `-ts_wb_corr` |
| `ts_wb_Z` | `boolean` | No | Generate whole brain Fisher Z-score maps per ROI | `-ts_wb_Z` |
| `weight_ts` | `File` | No | Apply weights to ROI time series | `-weight_ts` |
| `weight_corr` | `File` | No | Apply weights for weighted Pearson correlation | `-weight_corr` |
| `nifti` | `boolean` | No | Output maps as NIFTI instead of BRIK/HEAD | `-nifti` |
| `push_thru_many_zeros` | `boolean` | No | Continue even with >10% null time series in ROIs | `-push_thru_many_zeros` |
| `allow_roi_zeros` | `boolean` | No | Permit ROIs with all-zero time series | `-allow_roi_zeros` |
| `automask_off` | `boolean` | No | Disable automatic masking | `-automask_off` |

### Accepted Input Extensions

- **inset**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **in_rois**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **mask**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **weight_ts**: `.1D`, `.txt`
- **weight_corr**: `.1D`, `.txt`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `correlation_matrix` | `File` | `$(inputs.prefix)_000.netcc` |
| `time_series` | `File` | `$(inputs.prefix)_000.netts` |
| `wb_corr_maps` | `File[]` | `$(inputs.prefix)_*_000_WB*.nii*`, `$(inputs.prefix)_*_000_WB*+orig.*` |
| `log` | `File` | `$(inputs.prefix).log` |

### Output Extensions

- **correlation_matrix**: `.netcc`
- **time_series**: `.netts`
- **wb_corr_maps**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Functional MRI > AFNI > Connectivity

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dNetCorr.html)
