# FSL Randomise Permutation Testing

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Non-parametric permutation testing for statistical inference with multiple correction methods including TFCE.

**Modality:** 4D NIfTI of stacked subject images plus design matrix and contrast files.

**Typical Use:** Group-level inference with family-wise error correction (VBM, TBSS, etc.).

## Key Parameters

-i (input 4D), -o (output basename), -d (design matrix), -t (contrast file), -n (num permutations), -T (TFCE)

## Key Points

Use -T for TFCE (recommended). 5000+ permutations for publication. Computationally intensive but provides strong family-wise error control.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | 4D input image | `-i` |
| `output` | `string` | Yes | Output file root name | `-o` |
| `design_mat` | `File` | No | Design matrix file (.mat) | `-d` |
| `tcon` | `File` | No | T-contrast file (.con) | `-t` |
| `fcon` | `File` | No | F-contrast file (.fts) | `-f` |
| `mask` | `File` | No | Mask image | `-m` |
| `num_perm` | `int` | No | Number of permutations (default 5000) | `-n` |
| `seed` | `int` | No | Random seed | `--seed=` |
| `one_sample_group_mean` | `boolean` | No | Perform one-sample group mean test | `-1` |
| `tfce` | `boolean` | No | Use Threshold-Free Cluster Enhancement | `-T` |
| `tfce2D` | `boolean` | No | Use 2D TFCE optimization (for TBSS) | `--T2` |
| `tfce_H` | `double` | No | TFCE height parameter (default 2) | `--tfce_H=` |
| `tfce_E` | `double` | No | TFCE extent parameter (default 0.5) | `--tfce_E=` |
| `tfce_C` | `double` | No | TFCE connectivity parameter (default 6) | `--tfce_C=` |
| `c_thresh` | `double` | No | Cluster-forming threshold for t-statistics | `-c` |
| `cm_thresh` | `double` | No | Cluster-mass threshold for t-statistics | `-C` |
| `f_c_thresh` | `double` | No | Cluster-forming threshold for F-statistics | `-F` |
| `f_cm_thresh` | `double` | No | Cluster-mass threshold for F-statistics | `-S` |
| `demean` | `boolean` | No | Demean data temporally before analysis | `-D` |
| `vox_p_values` | `boolean` | No | Output voxelwise (uncorrected) p-values | `-x` |
| `f_only` | `boolean` | No | Calculate F-statistics only | `--fonly` |
| `raw_stats_imgs` | `boolean` | No | Output raw (unpermuted) statistic images | `-R` |
| `p_vec_n_dist_files` | `boolean` | No | Output permutation vector and null distribution | `-P` |
| `var_smooth` | `int` | No | Variance smoothing in mm | `-v` |
| `x_block_labels` | `File` | No | Exchangeability block labels file | `-e` |
| `show_total_perms` | `boolean` | No | Print total number of permutations and exit | `-q` |
| `show_info_parallel_mode` | `boolean` | No | Print parallel mode info | `-Q` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`
- **design_mat**: `.mat`
- **tcon**: `.con`
- **fcon**: `.fts`
- **mask**: `.nii`, `.nii.gz`
- **x_block_labels**: `.txt`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `t_corrp` | `File[]` | `$(inputs.output)_tfce_corrp_tstat*.nii.gz`, `$(inputs.output)_vox_corrp_tstat*.nii.gz`, `$(inputs.output)_clustere_corrp_tstat*.nii.gz`, `$(inputs.output)_clusterm_corrp_tstat*.nii.gz` |
| `t_p` | `File[]` | `$(inputs.output)_tfce_p_tstat*.nii.gz`, `$(inputs.output)_vox_p_tstat*.nii.gz` |
| `tstat` | `File[]` | `$(inputs.output)_tstat*.nii.gz`, `$(inputs.output)_tstat*.nii` |
| `f_corrp` | `File[]` | `$(inputs.output)_tfce_corrp_fstat*.nii.gz`, `$(inputs.output)_vox_corrp_fstat*.nii.gz` |
| `f_p` | `File[]` | `$(inputs.output)_tfce_p_fstat*.nii.gz`, `$(inputs.output)_vox_p_fstat*.nii.gz` |
| `fstat` | `File[]` | `$(inputs.output)_fstat*.nii.gz`, `$(inputs.output)_fstat*.nii` |
| `log` | `File` | `randomise.log` |

### Output Extensions

- **t_corrp**: `.nii.gz`
- **t_p**: `.nii.gz`
- **tstat**: `.nii`, `.nii.gz`
- **f_corrp**: `.nii.gz`
- **f_p**: `.nii.gz`
- **fstat**: `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Functional MRI > FSL > Statistical Analysis

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/Randomise)
