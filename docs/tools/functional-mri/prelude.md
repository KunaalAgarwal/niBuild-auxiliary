# FSL Phase Region Expanding Labeller for Unwrapping Discrete Estimates (PRELUDE)

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Performs 3D phase unwrapping on wrapped phase images using a region-growing algorithm.

**Modality:** Wrapped phase image (3D NIfTI) plus optional magnitude image for masking.

**Typical Use:** Unwrapping phase images before fieldmap calculation for distortion correction.

## Key Parameters

-p (wrapped phase), -a (magnitude for mask), -o (output unwrapped phase), -m (brain mask), -f (apply phase filter)

## Key Points

Essential preprocessing for fieldmap-based distortion correction. Magnitude image improves unwrapping quality. Can handle phase wraps > 2pi.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `phase` | `File` | Yes | Wrapped phase image | `-p` |
| `magnitude` | `File` | No | Magnitude image (for masking) | `-a` |
| `complex_input` | `File` | No | Complex input image (alternative to phase/magnitude pair) | `-c` |
| `output` | `string` | Yes | Output unwrapped phase image | `-o` |
| `mask` | `File` | No | Brain mask image | `-m` |
| `num_partitions` | `int` | No | Number of phase partitions for initial labeling | `-n` |
| `process2d` | `boolean` | No | Do 2D processing (slice by slice) | `-s` |
| `labelslices` | `boolean` | No | 2D labeling with 3D unwrapping | `--labelslices` |
| `force3d` | `boolean` | No | Force full 3D processing | `--force3D` |
| `removeramps` | `boolean` | No | Remove phase ramps during unwrapping | `--removeramps` |
| `savemask` | `string` | No | Save the generated mask volume | `--savemask=` |
| `verbose` | `boolean` | No | Verbose output | `-v` |

### Accepted Input Extensions

- **phase**: `.nii`, `.nii.gz`
- **magnitude**: `.nii`, `.nii.gz`
- **complex_input**: `.nii`, `.nii.gz`
- **mask**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `unwrapped_phase` | `File` | `$(inputs.output).nii.gz`, `$(inputs.output).nii`, `$(inputs.output)` |
| `saved_mask` | `File` | `$(inputs.savemask).nii.gz`, `$(inputs.savemask).nii` |
| `log` | `File` | `prelude.log` |
| `err_log` | `File` | `prelude.err.log` |

### Output Extensions

- **unwrapped_phase**: `.nii`, `.nii.gz`
- **saved_mask**: `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Functional MRI > FSL > Distortion Correction

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FUGUE/Guide#PRELUDE_.28phase_unwrapping.29)
