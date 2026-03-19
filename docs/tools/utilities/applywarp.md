# FSL Apply Warp Field (applywarp)

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Applies linear and/or non-linear warp fields to transform images between coordinate spaces.

**Modality:** 3D or 4D NIfTI volume plus warp field and/or affine matrix.

**Typical Use:** Applying normalization warps to functional data or atlas labels.

## Key Parameters

-i (input), -r (reference), -o (output), -w (warp field), --premat (pre-warp affine), --postmat (post-warp affine), --interp (interpolation)

## Key Points

Can chain affine + nonlinear transforms in one step. Use --interp=nn for label images, --interp=spline for continuous images. Reference defines output grid.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input image to be warped | `--in=` |
| `reference` | `File` | Yes | Reference image | `--ref=` |
| `output` | `string` | Yes | Output filename | `--out=` |
| `warp` | `File` | No | Warp field file | `--warp=` |
| `premat` | `File` | No | Pre-transform affine matrix (applied first) | `--premat=` |
| `postmat` | `File` | No | Post-transform affine matrix (applied last) | `--postmat=` |
| `relwarp` | `boolean` | No | Treat warp as relative (x' = x + w(x)) | `--rel` |
| `abswarp` | `boolean` | No | Treat warp as absolute (x' = w(x)) | `--abs` |
| `interp` | `enum` | No | Interpolation method | `--interp=` |
| `supersample` | `boolean` | No | Enable supersampling | `--super` |
| `superlevel` | `string` | No | Supersampling level (integer or 'a' for auto) | `--superlevel=` |
| `mask` | `File` | No | Mask in reference space | `--mask=` |
| `datatype` | `enum` | No | Output data type | `--datatype=` |
| `padding_size` | `int` | No | Padding size | `--paddingsize=` |
| `verbose` | `boolean` | No | Verbose output | `-v` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`
- **reference**: `.nii`, `.nii.gz`
- **warp**: `.nii`, `.nii.gz`
- **premat**: `.mat`
- **postmat**: `.mat`
- **mask**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `warped_image` | `File` | `$(inputs.output).nii.gz`, `$(inputs.output).nii` |
| `log` | `File` | `applywarp.log` |

### Output Extensions

- **warped_image**: `.nii`, `.nii.gz`

## Enum Options

**`interp`**: `nn`, `trilinear`, `sinc`, `spline`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Utilities > FSL > Warp Utilities

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FNIRT/UserGuide#Applying_the_warps)
