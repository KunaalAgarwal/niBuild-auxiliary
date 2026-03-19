# ANTs Atropos Tissue Segmentation

**Library:** ANTs | **Docker Image:** `antsx/ants`

## Function

Probabilistic tissue segmentation using expectation-maximization algorithm with Markov random field spatial prior.

**Modality:** Brain-extracted 3D NIfTI volume plus brain mask.

**Typical Use:** GMM-based brain tissue segmentation with spatial regularization.

## Key Parameters

-d (dimension), -a (input image), -x (mask), -i (initialization: KMeans[N] or PriorProbabilityImages), -c (convergence), -o (output)

## Key Points

Initialize with KMeans[3] for basic GM/WM/CSF or use prior probability images. MRF prior improves spatial coherence.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `dimensionality` | `int` | Yes | Image dimensionality (2, 3, or 4) | `-d` |
| `intensity_image` | `File` | Yes | Input intensity image for segmentation | `-a` |
| `mask_image` | `File` | Yes | Mask image defining segmentation region | `-x` |
| `output_prefix` | `string` | Yes | Output segmentation filename | `-o` |
| `initialization` | `string` | Yes | Initialization method (e.g., kmeans[3], otsu[3], priorProbabilityImages[...]) | `-i` |
| `likelihood_model` | `enum` | No | Likelihood model for intensity estimation | `-k` |
| `mrf` | `string` | No | MRF parameters [smoothingFactor,radius] e.g., [0.3,1x1x1] | `-m` |
| `convergence` | `string` | No | Convergence parameters [iterations,threshold] e.g., [5,0.001] | `-c` |
| `prior_weighting` | `double` | No | Prior probability weight (0-1) | `-w` |
| `use_euclidean_distance` | `boolean` | No | Use Euclidean distance for label propagation | `-e` |
| `posterior_formulation` | `string` | No | Posterior formulation (e.g., Socrates[1]) | `-p` |
| `winsorize_outliers` | `string` | No | Outlier handling method (e.g., BoxPlot[0.25,0.75,1.5]) | `--winsorize-outliers` |
| `verbose` | `boolean` | No | Enable verbose output | `--verbose` |

### Accepted Input Extensions

- **intensity_image**: `.nii`, `.nii.gz`
- **mask_image**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `segmentation` | `File` | `$(inputs.output_prefix)` |
| `posteriors` | `File[]` | `$(inputs.output_prefix)*Posteriors*.nii.gz` |
| `log` | `File` | `Atropos.log` |

### Output Extensions

- **segmentation**: `.nii`, `.nii.gz`
- **posteriors**: `.nii.gz`

## Enum Options

**`likelihood_model`**: `Gaussian`, `HistogramParzenWindows`, `ManifoldParzenWindows`

## Docker Tags

Available versions: `latest`, `master`, `v2.6.5`, `2.6.5`, `v2.6.4`, `2.6.4`, `v2.6.3`, `2.6.3`, `v2.6.2`, `2.6.2`
 and 5 more

## Categories

- Structural MRI > ANTs > Segmentation

## Documentation

[Official Documentation](https://github.com/ANTsX/ANTs/wiki/Atropos-and-N4)
