# FSL Eddy Current and Motion Correction (eddy)

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Corrects eddy current-induced distortions and subject movement in diffusion MRI data using a Gaussian process model.

**Modality:** 4D diffusion-weighted NIfTI with b-values (.bval), b-vectors (.bvec), acquisition parameters, and index files.

**Typical Use:** Primary preprocessing step for diffusion MRI after topup distortion correction.

## Key Parameters

--imain (input DWI), --bvals, --bvecs, --acqp (acquisition params), --index (volume indices), --topup (topup output), --out (output)

## Key Points

Should follow topup if available. Outputs rotated bvecs to account for motion. Use --repol for outlier replacement. GPU version (eddy_cuda) much faster.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input DWI image | `--imain=` |
| `bvals` | `File` | Yes | b-values file | `--bvals=` |
| `bvecs` | `File` | Yes | b-vectors file | `--bvecs=` |
| `acqp` | `File` | Yes | Acquisition parameters file | `--acqp=` |
| `index` | `File` | Yes | Index file mapping volumes to acquisition parameters | `--index=` |
| `mask` | `File` | Yes | Brain mask | `--mask=` |
| `output` | `string` | Yes | Output basename | `--out=` |
| `topup` | `string` | No | Topup results basename | `--topup=` |
| `repol` | `boolean` | No | Detect and replace outlier slices | `--repol` |
| `slm` | `string` | No | Second level model (none/linear/quadratic) | `--slm=` |
| `niter` | `int` | No | Number of iterations | `--niter=` |
| `fwhm` | `string` | No | FWHM for conditioning regularisation (comma-separated) | `--fwhm=` |
| `flm` | `string` | No | First level EC model (movement/linear/quadratic/cubic) | `--flm=` |
| `interp` | `string` | No | Interpolation model (spline/trilinear) | `--interp=` |
| `dont_sep_offs_move` | `boolean` | No | Do not separate field offset from subject movement | `--dont_sep_offs_move` |
| `nvoxhp` | `int` | No | Number of voxels for hyperparameter estimation (default 1000) | `--nvoxhp=` |
| `data_is_shelled` | `boolean` | No | Assume data is shelled (skip check) | `--data_is_shelled` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`
- **bvals**: `.bval`
- **bvecs**: `.bvec`
- **acqp**: `.txt`
- **index**: `.txt`
- **mask**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `corrected_image` | `File` | `$(inputs.output).nii.gz`, `$(inputs.output).nii` |
| `rotated_bvecs` | `File` | `$(inputs.output).eddy_rotated_bvecs` |
| `parameters` | `File` | `$(inputs.output).eddy_parameters` |
| `log` | `File` | `eddy.log` |

### Output Extensions

- **corrected_image**: `.nii`, `.nii.gz`
- **rotated_bvecs**: `.eddy_rotated_bvecs`
- **parameters**: `.eddy_parameters`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Diffusion MRI > FSL > Preprocessing

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/eddy)
