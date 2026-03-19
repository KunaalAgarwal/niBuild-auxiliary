# ANTs Motion Correction

**Library:** ANTs | **Docker Image:** `antsx/ants`

## Function

Motion correction for time series data using ANTs registration framework with rigid or affine transformations.

**Modality:** 4D fMRI or dynamic PET NIfTI time series.

**Typical Use:** High-quality motion correction using ANTs registration framework.

## Key Parameters

-d (dimension), -a (compute average), -o (output), -u (use fixed reference), -m (metric)

## Key Points

Can compute average image and motion-correct simultaneously. Uses ANTs optimization. Slower than MCFLIRT.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `dimensionality` | `int` | Yes | Image dimensionality (2 or 3) | `-d` |
| `fixed_image` | `File` | Yes | Fixed/reference 3D image |  |
| `moving_image` | `File` | Yes | Moving 4D time series image |  |
| `output_prefix` | `string` | Yes | Output transform prefix | `-o` |
| `metric` | `string` | Yes | Metric specification (e.g., MI[fixed,moving,1,32,Regular,0.1]) | `-m` |
| `transform` | `string` | Yes | Transform type (e.g., Rigid[0.1] or Affine[0.1]) | `-t` |
| `iterations` | `string` | Yes | Iterations at each level (e.g., 100x50x30) | `-i` |
| `shrink_factors` | `string` | Yes | Shrink factors at each level (e.g., 4x2x1) | `-f` |
| `smoothing_sigmas` | `string` | Yes | Smoothing sigmas at each level (e.g., 2x1x0) | `-s` |
| `num_images` | `int` | No | Number of images to use from time series | `-n` |
| `use_fixed_reference` | `boolean` | No | Use fixed reference for all time points | `-u` |
| `use_scale_estimator` | `boolean` | No | Use scale estimator | `-e` |
| `write_displacement` | `boolean` | No | Write 4D displacement field | `-w` |
| `average_image` | `boolean` | No | Average the input time series | `-a` |
| `verbose` | `boolean` | No | Enable verbose output | `-v` |

### Accepted Input Extensions

- **fixed_image**: `.nii`, `.nii.gz`
- **moving_image**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `corrected_image` | `File` | `$(inputs.output_prefix)_corrected.nii.gz` |
| `average_image` | `File` | `$(inputs.output_prefix)_avg.nii.gz` |
| `motion_parameters` | `File[]` | `$(inputs.output_prefix)MOCOparams.csv` |
| `displacement_field` | `File` | `$(inputs.output_prefix)Warp.nii.gz` |
| `log` | `File` | `antsMotionCorr.log` |

### Output Extensions

- **corrected_image**: `.nii.gz`
- **average_image**: `.nii.gz`
- **motion_parameters**: `.csv`
- **displacement_field**: `.nii.gz`

## Docker Tags

Available versions: `latest`, `master`, `v2.6.5`, `2.6.5`, `v2.6.4`, `2.6.4`, `v2.6.3`, `2.6.3`, `v2.6.2`, `2.6.2`
 and 5 more

## Categories

- Functional MRI > ANTs > Motion Correction

## Documentation

[Official Documentation](https://github.com/ANTsX/ANTs/wiki/antsMotionCorr)
