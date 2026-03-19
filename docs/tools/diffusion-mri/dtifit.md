# FSL Diffusion Tensor Fitting (dtifit)

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Fits a diffusion tensor model to each voxel of preprocessed diffusion-weighted data to generate scalar diffusion maps.

**Modality:** 4D diffusion-weighted NIfTI with b-values (.bval), b-vectors (.bvec), and brain mask.

**Typical Use:** Generating fractional anisotropy (FA) and mean diffusivity (MD) maps from DWI data.

## Key Parameters

-k (input DWI), -o (output basename), -m (brain mask), -r (bvecs file), -b (bvals file)

## Key Points

Outputs FA, MD, eigenvalues (L1/L2/L3), eigenvectors (V1/V2/V3), and full tensor. Assumes single-fiber per voxel (use bedpostx for crossing fibers).

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `data` | `File` | Yes | Input diffusion data | `-k` |
| `mask` | `File` | Yes | Brain mask | `-m` |
| `bvecs` | `File` | Yes | b-vectors file | `-r` |
| `bvals` | `File` | Yes | b-values file | `-b` |
| `output` | `string` | Yes | Output basename | `-o` |
| `wls` | `boolean` | No | Use weighted least squares | `-w` |
| `sse` | `boolean` | No | Output sum of squared errors | `--sse` |
| `save_tensor` | `boolean` | No | Save tensor elements | `--save_tensor` |

### Accepted Input Extensions

- **data**: `.nii`, `.nii.gz`
- **mask**: `.nii`, `.nii.gz`
- **bvecs**: `.bvec`
- **bvals**: `.bval`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `FA` | `File` | `$(inputs.output)_FA.nii.gz`, `$(inputs.output)_FA.nii` |
| `MD` | `File` | `$(inputs.output)_MD.nii.gz`, `$(inputs.output)_MD.nii` |
| `L1` | `File` | `$(inputs.output)_L1.nii.gz`, `$(inputs.output)_L1.nii` |
| `L2` | `File` | `$(inputs.output)_L2.nii.gz`, `$(inputs.output)_L2.nii` |
| `L3` | `File` | `$(inputs.output)_L3.nii.gz`, `$(inputs.output)_L3.nii` |
| `V1` | `File` | `$(inputs.output)_V1.nii.gz`, `$(inputs.output)_V1.nii` |
| `V2` | `File` | `$(inputs.output)_V2.nii.gz`, `$(inputs.output)_V2.nii` |
| `V3` | `File` | `$(inputs.output)_V3.nii.gz`, `$(inputs.output)_V3.nii` |
| `tensor` | `File` | `$(inputs.output)_tensor.nii.gz`, `$(inputs.output)_tensor.nii` |
| `log` | `File` | `dtifit.log` |

### Output Extensions

- **FA**: `.nii`, `.nii.gz`
- **MD**: `.nii`, `.nii.gz`
- **L1**: `.nii`, `.nii.gz`
- **L2**: `.nii`, `.nii.gz`
- **L3**: `.nii`, `.nii.gz`
- **V1**: `.nii`, `.nii.gz`
- **V2**: `.nii`, `.nii.gz`
- **V3**: `.nii`, `.nii.gz`
- **tensor**: `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Diffusion MRI > FSL > Tensor Fitting

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FDT/UserGuide#DTIFIT)
