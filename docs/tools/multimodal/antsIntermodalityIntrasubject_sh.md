# ANTs Intermodality Intrasubject Registration

**Library:** ANTs | **Docker Image:** `antsx/ants`

## Function

Specialized registration between different imaging modalities within the same subject.

**Modality:** Two different-modality volumes from the same subject (e.g., T1 + T2, or T1 + EPI).

**Typical Use:** T1-to-T2, fMRI-to-T1, or DWI-to-T1 within-subject alignment.

## Key Parameters

-d (dimension), -i (input modality 1), -r (reference modality 2), -o (output prefix), -t (transform type)

## Key Points

Uses mutual information cost function appropriate for cross-modal registration.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `dimensionality` | `int` | Yes | Image dimensionality (2 or 3) | `-d` |
| `input_image` | `File` | Yes | Input scalar image to match (e.g., b0 or pCASL) | `-i` |
| `reference_image` | `File` | Yes | Reference T1 subject brain image | `-r` |
| `output_prefix` | `string` | Yes | Output prefix | `-o` |
| `brain_mask` | `File` | Yes | Anatomical T1 brain mask | `-x` |
| `transform_type` | `enum` | No | Transform type (0=rigid, 1=affine, 2=rigid+small_def, 3=affine+small_def) | `-t` |
| `template_prefix` | `string` | No | Output prefix from prior antsRegistration T1-to-template | `-w` |
| `auxiliary_images` | `File[]` | No | Auxiliary scalar images to warp | `-a` |
| `auxiliary_dti` | `File` | No | Auxiliary DTI image to warp | `-b` |
| `label_image` | `File` | No | Label image in template space (e.g., AAL atlas) | `-l` |

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `warped_image` | `File` | `$(inputs.output_prefix)anatomical.nii.gz` |
| `affine_transform` | `File` | `$(inputs.output_prefix)0GenericAffine.mat` |
| `warp_field` | `File` | `$(inputs.output_prefix)1Warp.nii.gz` |
| `inverse_warp_field` | `File` | `$(inputs.output_prefix)1InverseWarp.nii.gz` |
| `log` | `File` | `antsIntermodalityIntrasubject.log` |

### Output Extensions

- **warped_image**: `.nii.gz`
- **affine_transform**: `.mat`
- **warp_field**: `.nii.gz`
- **inverse_warp_field**: `.nii.gz`

## Enum Options

**`transform_type`**: `0`, `1`, `2`, `3`

## Docker Tags

Available versions: `latest`, `master`, `v2.6.5`, `2.6.5`, `v2.6.4`, `2.6.4`, `v2.6.3`, `2.6.3`, `v2.6.2`, `2.6.2`
 and 5 more

## Categories

- Multimodal > ANTs > Intermodal Registration

## Documentation

[Official Documentation](https://github.com/ANTsX/ANTs/wiki/Anatomy-of-an-antsRegistration-call)
