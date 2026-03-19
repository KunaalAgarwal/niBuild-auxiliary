# Bayesian Inference for Arterial Spin Labeling (BASIL)

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Bayesian kinetic model inversion for ASL data using variational Bayes to estimate perfusion and arrival time.

**Modality:** 4D ASL NIfTI (differenced tag-control or raw tag/control pairs).

**Typical Use:** Bayesian perfusion quantification with uncertainty estimation.

## Key Parameters

-i (input ASL), -o (output dir), --tis (inversion times), --casl/--pasl, --bolus (bolus duration), --bat (arterial transit time prior)

## Key Points

Core kinetic modeling engine used by oxford_asl. Multi-TI data enables arrival time estimation. Spatial regularization improves estimates in low-SNR regions.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input ASL difference data | `-i` |
| `output_dir` | `string` | Yes | Output directory name | `-o` |
| `mask` | `File` | Yes | Brain mask | `-m` |
| `options_file` | `File` | No | FABBER parameter options file | `-@` |
| `model` | `string` | No | Model used for analysis (default buxton) | `--model` |
| `nlls` | `boolean` | No | Do least squares analysis as first step | `--nlls` |
| `infertau` | `boolean` | No | Infer on bolus length | `--infertau` |
| `infert1` | `boolean` | No | Include uncertainty in T1 values | `--infert1` |
| `inferart` | `boolean` | No | Infer on arterial compartment | `--inferart` |
| `spatial` | `boolean` | No | Adaptive spatial smoothing on CBF | `--spatial` |
| `fast` | `boolean` | No | Single step analysis (use with --spatial) | `--fast` |
| `pgm` | `File` | No | Gray matter PV map | `--pgm` |
| `pwm` | `File` | No | White matter PV map | `--pwm` |
| `t1im` | `File` | No | Voxelwise T1 (tissue) estimates | `--t1im` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`
- **mask**: `.nii`, `.nii.gz`
- **options_file**: `.txt`
- **pgm**: `.nii`, `.nii.gz`
- **pwm**: `.nii`, `.nii.gz`
- **t1im**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `perfusion` | `File` | `$(inputs.output_dir)/step*/mean_ftiss.nii.gz`, `$(inputs.output_dir)/mean_ftiss.nii.gz` |
| `log` | `File` | `basil.log` |
| `err_log` | `File` | `basil.err.log` |

### Output Extensions

- **perfusion**: `.nii.gz`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Arterial Spin Labeling > FSL > ASL Processing

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/BASIL)
