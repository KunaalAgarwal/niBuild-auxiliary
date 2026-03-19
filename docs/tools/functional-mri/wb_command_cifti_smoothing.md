# Connectome Workbench CIFTI Smoothing

**Library:** Connectome Workbench | **Docker Image:** `khanlab/connectome-workbench`

## Function

Applies geodesic Gaussian smoothing to CIFTI data on cortical surfaces and Euclidean smoothing in subcortical volumes.

**Modality:** CIFTI dense file plus surface files for each hemisphere.

**Typical Use:** Spatial smoothing of fMRI data in CIFTI format for HCP-style pipelines.

## Key Parameters

<cifti-in> <surface-kernel> <volume-kernel> <direction> <cifti-out> -left-surface <surface> -right-surface <surface> -fix-zeros-volume -fix-zeros-surface

## Key Points

Surface smoothing follows cortical geometry (geodesic). Typical kernel 4-6mm FWHM. -fix-zeros prevents smoothing across medial wall.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `cifti_in` | `File` | Yes | Input CIFTI file |  |
| `surface_kernel` | `double` | Yes | Gaussian surface smoothing kernel size in mm (sigma unless -fwhm) |  |
| `volume_kernel` | `double` | Yes | Gaussian volume smoothing kernel size in mm (sigma unless -fwhm) |  |
| `direction` | `enum` | Yes | Smoothing dimension (ROW or COLUMN) |  |
| `cifti_out` | `string` | Yes | Output smoothed CIFTI file |  |
| `fwhm` | `boolean` | No | Interpret kernel sizes as FWHM instead of sigma | `-fwhm` |
| `left_surface` | `File` | No | Left cortical surface file | `-left-surface` |
| `right_surface` | `File` | No | Right cortical surface file | `-right-surface` |
| `cerebellum_surface` | `File` | No | Cerebellum surface file | `-cerebellum-surface` |
| `fix_zeros_volume` | `boolean` | No | Treat volume zeros as missing data | `-fix-zeros-volume` |
| `fix_zeros_surface` | `boolean` | No | Treat surface zeros as missing data | `-fix-zeros-surface` |
| `merged_volume` | `boolean` | No | Smooth across subcortical structure boundaries | `-merged-volume` |
| `cifti_roi` | `File` | No | CIFTI ROI to restrict smoothing | `-cifti-roi` |

### Accepted Input Extensions

- **cifti_in**: `.dtseries.nii`, `.dscalar.nii`, `.dlabel.nii`, `.dconn.nii`
- **left_surface**: `.surf.gii`
- **right_surface**: `.surf.gii`
- **cerebellum_surface**: `.surf.gii`
- **cifti_roi**: `.dscalar.nii`, `.dlabel.nii`, `.dtseries.nii`, `.dconn.nii`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `smoothed_cifti` | `File` | `$(inputs.cifti_out)` |
| `log` | `File` | `wb_cifti_smoothing.log` |
| `err_log` | `File` | `wb_cifti_smoothing.err.log` |

### Output Extensions

- **smoothed_cifti**: `.dtseries.nii`, `.dscalar.nii`

## Docker Tags

Available versions: `latest`

## Categories

- Functional MRI > Connectome Workbench > Surface Smoothing

## Documentation

[Official Documentation](https://www.humanconnectome.org/software/workbench-command/-cifti-smoothing)
