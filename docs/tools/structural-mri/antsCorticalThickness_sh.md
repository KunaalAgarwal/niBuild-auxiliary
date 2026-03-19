# ANTs Cortical Thickness Pipeline

**Library:** ANTs | **Docker Image:** `antsx/ants`

## Function

Complete automated pipeline for cortical thickness estimation using DiReCT, including brain extraction, segmentation, and registration.

**Modality:** T1-weighted 3D NIfTI volume plus brain template and tissue priors.

**Typical Use:** Complete DiReCT-based cortical thickness measurement pipeline.

## Key Parameters

-d (dimension), -a (anatomical image), -e (brain template), -m (brain probability mask), -p (tissue priors prefix), -o (output prefix)

## Key Points

Runs full pipeline: N4, brain extraction, segmentation, registration, thickness. Requires template and priors. Computationally intensive.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `dimensionality` | `int` | Yes | Image dimensionality (2 or 3) | `-d` |
| `anatomical_image` | `File` | Yes | Input anatomical T1 image | `-a` |
| `template` | `File` | Yes | Brain extraction template (with skull) | `-e` |
| `brain_probability_mask` | `File` | Yes | Brain probability mask for template | `-m` |
| `segmentation_priors` | `string` | Yes | Segmentation priors pattern (e.g., priors%d.nii.gz) | `-p` |
| `segmentation_priors_dir` | `Directory` | No | Directory containing segmentation priors (used with segmentation_priors pattern) |  |
| `output_prefix` | `string` | Yes | Output prefix | `-o` |
| `template_transform_prefix` | `string` | No | Transform prefix to template space | `-t` |
| `registration_mask` | `File` | No | Registration mask for template | `-f` |
| `extraction_registration_mask` | `File` | No | Mask for brain extraction registration | `-x` |
| `quick_registration` | `boolean` | No | Use quick registration (antsRegistrationSyNQuick.sh) | `-q` |
| `run_stage` | `enum` | No | Stage to run (0=all, 1=extraction, 2=registration, 3=segmentation) | `-y` |
| `keep_temporary` | `boolean` | No | Keep temporary files | `-k` |
| `image_suffix` | `string` | No | Output image file suffix (e.g., nii.gz) | `-s` |
| `additional_thickness_priors` | `string` | No | Additional classes for thickness (e.g., 4) | `-c` |
| `use_random_seeding` | `boolean` | No | Use random seeding | `-u` |
| `test_mode` | `boolean` | No | Test/debug mode for faster execution | `-z` |

### Accepted Input Extensions

- **anatomical_image**: `.nii`, `.nii.gz`
- **template**: `.nii`, `.nii.gz`
- **brain_probability_mask**: `.nii`, `.nii.gz`
- **registration_mask**: `.nii`, `.nii.gz`
- **extraction_registration_mask**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `brain_extraction_mask` | `File` | `$(inputs.output_prefix)BrainExtractionMask.nii.gz` |
| `brain_segmentation` | `File` | `$(inputs.output_prefix)BrainSegmentation.nii.gz` |
| `cortical_thickness` | `File` | `$(inputs.output_prefix)CorticalThickness.nii.gz` |
| `brain_normalized` | `File` | `$(inputs.output_prefix)BrainNormalizedToTemplate.nii.gz` |
| `subject_to_template_warp` | `File` | `$(inputs.output_prefix)SubjectToTemplate1Warp.nii.gz` |
| `subject_to_template_affine` | `File` | `$(inputs.output_prefix)SubjectToTemplate0GenericAffine.mat` |
| `template_to_subject_warp` | `File` | `$(inputs.output_prefix)TemplateToSubject0Warp.nii.gz` |
| `template_to_subject_affine` | `File` | `$(inputs.output_prefix)TemplateToSubject1GenericAffine.mat` |
| `segmentation_posteriors` | `File[]` | `$(inputs.output_prefix)BrainSegmentationPosteriors*.nii.gz` |
| `log` | `File` | `antsCorticalThickness.log` |

### Output Extensions

- **brain_extraction_mask**: `.nii.gz`
- **brain_segmentation**: `.nii.gz`
- **cortical_thickness**: `.nii.gz`
- **brain_normalized**: `.nii.gz`
- **subject_to_template_warp**: `.nii.gz`
- **subject_to_template_affine**: `.mat`
- **template_to_subject_warp**: `.nii.gz`
- **template_to_subject_affine**: `.mat`
- **segmentation_posteriors**: `.nii.gz`

## Enum Options

**`run_stage`**: `0`, `1`, `2`, `3`

## Docker Tags

Available versions: `latest`, `master`, `v2.6.5`, `2.6.5`, `v2.6.4`, `2.6.4`, `v2.6.3`, `2.6.3`, `v2.6.2`, `2.6.2`
 and 5 more

## Categories

- Structural MRI > ANTs > Cortical Thickness
- Pipelines > ANTs > Structural

## Documentation

[Official Documentation](https://github.com/ANTsX/ANTs/wiki/antsCorticalThickness-and-Templates)
