# ANTs SyN Registration with Defaults

**Library:** ANTs | **Docker Image:** `antsx/ants`

## Function

Symmetric normalization registration with sensible default parameters for common registration tasks.

**Modality:** Any 3D NIfTI volume pair.

**Typical Use:** Standard registration with good defaults for structural normalization.

## Key Parameters

-d (dimension), -f (fixed), -m (moving), -o (output prefix), -t (transform type: s=SyN, b=BSplineSyN, a=affine only)

## Key Points

Good defaults for most use cases. Outputs forward/inverse warps and affine. Preferred over raw antsRegistration for simplicity.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `dimensionality` | `int` | Yes | Image dimensionality (2 or 3) | `-d` |
| `fixed_image` | `File` | Yes | Fixed/reference image | `-f` |
| `moving_image` | `File` | Yes | Moving/target image to register | `-m` |
| `output_prefix` | `string` | Yes | Output prefix for transform files | `-o` |
| `transform_type` | `enum` | No | Transform type (t=translation, r=rigid, a=affine, s=SyN, b=b-spline SyN) | `-t` |
| `num_threads` | `int` | No | Number of threads | `-n` |
| `precision` | `enum` | No | Precision (f=float, d=double) | `-p` |
| `masks` | `string` | No | Mask images (fixedMask,movingMask) | `-x` |
| `initial_transform` | `File` | No | Initial transform | `-i` |
| `histogram_matching` | `boolean` | No | Use histogram matching | `-j` |
| `reproducible` | `boolean` | No | Enable reproducible mode with fixed random seed | `-y` |
| `collapse_transforms` | `boolean` | No | Collapse output transforms | `-z` |

### Accepted Input Extensions

- **fixed_image**: `.nii`, `.nii.gz`
- **moving_image**: `.nii`, `.nii.gz`
- **initial_transform**: `.mat`, `.h5`, `.nii.gz`, `.txt`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `warped_image` | `File` | `$(inputs.output_prefix)Warped.nii.gz` |
| `inverse_warped_image` | `File` | `$(inputs.output_prefix)InverseWarped.nii.gz` |
| `affine_transform` | `File` | `$(inputs.output_prefix)0GenericAffine.mat` |
| `warp_field` | `File` | `$(inputs.output_prefix)1Warp.nii.gz` |
| `inverse_warp_field` | `File` | `$(inputs.output_prefix)1InverseWarp.nii.gz` |
| `log` | `File` | `antsRegistrationSyN.log` |

### Output Extensions

- **warped_image**: `.nii.gz`
- **inverse_warped_image**: `.nii.gz`
- **affine_transform**: `.mat`
- **warp_field**: `.nii.gz`
- **inverse_warp_field**: `.nii.gz`

## Enum Options

**`transform_type`**: `t`, `r`, `a`, `s`, `sr`, `b`, `br`

## Docker Tags

Available versions: `latest`, `master`, `v2.6.5`, `2.6.5`, `v2.6.4`, `2.6.4`, `v2.6.3`, `2.6.3`, `v2.6.2`, `2.6.2`
 and 5 more

## Categories

- Structural MRI > ANTs > Registration

## Documentation

[Official Documentation](https://github.com/ANTsX/ANTs/wiki/Anatomy-of-an-antsRegistration-call)
