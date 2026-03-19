# FMRIB's Non-linear Image Registration Tool (FNIRT)

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Non-linear registration using B-spline deformations for precise anatomical alignment to a template.

**Modality:** T1-weighted 3D NIfTI volume plus reference template. Requires initial affine from FLIRT.

**Typical Use:** High-accuracy normalization to MNI space for group analyses.

## Key Parameters

--ref (reference), --aff (initial affine), --config (config file), --cout (coefficient output), --iout (warped output)

## Key Points

Always run FLIRT first for initial alignment. Use --config=T1_2_MNI152_2mm for standard T1-to-MNI. Computationally intensive.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input image to register | `--in=` |
| `reference` | `File` | Yes | Reference/target image | `--ref=` |
| `affine` | `File` | No | Affine transformation matrix from FLIRT | `--aff=` |
| `inwarp` | `File` | No | Initial non-linear warp (coefficients or field) | `--inwarp=` |
| `intin` | `File` | No | Initial intensity mapping from previous FNIRT run | `--intin=` |
| `config` | `File` | No | Configuration file with predefined settings | `--config=` |
| `refmask` | `File` | No | Reference space mask | `--refmask=` |
| `inmask` | `File` | No | Input image mask | `--inmask=` |
| `cout` | `string` | No | Output warp coefficients filename | `--cout=` |
| `iout` | `string` | No | Output warped image filename | `--iout=` |
| `fout` | `string` | No | Output displacement field filename | `--fout=` |
| `jout` | `string` | No | Output Jacobian map filename | `--jout=` |
| `refout` | `string` | No | Output intensity modulated reference filename | `--refout=` |
| `intout` | `string` | No | Output intensity transformation filename | `--intout=` |
| `logout` | `string` | No | Output log filename | `--logout=` |
| `warpres` | `string` | No | Warp resolution in mm (e.g., "10,10,10") | `--warpres=` |
| `splineorder` | `int` | No | B-spline order (2=quadratic, 3=cubic) | `--splineorder=` |
| `regmod` | `enum` | No | Regularization model | `--regmod=` |
| `intmod` | `enum` | No | Intensity normalization model | `--intmod=` |
| `intorder` | `int` | No | Order of polynomial intensity modulation | `--intorder=` |
| `subsamp` | `string` | No | Subsampling levels (e.g., "4,2,1,1") | `--subsamp=` |
| `miter` | `string` | No | Max iterations per level (e.g., "5,5,5,5") | `--miter=` |
| `infwhm` | `string` | No | Input smoothing FWHM per level (e.g., "8,4,2,2") | `--infwhm=` |
| `reffwhm` | `string` | No | Reference smoothing FWHM per level (e.g., "8,4,2,2") | `--reffwhm=` |
| `lambda_` | `string` | No | Regularization weight per level | `--lambda=` |
| `ssqlambda` | `int` | No | Weight lambda by sum-of-squared differences (0 or 1) | `--ssqlambda=` |
| `jacrange` | `string` | No | Allowable Jacobian range (e.g., "0.01,100") | `--jacrange=` |
| `biasres` | `string` | No | Bias field spline resolution (e.g., "50,50,50") | `--biasres=` |
| `biaslambda` | `double` | No | Bias field regularization weight | `--biaslambda=` |
| `numprec` | `enum` | No | Numerical precision for Hessian calculation | `--numprec=` |
| `verbose` | `boolean` | No | Verbose output | `--verbose` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`
- **reference**: `.nii`, `.nii.gz`
- **affine**: `.mat`
- **inwarp**: `.nii`, `.nii.gz`
- **intin**: `.nii`, `.nii.gz`
- **config**: `.cnf`
- **refmask**: `.nii`, `.nii.gz`
- **inmask**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `warp_coefficients` | `File` | `$(inputs.cout).nii.gz`, `$(inputs.cout).nii` |
| `warped_image` | `File` | `$(inputs.iout).nii.gz`, `$(inputs.iout).nii` |
| `displacement_field` | `File` | `$(inputs.fout).nii.gz`, `$(inputs.fout).nii` |
| `jacobian_map` | `File` | `$(inputs.jout).nii.gz`, `$(inputs.jout).nii` |
| `intensity_modulated_ref` | `File` | `$(inputs.refout).nii.gz`, `$(inputs.refout).nii` |
| `log` | `File` | `fnirt.log` |

### Output Extensions

- **warp_coefficients**: `.nii`, `.nii.gz`
- **warped_image**: `.nii`, `.nii.gz`
- **displacement_field**: `.nii`, `.nii.gz`
- **jacobian_map**: `.nii`, `.nii.gz`
- **intensity_modulated_ref**: `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Structural MRI > FSL > Registration

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FNIRT)
