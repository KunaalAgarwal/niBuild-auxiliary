# Bayesian Estimation of Diffusion Parameters Obtained using Sampling Techniques (BEDPOSTX)

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Multi-step pipeline for Bayesian estimation of fiber orientation distributions. Internally runs multi-fiber MCMC sampling across all voxels with automatic convergence checking, supporting multiple crossing fibers per voxel.

**Modality:** Directory containing 4D DWI (data.nii.gz), b-values (bvals), b-vectors (bvecs), and brain mask (nodif_brain_mask.nii.gz).

**Typical Use:** Prerequisite for probabilistic tractography with probtrackx2.

## Key Parameters

<data_directory>, -n (max fibers per voxel, default 3)

## Key Points

Very computationally intensive (hours-days). GPU version (bedpostx_gpu) strongly recommended. Required before probtrackx2. Outputs fiber orientations and uncertainty estimates.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `data_dir` | `Directory` | Yes | Input data directory (must contain data, bvals, bvecs, nodif_brain_mask) |  |
| `nfibres` | `int` | No | Number of fibres per voxel (default 3) | `-n` |
| `model` | `int` | No | Deconvolution model (1=monoexp, 2=multiexp, 3=zeppelin) | `-model` |
| `rician` | `boolean` | No | Use Rician noise modelling | `--rician` |

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `output_directory` | `Directory` | `$(inputs.data_dir.basename).bedpostX` |
| `merged_samples` | `File[]` | `$(inputs.data_dir.basename).bedpostX/merged_*samples.nii.gz` |
| `log` | `File` | `bedpostx.log` |

### Output Extensions

- **merged_samples**: `.nii.gz`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Diffusion MRI > FSL > Tractography
- Pipelines > FSL > Diffusion

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FDT/UserGuide#BEDPOSTX)
