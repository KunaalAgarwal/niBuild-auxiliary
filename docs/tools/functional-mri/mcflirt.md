# Motion Correction using FLIRT (MCFLIRT)

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Intra-modal motion correction for fMRI time series using rigid-body (6-DOF) transformations optimized for fMRI data.

**Modality:** 4D fMRI NIfTI time series.

**Typical Use:** Correcting head motion in functional data; motion parameters used as nuisance regressors.

## Key Parameters

-refvol (reference volume index), -cost (cost function), -plots (output motion parameter plots), -mats (save transformation matrices)

## Key Points

Default reference is middle volume. Use -plots for motion parameter files (6 columns: 3 rotations + 3 translations). Motion params useful as nuisance regressors.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input 4D timeseries to motion-correct | `-in` |
| `output` | `string` | Yes | Output filename | `-out` |
| `ref_vol` | `int` | No | Reference volume number (default is middle volume) | `-refvol` |
| `ref_file` | `File` | No | External reference image for motion correction | `-reffile` |
| `mean_vol` | `boolean` | No | Register to mean volume | `-meanvol` |
| `cost` | `enum` | No | Cost function for optimization | `-cost` |
| `dof` | `int` | No | Degrees of freedom (default 6) | `-dof` |
| `init` | `File` | No | Initial transformation matrix | `-init` |
| `interpolation` | `enum` | No | Final interpolation method |  |
| `save_mats` | `boolean` | No | Save transformation matrices | `-mats` |
| `save_plots` | `boolean` | No | Save motion parameter plots | `-plots` |
| `save_rms` | `boolean` | No | Save RMS displacement parameters | `-rmsabs` |
| `stats` | `boolean` | No | Produce variance and std dev images | `-stats` |
| `stages` | `int` | No | Number of search stages (default 3) | `-stages` |
| `bins` | `int` | No | Number of histogram bins | `-bins` |
| `smooth` | `double` | No | Smoothing for cost function (FWHM in mm) | `-smooth` |
| `scaling` | `double` | No | Scaling factor | `-scaling` |
| `rotation` | `int` | No | Rotation tolerance scaling factor | `-rotation` |
| `edge` | `boolean` | No | Use contour for coarse search | `-edge` |
| `gdt` | `boolean` | No | Use gradient for coarse search | `-gdt` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`
- **ref_file**: `.nii`, `.nii.gz`
- **init**: `.mat`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `motion_corrected` | `File` | `$(inputs.output).nii.gz`, `$(inputs.output).nii` |
| `motion_parameters` | `File` | `$(inputs.output).par` |
| `mean_image` | `File` | `$(inputs.output)_mean_reg.nii.gz`, `$(inputs.output)_mean_reg.nii` |
| `variance_image` | `File` | `$(inputs.output)_variance.nii.gz`, `$(inputs.output)_variance.nii` |
| `std_image` | `File` | `$(inputs.output)_sigma.nii.gz`, `$(inputs.output)_sigma.nii` |
| `transformation_matrices` | `File[]` | `$(inputs.output).mat/MAT_*` |
| `rms_files` | `File[]` | `$(inputs.output)_abs.rms`, `$(inputs.output)_rel.rms`, `$(inputs.output)_abs_mean.rms`, `$(inputs.output)_rel_mean.rms` |
| `log` | `File` | `mcflirt.log` |

### Output Extensions

- **motion_corrected**: `.nii`, `.nii.gz`
- **motion_parameters**: `.par`
- **mean_image**: `.nii`, `.nii.gz`
- **variance_image**: `.nii`, `.nii.gz`
- **std_image**: `.nii`, `.nii.gz`
- **transformation_matrices**: `.mat`
- **rms_files**: `.rms`

## Enum Options

**`cost`**: `mutualinfo`, `corratio`, `normcorr`, `normmi`, `leastsquares`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Functional MRI > FSL > Motion Correction

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/MCFLIRT)
