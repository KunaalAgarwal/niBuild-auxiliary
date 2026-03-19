# Structural Image Evaluation using Normalisation of Atrophy (SIENA)

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Multi-step pipeline that estimates percentage brain volume change between two timepoints. Internally chains BET brain extraction, registration, FAST segmentation, and edge-point displacement analysis.

**Modality:** Two T1-weighted 3D NIfTI volumes from different timepoints.

**Typical Use:** Measuring brain volume change over time (e.g., atrophy in neurodegeneration).

## Key Parameters

-o (output directory), -BET (BET options), -2 (2-class segmentation), -S (SIENA step options)

## Key Points

Requires two scans of same subject at different timepoints. Reports percentage brain volume change (PBVC). Accurate to ~0.2% volume change.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input1` | `File` | Yes | Input T1 image (timepoint 1) |  |
| `input2` | `File` | Yes | Input T1 image (timepoint 2) |  |
| `output_dir` | `string` | No | Output directory name | `-o` |
| `bet_options` | `string` | No | BET options (e.g., "-f 0.3") | `-B` |
| `two_class` | `boolean` | No | Two-class segmentation (no grey/white separation) | `-2` |
| `t2_weighted` | `boolean` | No | Inputs are T2-weighted | `-t2` |
| `std_masking` | `boolean` | No | Apply standard-space masking for difficult cases | `-m` |
| `siena_diff_options` | `string` | No | Options to pass to siena_diff (e.g., "-s -i 20") | `-S` |
| `ventricle_analysis` | `boolean` | No | Activate ventricular analysis (VIENA) | `-V` |
| `ventricle_mask` | `File` | No | Custom ventricle mask | `-v` |
| `top_threshold` | `double` | No | Ignore from this height (mm) upwards in MNI space | `-t` |
| `bottom_threshold` | `double` | No | Ignore from this height (mm) downwards in MNI space | `-b` |
| `debug` | `boolean` | No | Debug mode (keep intermediate files) | `-d` |

### Accepted Input Extensions

- **input1**: `.nii`, `.nii.gz`
- **input2**: `.nii`, `.nii.gz`
- **ventricle_mask**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `output_directory` | `Directory` | `$(inputs.output_dir || '*_to_*_siena')` |
| `report` | `File` | `$(inputs.output_dir || '*_to_*_siena')/report.siena` |
| `pbvc` | `File` | `$(inputs.output_dir || '*_to_*_siena')/report.sienax` |
| `edge_points` | `File[]` | `$(inputs.output_dir || '*_to_*_siena')/*_edge*.nii.gz`, `$(inputs.output_dir || '*_to_*_siena')/*_edge*.nii` |
| `flow_images` | `File[]` | `$(inputs.output_dir || '*_to_*_siena')/*_flow*.nii.gz`, `$(inputs.output_dir || '*_to_*_siena')/*_flow*.nii` |
| `log` | `File` | `siena.log` |

### Output Extensions

- **report**: `.siena`
- **pbvc**: `.sienax`
- **edge_points**: `.nii`, `.nii.gz`
- **flow_images**: `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Structural MRI > FSL > Pipelines
- Pipelines > FSL > Structural

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/SIENA)
