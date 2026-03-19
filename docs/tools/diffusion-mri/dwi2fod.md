# MRtrix3 Fiber Orientation Distribution Estimation

**Library:** MRtrix3 | **Docker Image:** `mrtrix3/mrtrix3`

## Function

Estimates fiber orientation distributions (FODs) using constrained spherical deconvolution to resolve crossing fibers.

**Modality:** 4D diffusion-weighted NIfTI with multi-shell or single-shell data, plus tissue response functions.

**Typical Use:** Estimating fiber orientations for subsequent tractography.

## Key Parameters

<algorithm> <input> <wm_response> <wm_fod> [<gm_response> <gm_fod>] [<csf_response> <csf_fod>], -mask (brain mask)

## Key Points

Use msmt_csd for multi-shell data (recommended), csd for single-shell. Response functions from dwi2response.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `algorithm` | `string` | Yes | FOD algorithm (csd/msmt_csd) |  |
| `input` | `File` | Yes | Input DWI image |  |
| `wm_response` | `File` | Yes | White matter response function |  |
| `wm_fod` | `string` | Yes | Output WM FOD image filename |  |
| `gm_response` | `File` | No | Grey matter response (required before CSF) |  |
| `gm_fod` | `string` | No | Output GM FOD filename (required before CSF) |  |
| `csf_response` | `File` | No | CSF response (requires GM inputs) |  |
| `csf_fod` | `string` | No | Output CSF FOD filename (requires GM inputs) |  |
| `mask` | `File` | No | Processing mask | `-mask` |

### Accepted Input Extensions

- **input**: `.mif`, `.nii`, `.nii.gz`, `.mgh`, `.mgz`
- **wm_response**: `.txt`
- **gm_response**: `.txt`
- **csf_response**: `.txt`
- **mask**: `.mif`, `.nii`, `.nii.gz`, `.mgh`, `.mgz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `wm_fod_image` | `File` | `$(inputs.wm_fod)` |
| `gm_fod_image` | `File` | `${
  if (inputs.gm_fod) { return inputs.gm_fod; }
  else { return "UNUSED_PLACEHOLDER_DO_NOT_MATCH"; }
}
` |
| `csf_fod_image` | `File` | `${
  if (inputs.csf_fod) { return inputs.csf_fod; }
  else { return "UNUSED_PLACEHOLDER_DO_NOT_MATCH"; }
}
` |
| `log` | `File` | `dwi2fod.log` |

### Output Extensions

- **wm_fod_image**: `.mif`, `.nii`, `.nii.gz`
- **gm_fod_image**: `.mif`, `.nii`, `.nii.gz`
- **csf_fod_image**: `.mif`, `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `3.0.8`, `3.0.7`, `3.0.5`, `3.0.4`, `3.0.3`

## Categories

- Diffusion MRI > MRtrix3 > Tensor/FOD

## Documentation

[Official Documentation](https://mrtrix.readthedocs.io/en/latest/reference/commands/dwi2fod.html)
