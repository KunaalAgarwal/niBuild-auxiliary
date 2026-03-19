# MRtrix3 DWI Denoising (MP-PCA)

**Library:** MRtrix3 | **Docker Image:** `mrtrix3/mrtrix3`

## Function

Removes thermal noise from diffusion MRI data using Marchenko-Pastur PCA exploiting data redundancy across diffusion directions.

**Modality:** 4D diffusion-weighted NIfTI with multiple diffusion directions (minimum ~30 recommended).

**Typical Use:** First step in DWI preprocessing to improve SNR.

## Key Parameters

<input> <output>, -noise (output noise map), -extent (spatial patch size, default 5,5,5), -mask (brain mask)

## Key Points

Should be run FIRST, before any other processing. Requires sufficient number of diffusion directions. Noise map useful for QC.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input DWI image |  |
| `output` | `string` | Yes | Output denoised image |  |
| `noise` | `string` | No | Output noise map filename | `-noise` |
| `extent` | `string` | No | Sliding window extent (e.g., 5,5,5) | `-extent` |
| `mask` | `File` | No | Processing mask | `-mask` |

### Accepted Input Extensions

- **input**: `.mif`, `.nii`, `.nii.gz`, `.mgh`, `.mgz`
- **mask**: `.mif`, `.nii`, `.nii.gz`, `.mgh`, `.mgz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `denoised` | `File` | `$(inputs.output)` |
| `noise_map` | `File` | `${
  if (inputs.noise) { return inputs.noise; }
  else { return "UNUSED_PLACEHOLDER_DO_NOT_MATCH"; }
}
` |
| `log` | `File` | `dwidenoise.log` |

### Output Extensions

- **denoised**: `.mif`, `.nii`, `.nii.gz`
- **noise_map**: `.mif`, `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `3.0.8`, `3.0.7`, `3.0.5`, `3.0.4`, `3.0.3`

## Categories

- Diffusion MRI > MRtrix3 > Preprocessing

## Documentation

[Official Documentation](https://mrtrix.readthedocs.io/en/latest/reference/commands/dwidenoise.html)
