# FSL Convert/Combine Warps (convertwarp)

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Combines multiple warp fields and affine matrices into a single composite warp for efficient one-step transformation.

**Modality:** Warp fields and/or affine matrices from FLIRT/FNIRT.

**Typical Use:** Concatenating multiple transformations (e.g., func > struct > standard) efficiently.

## Key Parameters

-r (reference), -o (output), --premat (first affine), --warp1 (first warp), --midmat (middle affine), --warp2 (second warp), --postmat (final affine)

## Key Points

Applying one combined warp is faster and has less interpolation error than chaining multiple transformations. Transform order: premat > warp1 > midmat > warp2 > postmat.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `reference` | `File` | Yes | Reference image in target space | `--ref=` |
| `output` | `string` | Yes | Output warp filename | `--out=` |
| `warp1` | `File` | No | First warp field | `--warp1=` |
| `warp2` | `File` | No | Second warp field (applied after warp1) | `--warp2=` |
| `premat` | `File` | No | Pre-transform affine matrix (applied first) | `--premat=` |
| `midmat` | `File` | No | Mid-warp affine transform | `--midmat=` |
| `postmat` | `File` | No | Post-transform affine matrix (applied last) | `--postmat=` |
| `shiftmap` | `File` | No | Shift map (fieldmap) file | `--shiftmap=` |
| `shiftdir` | `enum` | No | Shift direction | `--shiftdir=` |
| `abswarp` | `boolean` | No | Treat input warps as absolute | `--absout` |
| `relwarp` | `boolean` | No | Treat input warps as relative | `--relout` |
| `out_abswarp` | `boolean` | No | Output warp as absolute | `--absout` |
| `out_relwarp` | `boolean` | No | Output warp as relative | `--relout` |
| `cons_jacobian` | `boolean` | No | Constrain Jacobian | `--constrainj` |
| `jacobian_min` | `double` | No | Minimum Jacobian | `--jmin=` |
| `jacobian_max` | `double` | No | Maximum Jacobian | `--jmax=` |
| `verbose` | `boolean` | No | Verbose output | `--verbose` |

### Accepted Input Extensions

- **reference**: `.nii`, `.nii.gz`
- **warp1**: `.nii`, `.nii.gz`
- **warp2**: `.nii`, `.nii.gz`
- **premat**: `.mat`
- **midmat**: `.mat`
- **postmat**: `.mat`
- **shiftmap**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `combined_warp` | `File` | `$(inputs.output).nii.gz`, `$(inputs.output).nii` |
| `log` | `File` | `convertwarp.log` |

### Output Extensions

- **combined_warp**: `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Utilities > FSL > Warp Utilities

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FNIRT/UserGuide#Combining_warps)
