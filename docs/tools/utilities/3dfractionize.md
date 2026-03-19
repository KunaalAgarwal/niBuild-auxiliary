# AFNI 3D Fractionize (ROI Resampling)

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Resamples ROI/atlas datasets using fractional occupancy to maintain region representation at different resolutions.

**Modality:** ROI/atlas volume (3D NIfTI/AFNI) plus template for target grid.

**Typical Use:** Resampling parcellations to functional resolution.

## Key Parameters

-template (target grid), -input (ROI dataset), -prefix (output), -clip (fraction threshold, default 0.5)

## Key Points

Better than nearest-neighbor for resampling parcellations. Preserves small ROIs better.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `template` | `File` | Yes | Template dataset defining output grid | `-template` |
| `input` | `File` | Yes | Input dataset to fractionize | `-input` |
| `prefix` | `string` | Yes | Output dataset prefix | `-prefix` |
| `clip` | `double` | No | Occupancy threshold (0-1 fraction, 1-100 percent, 100+ direct value) | `-clip` |
| `warp` | `File` | No | Transformation from +orig to input coordinates | `-warp` |
| `preserve` | `boolean` | No | Copy nonzero input values instead of creating fractional mask | `-preserve` |
| `vote` | `boolean` | No | Use voting mechanism (same as -preserve) | `-vote` |

### Accepted Input Extensions

- **template**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **input**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **warp**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `fractionized` | `File` | `$(inputs.prefix)+orig.HEAD`, `$(inputs.prefix)+tlrc.HEAD` |
| `log` | `File` | `$(inputs.prefix).log` |

### Output Extensions

- **fractionized**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Utilities > AFNI > ROI Utilities

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dfractionize.html)
