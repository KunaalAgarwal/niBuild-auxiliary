# ANTs Image Math Operations

**Library:** ANTs | **Docker Image:** `antsx/ants`

## Function

Versatile tool for image arithmetic, morphological operations, distance transforms, and various measurements.

**Modality:** 3D NIfTI volume(s).

**Typical Use:** Mathematical operations, morphological operations, connected component analysis.

## Key Parameters

<dimension> <output> <operation> <input1> [input2] [parameters]

## Key Points

Operations include: m (multiply), + (add), ME/MD (erode/dilate), GetLargestComponent, FillHoles, Normalize.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `dimensionality` | `int` | Yes | Image dimensionality (2, 3, or 4) |  |
| `output_image` | `string` | Yes | Output image filename |  |
| `operation` | `string` | Yes | Operation to perform (m, +, -, /, G, MD, ME, MO, MC, etc.) |  |
| `input_image` | `File` | Yes | First input image |  |
| `second_input` | `File` | No | Second input image for binary operations |  |
| `scalar_value` | `double` | No | Scalar value for operations (alternative to second image) |  |

### Accepted Input Extensions

- **input_image**: `.nii`, `.nii.gz`
- **second_input**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `output` | `File` | `$(inputs.output_image)` |
| `log` | `File` | `ImageMath.log` |

### Output Extensions

- **output**: `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `master`, `v2.6.5`, `2.6.5`, `v2.6.4`, `2.6.4`, `v2.6.3`, `2.6.3`, `v2.6.2`, `2.6.2`
 and 5 more

## Categories

- Utilities > ANTs > Image Operations

## Documentation

[Official Documentation](https://github.com/ANTsX/ANTs/wiki/ImageMath)
