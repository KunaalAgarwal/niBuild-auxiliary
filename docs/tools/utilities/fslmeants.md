# FSL Mean Time Series Extraction (fslmeants)

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Extracts the mean time series from a 4D dataset within a mask or at specified coordinates.

**Modality:** 4D fMRI NIfTI time series plus ROI mask or coordinates.

**Typical Use:** ROI time series extraction for seed-based connectivity analysis.

## Key Parameters

-i (input 4D), -o (output text file), -m (mask image), -c (x y z coordinates), --eig (output eigenvariates)

## Key Points

Outputs one value per timepoint. Use -m for mask-based extraction, -c for single-voxel. --eig outputs eigenvariate (first principal component) instead of mean.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input 4D image | `-i` |
| `output` | `string` | Yes | Output text file for timeseries | `-o` |
| `mask` | `File` | No | Mask image | `-m` |
| `label` | `File` | No | Label image for extracting timeseries per label | `--label=` |
| `coord` | `string` | No | Voxel coordinates (x y z) for single voxel timeseries | `-c` |
| `usemm` | `boolean` | No | Use mm coordinates instead of voxel coordinates | `--usemm` |
| `showall` | `boolean` | No | Show all voxel time series instead of mean | `--showall` |
| `transpose` | `boolean` | No | Output in transposed format (time x voxels) | `--transpose` |
| `eig` | `boolean` | No | Calculate eigenvariates instead of mean | `--eig` |
| `order` | `int` | No | Number of eigenvariates to output | `--order=` |
| `nobin` | `boolean` | No | Do not binarize mask for eigenvariate calculation | `--no_bin` |
| `verbose` | `boolean` | No | Enable verbose output | `-v` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`
- **mask**: `.nii`, `.nii.gz`
- **label**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `timeseries` | `File` | `$(inputs.output)` |
| `log` | `File` | `fslmeants.log` |

### Output Extensions

- **timeseries**: `.txt`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Utilities > FSL > Image Math

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/Fslutils)
