# MRtrix3 Diffusion Tensor Estimation

**Library:** MRtrix3 | **Docker Image:** `mrtrix3/mrtrix3`

## Function

Estimates the diffusion tensor model at each voxel from preprocessed DWI data using weighted or ordinary least squares.

**Modality:** 4D diffusion-weighted NIfTI with gradient table (b-values and b-vectors).

**Typical Use:** Fitting diffusion tensor to DWI data for FA/MD map generation.

## Key Parameters

<input> <output>, -mask (brain mask), -b0 (output mean b=0 image), -dkt (output diffusion kurtosis tensor)

## Key Points

Assumes single fiber per voxel. Gradient information must be in image header or provided via -fslgrad bvecs bvals.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input DWI image |  |
| `output` | `string` | Yes | Output tensor image |  |
| `mask` | `File` | No | Processing mask | `-mask` |
| `b0` | `string` | No | Output mean b=0 image filename | `-b0` |
| `dkt` | `string` | No | Output diffusion kurtosis tensor filename | `-dkt` |
| `ols` | `boolean` | No | Use ordinary least squares estimator | `-ols` |
| `iter` | `int` | No | Number of iteratively-reweighted least squares iterations | `-iter` |

### Accepted Input Extensions

- **input**: `.mif`, `.nii`, `.nii.gz`, `.mgh`, `.mgz`
- **mask**: `.mif`, `.nii`, `.nii.gz`, `.mgh`, `.mgz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `tensor` | `File` | `$(inputs.output)` |
| `b0_image` | `File` | `${
  if (inputs.b0) { return inputs.b0; }
  else { return "UNUSED_PLACEHOLDER_DO_NOT_MATCH"; }
}
` |
| `kurtosis_tensor` | `File` | `${
  if (inputs.dkt) { return inputs.dkt; }
  else { return "UNUSED_PLACEHOLDER_DO_NOT_MATCH"; }
}
` |
| `log` | `File` | `dwi2tensor.log` |

### Output Extensions

- **tensor**: `.mif`, `.nii`, `.nii.gz`
- **b0_image**: `.mif`, `.nii`, `.nii.gz`
- **kurtosis_tensor**: `.mif`, `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `3.0.8`, `3.0.7`, `3.0.5`, `3.0.4`, `3.0.3`

## Categories

- Diffusion MRI > MRtrix3 > Tensor/FOD

## Documentation

[Official Documentation](https://mrtrix.readthedocs.io/en/latest/reference/commands/dwi2tensor.html)
