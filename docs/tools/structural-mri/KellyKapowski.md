# ANTs DiReCT Cortical Thickness (KellyKapowski)

**Library:** ANTs | **Docker Image:** `antsx/ants`

## Function

Estimates cortical thickness using the DiReCT algorithm from segmentation data.

**Modality:** Tissue segmentation image plus GM and WM probability maps (3D NIfTI).

**Typical Use:** Computing cortical thickness from pre-existing tissue segmentation.

## Key Parameters

-d (dimension), -s (segmentation image), -g (GM probability), -w (WM probability), -o (output thickness map), -c (convergence)

## Key Points

Core thickness estimation engine used by antsCorticalThickness.sh. Requires good segmentation as input.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `dimensionality` | `int` | Yes | Image dimensionality (2 or 3) | `-d` |
| `segmentation_image` | `File` | Yes | Segmentation image with labeled tissues | `-s` |
| `gray_matter_prob` | `File` | Yes | Gray matter probability image | `-g` |
| `white_matter_prob` | `File` | Yes | White matter probability image | `-w` |
| `output_image` | `string` | Yes | Output cortical thickness image | `-o` |
| `convergence` | `string` | No | Convergence parameters [iterations,convergenceThreshold,thicknessPrior] | `-c` |
| `thickness_prior` | `double` | No | Prior estimate for cortical thickness | `-t` |
| `gradient_step` | `double` | No | Gradient descent step size | `-r` |
| `smoothing_sigma` | `double` | No | Gradient field smoothing parameter | `-m` |
| `number_integration_points` | `int` | No | Number of integration points | `-n` |
| `verbose` | `boolean` | No | Enable verbose output | `-v` |

### Accepted Input Extensions

- **segmentation_image**: `.nii`, `.nii.gz`
- **gray_matter_prob**: `.nii`, `.nii.gz`
- **white_matter_prob**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `thickness_image` | `File` | `$(inputs.output_image)` |
| `log` | `File` | `KellyKapowski.log` |

### Output Extensions

- **thickness_image**: `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `master`, `v2.6.5`, `2.6.5`, `v2.6.4`, `2.6.4`, `v2.6.3`, `2.6.3`, `v2.6.2`, `2.6.2`
 and 5 more

## Categories

- Structural MRI > ANTs > Cortical Thickness

## Documentation

[Official Documentation](https://github.com/ANTsX/ANTs/wiki/antsCorticalThickness-and-Templates)
