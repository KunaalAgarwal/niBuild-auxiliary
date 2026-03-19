# Connectome Workbench Surface Metric Smoothing

**Library:** Connectome Workbench | **Docker Image:** `khanlab/connectome-workbench`

## Function

Applies geodesic Gaussian smoothing to surface metric data following the cortical surface geometry.

**Modality:** Surface GIFTI (.surf.gii) plus metric GIFTI (.func.gii or .shape.gii).

**Typical Use:** Smoothing surface-based data (thickness, curvature, fMRI) for visualization or statistics.

## Key Parameters

<surface> <metric-in> <smoothing-kernel> <metric-out> -roi <roi-metric> -fix-zeros

## Key Points

Smoothing follows cortical folding pattern rather than 3D Euclidean distance. ROI can restrict smoothing to specific regions.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `surface` | `File` | Yes | Surface file to smooth on (.surf.gii) |  |
| `metric_in` | `File` | Yes | Input metric file to smooth |  |
| `smoothing_kernel` | `double` | Yes | Gaussian smoothing kernel size in mm (sigma unless -fwhm) |  |
| `metric_out` | `string` | Yes | Output smoothed metric file |  |
| `fwhm` | `boolean` | No | Interpret kernel size as FWHM instead of sigma | `-fwhm` |
| `roi` | `File` | No | ROI metric to restrict smoothing | `-roi` |
| `fix_zeros` | `boolean` | No | Treat zero values as missing data | `-fix-zeros` |
| `column` | `string` | No | Process single column (number or name) | `-column` |
| `corrected_areas` | `File` | No | Vertex areas metric for group average surfaces | `-corrected-areas` |
| `method` | `enum` | No | Smoothing algorithm (default GEO_GAUSS_AREA) | `-method` |

### Accepted Input Extensions

- **surface**: `.surf.gii`
- **metric_in**: `.func.gii`, `.shape.gii`
- **roi**: `.func.gii`, `.shape.gii`
- **corrected_areas**: `.func.gii`, `.shape.gii`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `smoothed_metric` | `File` | `$(inputs.metric_out)` |
| `log` | `File` | `wb_metric_smoothing.log` |
| `err_log` | `File` | `wb_metric_smoothing.err.log` |

### Output Extensions

- **smoothed_metric**: `.func.gii`

## Docker Tags

Available versions: `latest`

## Categories

- Functional MRI > Connectome Workbench > Surface Smoothing

## Documentation

[Official Documentation](https://www.humanconnectome.org/software/workbench-command/-metric-smoothing)
