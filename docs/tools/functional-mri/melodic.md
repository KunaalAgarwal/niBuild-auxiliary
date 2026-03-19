# Multivariate Exploratory Linear Optimized Decomposition into Independent Components (MELODIC)

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Multi-step ICA pipeline that decomposes fMRI data into spatially independent components. Internally chains brain masking, variance normalization, and probabilistic ICA decomposition.

**Modality:** 4D fMRI NIfTI time series (single-subject or concatenated multi-subject).

**Typical Use:** Data exploration, artifact identification, resting-state network analysis.

## Key Parameters

-i (input 4D), -o (output directory), -d (dimensionality), --report (generate HTML report), --bgimage (background for report)

## Key Points

Auto-dimensionality estimation by default (Laplace approximation). Can be run single-subject or group. Components classified as signal vs. noise manually or via FIX.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input_files` | `File | File[]` | Yes | Input file(s) - single 4D file or list of files | `-i` |
| `output_dir` | `string` | Yes | Output directory name | `-o` |
| `dim` | `int` | No | Number of dimensions to reduce to (default automatic) | `-d` |
| `dim_est` | `enum` | No | Dimension estimation technique | `--dimest=` |
| `approach` | `enum` | No | ICA approach (2D: defl/symm, 3D: tica, group: concat) | `-a` |
| `tr_sec` | `double` | No | TR in seconds | `--tr=` |
| `no_bet` | `boolean` | No | Switch off brain extraction (BET) | `--nobet` |
| `no_mask` | `boolean` | No | Switch off masking | `--nomask` |
| `mask` | `File` | No | Mask file | `-m` |
| `bg_threshold` | `double` | No | Brain/non-brain threshold percentage | `--bgthreshold=` |
| `var_norm` | `boolean` | No | Switch off variance normalization | `--vn` |
| `sep_vn` | `boolean` | No | Switch off joined variance normalization | `--sep_vn` |
| `pbsc` | `boolean` | No | Switch off percent BOLD signal change conversion | `--pbsc` |
| `num_ICs` | `int` | No | Number of ICs to extract (deflation approach) | `-n` |
| `non_linearity` | `enum` | No | Non-linearity function | `--nl=` |
| `maxit` | `int` | No | Maximum iterations before restart | `--maxit=` |
| `max_restart` | `int` | No | Maximum number of restarts | `--maxrestart=` |
| `epsilon` | `double` | No | Minimum error change | `--eps=` |
| `migp` | `boolean` | No | Switch on MIGP data reduction | `--migp` |
| `migpN` | `int` | No | Number of internal eigenmaps | `--migpN=` |
| `migp_factor` | `int` | No | MIGP memory threshold factor | `--migp_factor=` |
| `migp_shuffle` | `boolean` | No | Randomize MIGP file order | `--migp_shuffle` |
| `no_mm` | `boolean` | No | Switch off mixture modelling | `--no_mm` |
| `mm_thresh` | `double` | No | Mixture model threshold (0-1) | `--mmthresh=` |
| `ICs` | `File` | No | IC components file for mixture modelling | `--ICs=` |
| `mix` | `File` | No | Mixing matrix for mixture modelling | `--mix=` |
| `t_des` | `File` | No | Design matrix across time-domain | `--Tdes=` |
| `t_con` | `File` | No | T-contrast matrix across time-domain | `--Tcon=` |
| `s_des` | `File` | No | Design matrix across subject-domain | `--Sdes=` |
| `s_con` | `File` | No | T-contrast matrix across subject-domain | `--Scon=` |
| `out_all` | `boolean` | No | Output all results | `--Oall` |
| `out_mean` | `boolean` | No | Output mean volume | `--Omean` |
| `out_orig` | `boolean` | No | Output original ICs | `--Oorig` |
| `out_pca` | `boolean` | No | Output PCA results | `--Opca` |
| `out_stats` | `boolean` | No | Output thresholded maps and probability maps | `--Ostats` |
| `out_unmix` | `boolean` | No | Output unmixing matrix | `--Ounmix` |
| `out_white` | `boolean` | No | Output whitening/dewhitening matrices | `--Owhite` |
| `report` | `boolean` | No | Generate web report | `--report` |
| `report_maps` | `string` | No | Control string for spatial map images | `--report_maps=` |
| `bg_image` | `File` | No | Background image for report | `--bgimage=` |
| `log_power` | `boolean` | No | Calculate log of power for frequency spectrum | `--logPower` |
| `sep_whiten` | `boolean` | No | Switch on separate whitening | `--sep_whiten` |
| `update_mask` | `boolean` | No | Switch off mask updating | `--update_mask` |
| `verbose` | `boolean` | No | Verbose output | `-v` |

### Accepted Input Extensions

- **input_files**: `.nii`, `.nii.gz`
- **mask**: `.nii`, `.nii.gz`
- **ICs**: `.nii`, `.nii.gz`
- **mix**: `.txt`
- **t_des**: `.mat`
- **t_con**: `.con`
- **s_des**: `.mat`
- **s_con**: `.con`
- **bg_image**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `output_directory` | `Directory` | `$(inputs.output_dir)` |
| `melodic_IC` | `File` | `$(inputs.output_dir)/melodic_IC.nii.gz`, `$(inputs.output_dir)/melodic_IC.nii` |
| `melodic_mix` | `File` | `$(inputs.output_dir)/melodic_mix` |
| `melodic_FTmix` | `File` | `$(inputs.output_dir)/melodic_FTmix` |
| `melodic_Tmodes` | `File` | `$(inputs.output_dir)/melodic_Tmodes` |
| `mean` | `File` | `$(inputs.output_dir)/mean.nii.gz`, `$(inputs.output_dir)/mean.nii` |
| `log` | `File` | `melodic.log` |

### Output Extensions

- **melodic_IC**: `.nii`, `.nii.gz`
- **melodic_mix**: `.txt`
- **melodic_FTmix**: `.txt`
- **melodic_Tmodes**: `.txt`
- **mean**: `.nii`, `.nii.gz`

## Enum Options

**`approach`**: `defl`, `symm`, `tica`, `concat`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Functional MRI > FSL > ICA/Denoising
- Pipelines > FSL > Functional

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/MELODIC)
