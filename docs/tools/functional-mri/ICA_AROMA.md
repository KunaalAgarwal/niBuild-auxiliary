# ICA-based Automatic Removal of Motion Artifacts (ICA-AROMA)

**Library:** ICA-AROMA | **Docker Image:** `rtrhd/ica-aroma`

## Function

Multi-step denoising pipeline for fMRI motion artifact removal. Internally chains MELODIC ICA decomposition, motion artifact feature extraction, classifier-based component labeling, and non-aggressive denoising.

**Modality:** Preprocessed 4D fMRI NIfTI in standard (MNI) space with motion parameters.

**Typical Use:** Removing motion artifacts from resting-state or task fMRI data after standard preprocessing.

## Key Parameters

-i (input 4D), -mc (motion parameters), -o (output directory), -a (affine matrix), -w (warp field), -den (denoising type)

## Key Points

Requires data in MNI space. Classifier uses four features: max RP correlation, edge fraction, HFC spatial fraction, and CSF fraction. Non-aggressive denoising recommended.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input 4D fMRI data (preprocessed, in standard space) | `-i` |
| `output_dir` | `string` | Yes | Output directory | `-o` |
| `mc` | `File` | Yes | Motion parameters file (6 columns) | `-mc` |
| `affmat` | `File` | No | Affine registration matrix (func to MNI) | `-a` |
| `warp` | `File` | No | Non-linear warp field (func to MNI) | `-w` |
| `mask` | `File` | No | Brain mask in functional space | `-m` |
| `denoise_type` | `enum` | No | Denoising strategy (nonaggr=non-aggressive, aggr=aggressive, both) | `-den` |
| `melodic_dir` | `Directory` | No | Pre-computed MELODIC directory (skip ICA step) | `-md` |
| `dim` | `int` | No | Dimensionality for MELODIC (default auto) | `-dim` |
| `TR` | `double` | No | TR in seconds (extracted from data if not provided) | `-tr` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`
- **mc**: `.txt`, `.par`, `.1D`
- **affmat**: `.mat`
- **warp**: `.nii`, `.nii.gz`
- **mask**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `output_directory` | `Directory` | `$(inputs.output_dir)` |
| `denoised_func` | `File` | `$(inputs.output_dir)/denoised_func_data_nonaggr.nii.gz`, `$(inputs.output_dir)/denoised_func_data_aggr.nii.gz`, `$(inputs.output_dir)/denoised_func_data_nonaggr.nii` |
| `classified_motion` | `File` | `$(inputs.output_dir)/classified_motion_ICs.txt` |
| `melodic_mixing` | `File` | `$(inputs.output_dir)/melodic.ica/melodic_mix` |
| `log` | `File` | `ICA_AROMA.log` |

### Output Extensions

- **denoised_func**: `.nii`, `.nii.gz`
- **classified_motion**: `.txt`

## Docker Tags

Available versions: `latest`

## Categories

- Functional MRI > ICA-AROMA > Denoising
- Pipelines > ICA-AROMA > Denoising

## Documentation

[Official Documentation](https://github.com/maartenmennes/ICA-AROMA)
