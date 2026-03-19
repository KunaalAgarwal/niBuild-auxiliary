# FSL Fieldmap Preparation

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Prepares a fieldmap for use with FUGUE by converting phase difference images to radians per second.

**Modality:** Phase difference image and magnitude image from gradient echo fieldmap acquisition.

**Typical Use:** Converting raw fieldmap images to FUGUE-compatible format for EPI distortion correction.

## Key Parameters

<scanner> <phase_image> <magnitude_image> <output_fieldmap> <delta_TE_ms>

## Key Points

Scanner type determines unwrapping method (SIEMENS most common). Delta TE is the echo time difference in milliseconds. Output is in rad/s for use with FUGUE.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `scanner` | `string` | Yes | Scanner type (e.g., SIEMENS) |  |
| `phase_image` | `File` | Yes | Phase difference image |  |
| `magnitude_image` | `File` | Yes | Brain-extracted magnitude image |  |
| `output` | `string` | Yes | Output fieldmap filename |  |
| `delta_TE` | `double` | Yes | Echo time difference in milliseconds |  |
| `nocheck` | `boolean` | No | Suppress sanity checking of image size/range/dimensions | `--nocheck` |

### Accepted Input Extensions

- **phase_image**: `.nii`, `.nii.gz`
- **magnitude_image**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `fieldmap` | `File` | `$(inputs.output).nii.gz`, `$(inputs.output).nii`, `$(inputs.output)` |
| `log` | `File` | `fsl_prepare_fieldmap.log` |
| `err_log` | `File` | `fsl_prepare_fieldmap.err.log` |

### Output Extensions

- **fieldmap**: `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Functional MRI > FSL > Distortion Correction

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FUGUE/Guide#SIEMENS_data)
