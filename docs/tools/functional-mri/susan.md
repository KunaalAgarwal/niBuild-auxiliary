# Smallest Univalue Segment Assimilating Nucleus (SUSAN)

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Edge-preserving noise reduction using nonlinear filtering that smooths within tissue boundaries while preserving edges.

**Modality:** 3D or 4D NIfTI volume (structural or functional).

**Typical Use:** Noise reduction while preserving structural boundaries in functional or structural data.

## Key Parameters

<input> <brightness_threshold> <spatial_size_mm> <dimensionality> <use_median> <n_usans> [<usan1>] <output>

## Key Points

Brightness threshold typically 0.75 * median intensity. Set dimensionality to 3 for 3D volumes. Better edge preservation than Gaussian smoothing.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input image |  |
| `brightness_threshold` | `double` | Yes | Brightness threshold (should be > noise and < edge contrast) |  |
| `fwhm` | `double` | Yes | Spatial extent (FWHM in mm) |  |
| `dimension` | `int` | No | Dimensionality (2=2D, 3=3D, default 3) |  |
| `use_median` | `int` | No | Use median (1) or mean (0) for brightness calculation (default 1) |  |
| `n_usans` | `int` | No | Number of USAN areas to use (0, 1, or 2) |  |
| `output` | `string` | Yes | Output filename |  |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `smoothed_image` | `File` | `$(inputs.output).nii.gz`, `$(inputs.output).nii`, `$(inputs.output)` |
| `log` | `File` | `susan.log` |

### Output Extensions

- **smoothed_image**: `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Functional MRI > FSL > Smoothing

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/SUSAN)
