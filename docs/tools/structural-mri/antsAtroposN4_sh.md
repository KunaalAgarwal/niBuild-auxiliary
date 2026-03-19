# ANTs Combined Atropos with N4 Bias Correction

**Library:** ANTs | **Docker Image:** `antsx/ants`

## Function

Iteratively combines N4 bias field correction with Atropos segmentation for improved results on biased images.

**Modality:** Brain-extracted 3D NIfTI volume plus brain mask.

**Typical Use:** Iterative N4 + segmentation for better results on images with bias field.

## Key Parameters

-d (dimension), -a (anatomical image), -x (mask), -c (number of classes), -o (output prefix), -n (number of iterations)

## Key Points

Iterative approach: N4 correction improves segmentation, which improves next N4 iteration. Superior to running separately.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `dimensionality` | `int` | Yes | Image dimensionality (2 or 3) | `-d` |
| `input_image` | `File` | Yes | Input anatomical image (typically T1) | `-a` |
| `mask_image` | `File` | Yes | Binary mask defining region of interest | `-x` |
| `output_prefix` | `string` | Yes | Output prefix | `-o` |
| `num_classes` | `int` | Yes | Number of tissue classes | `-c` |
| `n4_atropos_iterations` | `int` | No | Number of N4-Atropos iterations | `-m` |
| `atropos_iterations` | `int` | No | Number of Atropos iterations per N4 iteration | `-n` |
| `prior_images` | `string` | No | Prior probability images pattern (e.g., prior%d.nii.gz) | `-p` |
| `prior_weight` | `double` | No | Atropos prior probability weight | `-w` |
| `n4_shrink_factor` | `int` | No | N4 shrink factor | `-f` |
| `n4_convergence` | `string` | No | N4 convergence parameters | `-e` |
| `n4_bspline` | `string` | No | N4 B-spline parameters | `-q` |
| `atropos_icm` | `string` | No | Atropos ICM parameters | `-i` |
| `use_euclidean_distance` | `boolean` | No | Use Euclidean distance in distance prior | `-j` |
| `posterior_for_n4` | `int[]` | No | Posterior labels for N4 weight mask | `-y` |
| `image_suffix` | `string` | No | Output image file suffix (e.g., nii.gz) | `-s` |
| `keep_temporary` | `boolean` | No | Keep temporary files | `-k` |
| `use_random_seeding` | `boolean` | No | Use random seeding | `-u` |

### Accepted Input Extensions

- **input_image**: `.nii`, `.nii.gz`
- **mask_image**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `segmentation` | `File` | `$(inputs.output_prefix)Segmentation.nii.gz` |
| `posteriors` | `File[]` | `$(inputs.output_prefix)SegmentationPosteriors*.nii.gz` |
| `bias_corrected` | `File` | `$(inputs.output_prefix)Segmentation0N4.nii.gz` |
| `log` | `File` | `antsAtroposN4.log` |

### Output Extensions

- **segmentation**: `.nii.gz`
- **posteriors**: `.nii.gz`
- **bias_corrected**: `.nii.gz`

## Docker Tags

Available versions: `latest`, `master`, `v2.6.5`, `2.6.5`, `v2.6.4`, `2.6.4`, `v2.6.3`, `2.6.3`, `v2.6.2`, `2.6.2`
 and 5 more

## Categories

- Structural MRI > ANTs > Segmentation
- Pipelines > ANTs > Structural

## Documentation

[Official Documentation](https://github.com/ANTsX/ANTs/wiki/Atropos-and-N4)
