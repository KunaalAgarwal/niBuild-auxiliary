# Tool for Estimating and Correcting Susceptibility-Induced Distortions (TOPUP)

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Estimates and corrects susceptibility-induced distortions using pairs of images with reversed phase-encode directions.

**Modality:** 4D NIfTI with concatenated blip-up/blip-down b=0 images, plus acquisition parameters file.

**Typical Use:** Distortion correction using blip-up/blip-down acquisitions for fMRI or DWI.

## Key Parameters

--imain (concatenated images), --datain (acquisition parameters file), --config (config file), --out (output basename)

## Key Points

Requires reversed phase-encode image pair. Default config b02b0.cnf works well for most data. Outputs warp fields reusable by applytopup.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input 4D image with reversed phase-encode pairs | `--imain=` |
| `encoding_file` | `File` | Yes | Acquisition parameters file (phase encode direction and readout time) | `--datain=` |
| `output` | `string` | Yes | Output basename | `--out=` |
| `fout` | `string` | No | Output fieldmap filename | `--fout=` |
| `iout` | `string` | No | Output corrected images filename | `--iout=` |
| `logout` | `string` | No | Output log filename | `--logout=` |
| `dfout` | `string` | No | Output displacement fields filename | `--dfout=` |
| `rbmout` | `string` | No | Output rigid body matrices filename | `--rbmout=` |
| `jacout` | `string` | No | Output Jacobian images filename | `--jacout=` |
| `config` | `File` | No | Configuration file (e.g., b02b0.cnf) | `--config=` |
| `warpres` | `string` | No | Warp resolution in mm (e.g., "10,10,10") | `--warpres=` |
| `subsamp` | `string` | No | Subsampling level (e.g., "1") | `--subsamp=` |
| `fwhm` | `string` | No | FWHM for smoothing (e.g., "8,4,2,1") | `--fwhm=` |
| `miter` | `string` | No | Max iterations per level | `--miter=` |
| `lambda_` | `string` | No | Regularization weight | `--lambda=` |
| `ssqlambda` | `int` | No | Weight lambda by SSD (0 or 1) | `--ssqlambda=` |
| `regmod` | `enum` | No | Regularization model | `--regmod=` |
| `estmov` | `int` | No | Estimate movement (0=off, 1=on) | `--estmov=` |
| `minmet` | `int` | No | Minimization method (0=Levenberg-Marquardt, 1=scaled conjugate gradient) | `--minmet=` |
| `splineorder` | `int` | No | B-spline order (2 or 3) | `--splineorder=` |
| `numprec` | `enum` | No | Numerical precision | `--numprec=` |
| `interp` | `enum` | No | Interpolation method | `--interp=` |
| `scale` | `int` | No | Scale images (0=off, 1=on) | `--scale=` |
| `regrid` | `int` | No | Regrid (0=off, 1=on) | `--regrid=` |
| `verbose` | `boolean` | No | Verbose output | `-v` |
| `nthr` | `int` | No | Number of threads | `--nthr=` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`
- **encoding_file**: `.txt`
- **config**: `.cnf`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `movpar` | `File` | `$(inputs.output)_movpar.txt` |
| `fieldcoef` | `File` | `$(inputs.output)_fieldcoef.nii.gz`, `$(inputs.output)_fieldcoef.nii` |
| `fieldmap` | `File` | `$(inputs.fout).nii.gz`, `$(inputs.fout).nii` |
| `corrected_images` | `File` | `$(inputs.iout).nii.gz`, `$(inputs.iout).nii` |
| `displacement_fields` | `File` | `$(inputs.dfout).nii.gz`, `$(inputs.dfout).nii` |
| `jacobian_images` | `File` | `$(inputs.jacout).nii.gz`, `$(inputs.jacout).nii` |
| `log` | `File` | `topup.log` |

### Output Extensions

- **movpar**: `.txt`
- **fieldcoef**: `.nii`, `.nii.gz`
- **fieldmap**: `.nii`, `.nii.gz`
- **corrected_images**: `.nii`, `.nii.gz`
- **displacement_fields**: `.nii`, `.nii.gz`
- **jacobian_images**: `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Functional MRI > FSL > Distortion Correction
- Diffusion MRI > FSL > Preprocessing

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/topup)
