# ANTs Image Thresholding

**Library:** ANTs | **Docker Image:** `antsx/ants`

## Function

Applies various thresholding methods to create binary masks, including Otsu and k-means adaptive thresholding.

**Modality:** 3D NIfTI volume.

**Typical Use:** Creating binary masks, Otsu-based adaptive thresholding.

## Key Parameters

<dimension> <input> <output> <lower> <upper> (binary) or Otsu <num_thresholds> (automatic)

## Key Points

Otsu mode automatically finds optimal threshold. Binary mode uses explicit lower/upper bounds.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `dimensionality` | `int` | Yes | Image dimensionality (2, 3, or 4) |  |
| `input_image` | `File` | Yes | Input image to threshold |  |
| `output_image` | `string` | Yes | Output thresholded image filename |  |
| `threshold_mode` | `enum` | No | Automatic thresholding mode |  |
| `num_thresholds` | `int` | No | Number of thresholds for Otsu/Kmeans |  |
| `mask_image` | `File` | No | Mask image for Otsu/Kmeans thresholding |  |
| `threshold_low` | `double` | No | Lower threshold value |  |
| `threshold_high` | `double` | No | Upper threshold value (use inf for no upper bound) |  |
| `inside_value` | `double` | No | Value for voxels inside threshold range (default 1) |  |
| `outside_value` | `double` | No | Value for voxels outside threshold range (default 0) |  |

### Accepted Input Extensions

- **input_image**: `.nii`, `.nii.gz`
- **mask_image**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `thresholded` | `File` | `$(inputs.output_image)` |
| `log` | `File` | `ThresholdImage.log` |

### Output Extensions

- **thresholded**: `.nii`, `.nii.gz`

## Enum Options

**`threshold_mode`**: `Otsu`, `Kmeans`

## Docker Tags

Available versions: `latest`, `master`, `v2.6.5`, `2.6.5`, `v2.6.4`, `2.6.4`, `v2.6.3`, `2.6.3`, `v2.6.2`, `2.6.2`
 and 5 more

## Categories

- Utilities > ANTs > Image Operations

## Documentation

[Official Documentation](https://github.com/ANTsX/ANTs/wiki)
