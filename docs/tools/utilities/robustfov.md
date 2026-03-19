# FSL Robust Field of View Reduction

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Automatically identifies and removes neck/non-brain tissue by estimating the brain center and reducing the field of view to a standard size.

**Modality:** T1-weighted 3D NIfTI volume (full head coverage).

**Typical Use:** Preprocessing step before brain extraction to remove neck and improve BET robustness.

## Key Parameters

-i (input), -r (output ROI volume), -m (output transformation matrix), -b (brain size estimate in mm, default 170)

## Key Points

Useful for images with extensive neck coverage. Run before BET for more robust brain extraction. Does not resample, just crops.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input image (full head coverage) | `-i` |
| `output` | `string` | Yes | Output cropped image filename | `-r` |
| `matrix_output` | `string` | No | Output transformation matrix filename | `-m` |
| `brain_size` | `int` | No | Brain size estimate in mm (default 170) | `-b` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `cropped_image` | `File` | `$(inputs.output).nii.gz`, `$(inputs.output).nii`, `$(inputs.output)` |
| `transform_matrix` | `File` | `$(inputs.matrix_output)` |
| `log` | `File` | `robustfov.log` |
| `err_log` | `File` | `robustfov.err.log` |

### Output Extensions

- **cropped_image**: `.nii`, `.nii.gz`
- **transform_matrix**: `.mat`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Utilities > FSL > Volume Operations

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/fsl_anat)
