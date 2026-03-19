# ANTs Joint Label Fusion

**Library:** ANTs | **Docker Image:** `antsx/ants`

## Function

Multi-atlas segmentation that combines labels from multiple pre-labeled atlases using joint label fusion with local weighting.

**Modality:** Target 3D NIfTI volume plus multiple atlas images with corresponding label maps.

**Typical Use:** High-accuracy segmentation using multiple atlas priors.

## Key Parameters

-d (dimension), -t (target image), -g (atlas images), -l (atlas labels), -o (output prefix)

## Key Points

More accurate than single-atlas segmentation. Requires multiple registered atlases. Computationally intensive but highly accurate.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `dimensionality` | `int` | Yes | Image dimensionality (2 or 3) | `-d` |
| `output_prefix` | `string` | Yes | Output prefix for labeled images | `-o` |
| `target_image` | `File` | Yes | Target image to be labeled |  |
| `atlas_images` | `File[]` | Yes | Atlas grayscale images |  |
| `atlas_labels` | `File[]` | Yes | Atlas label images corresponding to each atlas |  |
| `mask_image` | `File` | No | Mask image for limiting fusion region | `-x` |
| `num_threads` | `int` | No | Number of parallel threads | `-j` |
| `parallel_control` | `int` | No | Parallel computation control (0=serial, 1=SGE, 2=PEXEC, 3=SLURM, 4=PBS) | `-c` |
| `search_radius` | `string` | No | Search radius for similarity measures (e.g., 3x3x3) | `-s` |
| `patch_radius` | `string` | No | Patch radius for similarity measures (e.g., 2x2x2) | `-p` |
| `alpha` | `double` | No | Regularization term for matrix inversion (default 0.1) | `-a` |
| `beta` | `double` | No | Exponent for mapping intensity difference (default 2.0) | `-b` |

### Accepted Input Extensions

- **target_image**: `.nii`, `.nii.gz`
- **atlas_images**: `.nii`, `.nii.gz`
- **atlas_labels**: `.nii`, `.nii.gz`
- **mask_image**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `labeled_image` | `File` | `$(inputs.output_prefix)Labels.nii.gz` |
| `intensity_fusion` | `File` | `$(inputs.output_prefix)Intensity.nii.gz` |
| `log` | `File` | `antsJointLabelFusion.log` |

### Output Extensions

- **labeled_image**: `.nii.gz`
- **intensity_fusion**: `.nii.gz`

## Docker Tags

Available versions: `latest`, `master`, `v2.6.5`, `2.6.5`, `v2.6.4`, `2.6.4`, `v2.6.3`, `2.6.3`, `v2.6.2`, `2.6.2`
 and 5 more

## Categories

- Utilities > ANTs > Label Analysis

## Documentation

[Official Documentation](https://github.com/ANTsX/ANTs/wiki/antsJointLabelFusion)
