# Connectome Workbench CIFTI Dense Timeseries Creation

**Library:** Connectome Workbench | **Docker Image:** `khanlab/connectome-workbench`

## Function

Creates a CIFTI dense timeseries file (.dtseries.nii) combining cortical surface data with subcortical volume data in a single grayordinates representation.

**Modality:** Surface GIFTI files (left/right hemisphere) plus subcortical volume NIfTI, or volume-only input.

**Typical Use:** Creating CIFTI format fMRI data for HCP-style surface-based analysis.

## Key Parameters

<cifti-out> -volume <volume> <label> -left-metric <metric> -right-metric <metric> -timestep <seconds> -timestart <seconds>

## Key Points

Core format for HCP-style analysis. Combines cortical surfaces and subcortical volumes. Standard grayordinate space is 91k (32k per hemisphere + subcortical).

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `cifti_out` | `string` | Yes | Output CIFTI dense timeseries file (.dtseries.nii) |  |
| `volume_data` | `File` | No | Volume file containing all voxel data for volume structures | `-volume` |
| `structure_label_volume` | `File` | No | Label volume identifying CIFTI structures |  |
| `left_metric` | `File` | No | Metric file for left cortical surface | `-left-metric` |
| `roi_left` | `File` | No | ROI of vertices to use from left surface | `-roi-left` |
| `right_metric` | `File` | No | Metric file for right cortical surface | `-right-metric` |
| `roi_right` | `File` | No | ROI of vertices to use from right surface | `-roi-right` |
| `cerebellum_metric` | `File` | No | Metric file for cerebellum surface | `-cerebellum-metric` |
| `timestep` | `double` | No | Time step between frames in seconds (default 1.0) | `-timestep` |
| `timestart` | `double` | No | Starting time in seconds (default 0.0) | `-timestart` |
| `unit` | `enum` | No | Unit of timestep (default SECOND) | `-unit` |

### Accepted Input Extensions

- **volume_data**: `.nii`, `.nii.gz`
- **structure_label_volume**: `.nii`, `.nii.gz`
- **left_metric**: `.func.gii`, `.shape.gii`
- **roi_left**: `.func.gii`, `.shape.gii`
- **right_metric**: `.func.gii`, `.shape.gii`
- **roi_right**: `.func.gii`, `.shape.gii`
- **cerebellum_metric**: `.func.gii`, `.shape.gii`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `cifti_output` | `File` | `$(inputs.cifti_out)` |
| `log` | `File` | `wb_cifti_create_dense_timeseries.log` |
| `err_log` | `File` | `wb_cifti_create_dense_timeseries.err.log` |

### Output Extensions

- **cifti_output**: `.dtseries.nii`

## Docker Tags

Available versions: `latest`

## Categories

- Functional MRI > Connectome Workbench > CIFTI Operations

## Documentation

[Official Documentation](https://www.humanconnectome.org/software/workbench-command/-cifti-create-dense-timeseries)
