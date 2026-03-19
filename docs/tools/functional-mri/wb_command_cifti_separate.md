# Connectome Workbench CIFTI Separate

**Library:** Connectome Workbench | **Docker Image:** `khanlab/connectome-workbench`

## Function

Extracts surface or volume components from a CIFTI file into separate GIFTI metric or NIfTI volume files.

**Modality:** CIFTI dense file (.dscalar.nii, .dtseries.nii, etc.).

**Typical Use:** Extracting surface or volume data from CIFTI files for further processing.

## Key Parameters

<cifti-in> <direction> -volume-all <volume-out> -metric <structure> <metric-out>

## Key Points

Opposite of cifti-create operations. Useful for extracting data for tools that do not support CIFTI format.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `cifti_in` | `File` | Yes | Input CIFTI file to separate |  |
| `direction` | `enum` | Yes | Separation direction (ROW or COLUMN) |  |
| `volume_all` | `string` | No | Output volume file for all volume structures | `-volume-all` |
| `volume_all_crop` | `boolean` | No | Crop volume to data size | `-crop` |
| `metric_left` | `string` | No | Output metric file for left cortex |  |
| `metric_right` | `string` | No | Output metric file for right cortex |  |

### Accepted Input Extensions

- **cifti_in**: `.dtseries.nii`, `.dscalar.nii`, `.dlabel.nii`, `.dconn.nii`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `volume_output` | `File` | `$(inputs.volume_all)` |
| `left_metric_output` | `File` | `$(inputs.metric_left)` |
| `right_metric_output` | `File` | `$(inputs.metric_right)` |
| `log` | `File` | `wb_cifti_separate.log` |
| `err_log` | `File` | `wb_cifti_separate.err.log` |

### Output Extensions

- **volume_output**: `.nii`, `.nii.gz`
- **left_metric_output**: `.func.gii`
- **right_metric_output**: `.func.gii`

## Docker Tags

Available versions: `latest`

## Categories

- Functional MRI > Connectome Workbench > CIFTI Operations

## Documentation

[Official Documentation](https://www.humanconnectome.org/software/workbench-command/-cifti-separate)
