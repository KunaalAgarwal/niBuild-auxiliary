# Brain Extraction Tool (BET)

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Removes non-brain tissue from MRI images using a deformable surface model that iteratively fits to the brain boundary.

**Modality:** T1-weighted structural image (3D NIfTI). Can also process 4D fMRI with -F flag.

**Typical Use:** First step in structural or functional preprocessing to isolate brain tissue.

## Key Parameters

-f (fractional intensity 0→1, default 0.5), -g (vertical gradient), -R (robust mode), -m (output binary mask)

## Key Points

Default threshold works for most T1s. Use -R for noisy/difficult data. Lower -f (~0.3) for functional images.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input T1-weighted image |  |
| `output` | `string` | Yes | Output filename |  |
| `overlay` | `boolean` | No | Generate brain outline image | `-o` |
| `mask` | `boolean` | No | Generate binary brain mask image | `-m` |
| `skull` | `boolean` | No | Generate skull-stripped image | `-s` |
| `ngenerate` | `boolean` | No | Do not generate the default output | `-n` |
| `frac` | `double` | No | Fractional intensity threshold | `-f` |
| `vert_frac` | `double` | No | Vertical gradient in fractional intensity | `-g` |
| `radius` | `double` | No | Radius of the brain centre in mm | `-r` |
| `cog` | `string` | No | Center of gravity vox coordinates | `-c` |
| `threshold` | `boolean` | No | Use thresholding to estimate the brain centre | `-t` |
| `mesh` | `boolean` | No | Generate a mesh of the brain surface | `-e` |
| `exclusive` | `record(robust) | record(eye) | record(bias) | record(fov) | record(fmri) | record(betsurf) | record(betsurfT2)` | No |  |  |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `brain_extraction` | `File` | `$(inputs.output).nii`, `$(inputs.output).nii.gz` |
| `brain_mask` | `File` | `$(inputs.output)_mask.nii.gz`, `$(inputs.output)_mask.nii` |
| `brain_skull` | `File` | `$(inputs.output)_skull.nii.gz`, `$(inputs.output)_skull.nii` |
| `brain_mesh` | `File` | `$(inputs.output)_mesh.vtk` |
| `brain_registration` | `File[]` | `$(inputs.output)_inskull_*.*`, `$(inputs.output)_outskin_*.*`, `$(inputs.output)_outskull_*.*`, `$(inputs.output)_skull_mask.*` |
| `log` | `File` | `$(inputs.output).log` |

### Output Extensions

- **brain_extraction**: `.nii`, `.nii.gz`
- **brain_mask**: `.nii`, `.nii.gz`
- **brain_skull**: `.nii`, `.nii.gz`
- **brain_mesh**: `.vtk`
- **brain_registration**: `.nii`, `.nii.gz`

## Parameter Bounds

| Parameter | Min | Max |
|---|---|---|
| `frac` | 0 | 1 |
| `vert_frac` | -1 | 1 |

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Structural MRI > FSL > Brain Extraction

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/BET)
