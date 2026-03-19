# FSL Dual Regression

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Multi-step pipeline that projects group-level ICA spatial maps back to individual subjects. Internally chains spatial regression (stage 1), temporal regression (stage 2), and optionally randomise permutation testing (stage 3).

**Modality:** 4D fMRI NIfTI time series for each subject plus group ICA spatial maps.

**Typical Use:** Subject-level ICA-based resting-state network analysis and group comparisons.

## Key Parameters

<group_ICA_maps> <design_matrix> <design_contrasts> <num_permutations> <subject_list>

## Key Points

Two-stage regression: (1) spatial regression gives subject time courses, (2) temporal regression gives subject spatial maps. Can include randomise for group comparison.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `group_IC_maps` | `File` | Yes | Group ICA spatial maps (melodic_IC.nii.gz) |  |
| `des_norm` | `int` | Yes | Variance normalize timeseries (0=no, 1=yes) |  |
| `design_mat` | `File` | Yes | Design matrix file (.mat) |  |
| `design_con` | `File` | Yes | Contrast file (.con) |  |
| `n_perm` | `int` | Yes | Number of permutations for randomise |  |
| `output_dir` | `string` | Yes | Output directory name |  |
| `input_files` | `File[]` | Yes | List of input 4D files (one per subject) |  |

### Accepted Input Extensions

- **group_IC_maps**: `.nii`, `.nii.gz`
- **design_mat**: `.mat`
- **design_con**: `.con`
- **input_files**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `output_directory` | `Directory` | `$(inputs.output_dir)` |
| `stage1_timeseries` | `File[]` | `$(inputs.output_dir)/dr_stage1_subject*.txt` |
| `stage2_spatial_maps` | `File[]` | `$(inputs.output_dir)/dr_stage2_subject*.nii.gz`, `$(inputs.output_dir)/dr_stage2_subject*.nii` |
| `stage3_tstats` | `File[]` | `$(inputs.output_dir)/dr_stage3_ic*_tstat*.nii.gz`, `$(inputs.output_dir)/dr_stage3_ic*_tstat*.nii` |
| `stage3_corrp` | `File[]` | `$(inputs.output_dir)/dr_stage3_ic*_tfce_corrp_tstat*.nii.gz`, `$(inputs.output_dir)/dr_stage3_ic*_tfce_corrp_tstat*.nii` |
| `log` | `File` | `dual_regression.log` |

### Output Extensions

- **stage1_timeseries**: `.txt`
- **stage2_spatial_maps**: `.nii`, `.nii.gz`
- **stage3_tstats**: `.nii`, `.nii.gz`
- **stage3_corrp**: `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Functional MRI > FSL > ICA/Denoising
- Pipelines > FSL > Functional

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/DualRegression)
