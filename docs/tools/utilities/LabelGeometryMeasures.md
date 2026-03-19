# ANTs Label Geometry Measures

**Library:** ANTs | **Docker Image:** `antsx/ants`

## Function

Computes geometric properties (volume, centroid, bounding box, eccentricity) for each labeled region in a parcellation.

**Modality:** 3D integer-labeled NIfTI volume (parcellation/segmentation), optional intensity image.

**Typical Use:** Extracting volume, centroid, and shape measures per labeled region.

## Key Parameters

<dimension> <label_image> [<intensity_image>] [<output_csv>]

## Key Points

Outputs CSV with volume, centroid, elongation, roundness per label.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `dimensionality` | `int` | Yes | Image dimensionality (2 or 3) |  |
| `label_image` | `File` | Yes | Input label/segmentation image |  |
| `intensity_image` | `File | string` | No | Intensity image for weighted measures (use 'none' to skip) |  |
| `output_csv` | `string` | No | Output CSV file for measurements |  |

### Accepted Input Extensions

- **label_image**: `.nii`, `.nii.gz`
- **intensity_image**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `csv_output` | `File` | `$(inputs.output_csv)` |
| `log` | `File` | `LabelGeometryMeasures.log` |

### Output Extensions

- **csv_output**: `.csv`

## Docker Tags

Available versions: `latest`, `master`, `v2.6.5`, `2.6.5`, `v2.6.4`, `2.6.4`, `v2.6.3`, `2.6.3`, `v2.6.2`, `2.6.2`
 and 5 more

## Categories

- Utilities > ANTs > Label Analysis

## Documentation

[Official Documentation](https://github.com/ANTsX/ANTs/wiki)
