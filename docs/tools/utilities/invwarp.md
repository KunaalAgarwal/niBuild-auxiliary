# FSL Invert Warp Field (invwarp)

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Computes the inverse of a non-linear warp field for reverse transformations.

**Modality:** Non-linear warp field (4D NIfTI from FNIRT --cout output).

**Typical Use:** Creating inverse transformations for atlas-to-native space mapping.

## Key Parameters

-w (input warp), -o (output inverse warp), -r (reference image for output space)

## Key Points

Needed to map atlas/standard-space ROIs back to native space. Reference should be the image that was originally warped.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `warp` | `File` | Yes | Warp field to invert | `--warp=` |
| `reference` | `File` | Yes | Reference image in target space | `--ref=` |
| `output` | `string` | Yes | Output inverted warp filename | `--out=` |
| `relative` | `boolean` | No | Treat warp as relative displacements | `--rel` |
| `absolute` | `boolean` | No | Treat warp as absolute coordinates | `--abs` |
| `noconstraint` | `boolean` | No | Disable Jacobian constraint | `--noconstraint` |
| `jacobian_min` | `double` | No | Minimum Jacobian (default 0.01) | `--jmin=` |
| `jacobian_max` | `double` | No | Maximum Jacobian (default 100.0) | `--jmax=` |
| `niter` | `int` | No | Number of gradient descent iterations | `--niter=` |
| `regularise` | `double` | No | Regularization strength (default 1.0) | `--regularise=` |
| `verbose` | `boolean` | No | Verbose output | `--verbose` |
| `debug` | `boolean` | No | Debug mode | `--debug` |

### Accepted Input Extensions

- **warp**: `.nii`, `.nii.gz`
- **reference**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `inverse_warp` | `File` | `$(inputs.output).nii.gz`, `$(inputs.output).nii` |
| `log` | `File` | `invwarp.log` |

### Output Extensions

- **inverse_warp**: `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Utilities > FSL > Warp Utilities

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FNIRT/UserGuide#Inverting_warps)
