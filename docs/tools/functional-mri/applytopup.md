# FSL Apply Topup Distortion Correction

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Applies the susceptibility-induced off-resonance field estimated by topup to correct distortions in EPI images.

**Modality:** 3D or 4D EPI NIfTI plus topup output (movpar.txt and fieldcoef files).

**Typical Use:** Applying distortion correction to fMRI or DWI data using pre-computed topup results.

## Key Parameters

--imain (input images), --topup (topup output prefix), --datain (acquisition parameters), --inindex (index into datain), --out (output), --method (jac or lsr)

## Key Points

Use after running topup. --method=jac applies Jacobian modulation (recommended for fMRI). Can apply to multiple images at once.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input image(s) to correct | `--imain=` |
| `topup_fieldcoef` | `File` | Yes | Topup field coefficients file (_fieldcoef.nii.gz from topup) |  |
| `topup_movpar` | `File` | Yes | Topup movement parameters file (_movpar.txt from topup) |  |
| `encoding_file` | `File` | Yes | Acquisition parameters file (same as used for topup) | `--datain=` |
| `inindex` | `string` | Yes | Comma-separated indices into encoding_file for each input image | `--inindex=` |
| `output` | `string` | Yes | Output basename for corrected images | `--out=` |
| `method` | `enum` | No | Resampling method (jac=Jacobian, lsr=least-squares) | `--method=` |
| `interp` | `enum` | No | Interpolation method (only for method=jac) | `--interp=` |
| `datatype` | `enum` | No | Force output data type | `--datatype=` |
| `verbose` | `boolean` | No | Verbose output | `-v` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`
- **topup_fieldcoef**: `.nii`, `.nii.gz`
- **topup_movpar**: `.txt`
- **encoding_file**: `.txt`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `corrected_images` | `File` | `$(inputs.output).nii.gz`, `$(inputs.output).nii` |
| `log` | `File` | `applytopup.log` |
| `err_log` | `File` | `applytopup.err.log` |

### Output Extensions

- **corrected_images**: `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Functional MRI > FSL > Distortion Correction

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/topup/ApplyTopupUsersGuide)
