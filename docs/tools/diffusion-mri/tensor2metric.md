# MRtrix3 Tensor Metric Extraction

**Library:** MRtrix3 | **Docker Image:** `mrtrix3/mrtrix3`

## Function

Extracts scalar metrics (FA, MD, AD, RD, eigenvalues, eigenvectors) from a fitted diffusion tensor image.

**Modality:** Diffusion tensor image (4D NIfTI from dwi2tensor).

**Typical Use:** Generating FA, MD, and other scalar diffusion maps from tensor.

## Key Parameters

<input>, -fa (output FA map), -adc (output MD map), -ad (output AD), -rd (output RD), -vector (output eigenvectors)

## Key Points

Multiple outputs can be generated in a single run. FA range 0-1. Specify each desired output explicitly.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input tensor image |  |
| `fa` | `string` | No | Output FA map filename | `-fa` |
| `adc` | `string` | No | Output mean diffusivity (ADC) map filename | `-adc` |
| `ad` | `string` | No | Output axial diffusivity map filename | `-ad` |
| `rd` | `string` | No | Output radial diffusivity map filename | `-rd` |
| `vector` | `string` | No | Output eigenvector map filename | `-vector` |
| `value` | `string` | No | Output eigenvalue map filename | `-value` |
| `mask` | `File` | No | Processing mask | `-mask` |

### Accepted Input Extensions

- **input**: `.mif`, `.nii`, `.nii.gz`, `.mgh`, `.mgz`
- **mask**: `.mif`, `.nii`, `.nii.gz`, `.mgh`, `.mgz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `fa_map` | `File` | `${
  if (inputs.fa) { return inputs.fa; }
  else { return "UNUSED_PLACEHOLDER_DO_NOT_MATCH"; }
}
` |
| `md_map` | `File` | `${
  if (inputs.adc) { return inputs.adc; }
  else { return "UNUSED_PLACEHOLDER_DO_NOT_MATCH"; }
}
` |
| `ad_map` | `File` | `${
  if (inputs.ad) { return inputs.ad; }
  else { return "UNUSED_PLACEHOLDER_DO_NOT_MATCH"; }
}
` |
| `rd_map` | `File` | `${
  if (inputs.rd) { return inputs.rd; }
  else { return "UNUSED_PLACEHOLDER_DO_NOT_MATCH"; }
}
` |
| `log` | `File` | `tensor2metric.log` |

### Output Extensions

- **fa_map**: `.mif`, `.nii`, `.nii.gz`
- **md_map**: `.mif`, `.nii`, `.nii.gz`
- **ad_map**: `.mif`, `.nii`, `.nii.gz`
- **rd_map**: `.mif`, `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `3.0.8`, `3.0.7`, `3.0.5`, `3.0.4`, `3.0.3`

## Categories

- Diffusion MRI > MRtrix3 > Tensor/FOD

## Documentation

[Official Documentation](https://mrtrix.readthedocs.io/en/latest/reference/commands/tensor2metric.html)
