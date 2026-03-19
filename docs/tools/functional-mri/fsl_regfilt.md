# FSL Component Regression Filter (fsl_regfilt)

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Removes nuisance components from 4D fMRI data by regressing out specified columns from a design or mixing matrix.

**Modality:** 4D fMRI NIfTI time series with associated ICA mixing matrix.

**Typical Use:** Removing ICA-identified noise components from fMRI data, often used with FIX or manual classification.

## Key Parameters

-i (input 4D), -d (design/mixing matrix), -o (output), -f (component indices to remove)

## Key Points

Typically used with MELODIC output. Removes ICA components classified as noise. Component indices are comma-separated or ranges.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input 4D data file | `-i` |
| `design` | `File` | Yes | Design matrix (e.g., MELODIC mixing matrix) | `-d` |
| `output` | `string` | Yes | Output filename | `-o` |
| `filter` | `string` | Yes | Component indices to filter out (comma-separated, 1-indexed) | `-f` |
| `aggressive` | `boolean` | No | Use aggressive (full variance) filtering | `-a` |
| `freq_filter` | `boolean` | No | Frequency-based filtering | `--freq` |
| `freq_ic` | `File` | No | Frequency IC file for frequency-based filtering | `--freq_ic` |
| `verbose` | `boolean` | No | Verbose output | `-v` |
| `mask` | `File` | No | Brain mask | `-m` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`
- **design**: `.txt`, `.mat`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `filtered_data` | `File` | `$(inputs.output).nii.gz`, `$(inputs.output).nii`, `$(inputs.output)` |
| `log` | `File` | `fsl_regfilt.log` |

### Output Extensions

- **output**: `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Functional MRI > FSL > ICA/Denoising

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/fsl_regfilt)
