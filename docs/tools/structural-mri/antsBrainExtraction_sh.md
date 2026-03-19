# ANTs Template-Based Brain Extraction

**Library:** ANTs | **Docker Image:** `antsx/ants`

## Function

High-quality brain extraction using registration to a brain template and tissue priors for robust skull stripping.

**Modality:** T1-weighted 3D NIfTI volume plus brain template and brain probability mask.

**Typical Use:** High-quality skull stripping, especially for challenging datasets.

## Key Parameters

-d (dimension, 3), -a (anatomical image), -e (brain template), -m (brain probability mask), -o (output prefix)

## Key Points

More robust than BET for difficult cases. Requires template and prior. Slower but generally more accurate.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `dimensionality` | `int` | Yes | Image dimensionality (2 or 3) | `-d` |
| `anatomical_image` | `File` | Yes | Input anatomical T1 image | `-a` |
| `template` | `File` | Yes | Brain extraction template (head with skull) | `-e` |
| `brain_probability_mask` | `File` | Yes | Brain probability mask for template | `-m` |
| `output_prefix` | `string` | Yes | Output prefix | `-o` |
| `registration_mask` | `File` | No | Registration mask for template | `-f` |
| `keep_temporary_files` | `boolean` | No | Keep temporary files | `-k` |
| `image_suffix` | `string` | No | Output image file suffix (e.g., nii.gz) | `-s` |
| `rotation_search` | `string` | No | Rotation search parameters (step,arcFraction) | `-R` |
| `translation_search` | `string` | No | Translation search parameters (step,range) | `-T` |
| `use_floatingpoint` | `boolean` | No | Use single floating point precision | `-q` |
| `use_random_seeding` | `boolean` | No | Use random seeding | `-u` |

### Accepted Input Extensions

- **anatomical_image**: `.nii`, `.nii.gz`
- **template**: `.nii`, `.nii.gz`
- **brain_probability_mask**: `.nii`, `.nii.gz`
- **registration_mask**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `brain_extracted` | `File` | `$(inputs.output_prefix)BrainExtractionBrain.nii.gz` |
| `brain_mask` | `File` | `$(inputs.output_prefix)BrainExtractionMask.nii.gz` |
| `brain_n4` | `File` | `$(inputs.output_prefix)BrainExtractionBrain_N4.nii.gz` |
| `registration_template` | `File` | `$(inputs.output_prefix)BrainExtractionPrior*Warped.nii.gz` |
| `log` | `File` | `antsBrainExtraction.log` |

### Output Extensions

- **brain_extracted**: `.nii.gz`
- **brain_mask**: `.nii.gz`
- **brain_n4**: `.nii.gz`
- **registration_template**: `.nii.gz`

## Docker Tags

Available versions: `latest`, `master`, `v2.6.5`, `2.6.5`, `v2.6.4`, `2.6.4`, `v2.6.3`, `2.6.3`, `v2.6.2`, `2.6.2`
 and 5 more

## Categories

- Structural MRI > ANTs > Brain Extraction

## Documentation

[Official Documentation](https://github.com/ANTsX/ANTs/wiki/antsBrainExtraction-and-templates)
