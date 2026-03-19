# SIENA Cross-Sectional (SIENAX)

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Multi-step pipeline for cross-sectional brain volume estimation. Internally chains BET brain extraction, atlas registration, FAST tissue segmentation, and head-size-normalized volume computation.

**Modality:** T1-weighted 3D NIfTI volume.

**Typical Use:** Single timepoint normalized brain volume measures.

## Key Parameters

-o (output directory), -r (regional analysis), -BET (BET options), -S (SIENAX options)

## Key Points

Single timepoint analysis. Normalizes volumes by head size for cross-subject comparisons. Reports total brain, GM, and WM volumes.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input T1-weighted image |  |
| `output_dir` | `string` | No | Output directory name | `-o` |
| `bet_options` | `string` | No | BET options (e.g., "-f 0.3") | `-B` |
| `two_class` | `boolean` | No | Two-class segmentation (no grey/white separation) | `-2` |
| `t2_weighted` | `boolean` | No | Input is T2-weighted | `-t2` |
| `regional` | `boolean` | No | Estimate regional volumes (peripheral GM, ventricular CSF) | `-r` |
| `lesion_mask` | `File` | No | Lesion mask to correct mislabeled GM voxels | `-lm` |
| `fast_options` | `string` | No | FAST segmentation options (e.g., "-i 20") | `-S` |
| `top_threshold` | `double` | No | Ignore from this height (mm) upwards in MNI space | `-t` |
| `bottom_threshold` | `double` | No | Ignore from this height (mm) downwards in MNI space | `-b` |
| `debug` | `boolean` | No | Debug mode (keep intermediate files) | `-d` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`
- **lesion_mask**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `output_directory` | `Directory` | `$(inputs.output_dir || inputs.input.nameroot + '_sienax')` |
| `report` | `File` | `$(inputs.output_dir || inputs.input.nameroot + '_sienax')/report.sienax` |
| `brain_volume` | `File` | `$(inputs.output_dir || inputs.input.nameroot + '_sienax')/*_brain.nii.gz`, `$(inputs.output_dir || inputs.input.nameroot + '_sienax')/*_brain.nii` |
| `segmentation` | `File` | `$(inputs.output_dir || inputs.input.nameroot + '_sienax')/*_seg.nii.gz`, `$(inputs.output_dir || inputs.input.nameroot + '_sienax')/*_seg.nii` |
| `log` | `File` | `sienax.log` |

### Output Extensions

- **report**: `.sienax`
- **brain_volume**: `.nii`, `.nii.gz`
- **segmentation**: `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Structural MRI > FSL > Pipelines
- Pipelines > FSL > Structural

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/SIENA)
