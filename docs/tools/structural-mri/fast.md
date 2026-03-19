# FMRIB's Automated Segmentation Tool (FAST)

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Segments brain images into gray matter, white matter, and CSF using a hidden Markov random field model with integrated bias field correction.

**Modality:** Brain-extracted T1-weighted 3D NIfTI volume.

**Typical Use:** Tissue probability maps for normalization, VBM studies, or masking.

## Key Parameters

-n (number of tissue classes, default 3), -t (image type: 1=T1, 2=T2, 3=PD), -B (output bias field), -o (output basename)

## Key Points

Input must be brain-extracted. Outputs partial volume maps (*_pve_0/1/2) for each tissue class. Use -B to get estimated bias field.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes |  |  |
| `output` | `string` | Yes | Output filename prefix | `-o` |
| `nclass` | `int` | No | Number of tissue classes | `-n` |
| `iterations` | `int` | No | Number of iterations during bias-field removal | `-I` |
| `lowpass` | `double` | No | bias field smoothing extent (FWHM) in mm | `-l` |
| `image_type` | `int` | No | Image type (e.g. 1="T1", 2="T2", 3="PD") | `-t` |
| `fhard` | `double` | No | initial segmentation spatial smoothness (during bias field estimation) | `-f` |
| `segments` | `boolean` | No | Outputs a separate binary segmentation file for each tissue type | `-g` |
| `bias_field` | `boolean` | No | Outputs estimated bias field | `-b` |
| `bias_corrected_image` | `boolean` | No | Outputs bias-corrected image | `-B` |
| `nobias` | `boolean` | No | Do not remove bias field | `-N` |
| `channels` | `int` | No | Number of channels to use | `-S` |
| `initialization_iterations` | `int` | No | initial number of segmentation-initialisation iterations | `-W` |
| `mixel` | `double` | No | spatial smoothness for mixeltype | `-R` |
| `fixed` | `int` | No | number of main-loop iterations after bias-field removal | `-O` |
| `hyper` | `double` | No | segmentation spatial smoothness | `-H` |
| `manualseg` | `File` | No | Manual segmentation file | `-s` |
| `probability_maps` | `boolean` | No | outputs individual probability maps | `-p` |
| `priors` | `record(priors)` | No |  |  |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`
- **manualseg**: `.nii`, `.nii.gz`
- **initialize_priors**: `.mat`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `segmented_files` | `File[]` | `$(inputs.output)_seg.nii.gz`, `$(inputs.output)_pve_*.nii.gz`, `$(inputs.output)_mixeltype.nii.gz`, `$(inputs.output)_pveseg.nii.gz` |
| `output_bias_field` | `File` | `$(inputs.output)_bias.nii.gz` |
| `output_bias_corrected_image` | `File` | `$(inputs.output)_restore.nii.gz` |
| `output_probability_maps` | `File[]` | `$(inputs.output)_prob_*.nii.gz` |
| `output_segments` | `File[]` | `$(inputs.output)_seg_*.nii.gz` |
| `log` | `File` | `$(inputs.output).log` |

### Output Extensions

- **segmented_files**: `.nii.gz`
- **output_bias_field**: `.nii.gz`
- **output_bias_corrected_image**: `.nii.gz`
- **output_probability_maps**: `.nii.gz`
- **output_segments**: `.nii.gz`

## Enum Options

**`image_type`**: `1`, `2`, `3`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Structural MRI > FSL > Tissue Segmentation

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FAST)
