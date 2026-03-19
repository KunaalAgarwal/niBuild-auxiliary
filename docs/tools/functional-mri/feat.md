# FMRI Expert Analysis Tool (FEAT)

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Complete fMRI analysis pipeline combining preprocessing (motion correction, spatial smoothing, temporal filtering), first-level statistical modeling (GLM with autocorrelation correction), and higher-level group analysis.

**Modality:** FEAT design file (.fsf) encoding all analysis parameters including input data paths, preprocessing options, design matrix, and contrasts.

**Typical Use:** Complete first-level or higher-level fMRI analysis when all parameters are pre-configured in an FSF file.

## Key Parameters

design_file (.fsf file with all configuration), input_data (4D BOLD data referenced by the .fsf)

## Key Points

Pipeline controlled by the .fsf file. input_data must be provided separately for containerized execution (paths are rewritten at runtime). Internally runs BET, MCFLIRT, spatial smoothing, film_gls (with --con for contrast computation), registration, and optionally higher-level analysis. Outputs a .feat directory.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `design_file` | `File` | Yes | FEAT design file (.fsf) containing all analysis parameters |  |
| `input_data` | `File` | Yes | 4D BOLD input data referenced by the design file |  |

### Accepted Input Extensions

- **design_file**: `.fsf`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `feat_directory` | `Directory` | `*.feat` |
| `log` | `File` | `feat.log` |

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Functional MRI > FSL > Pipelines
- Pipelines > FSL > Functional

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FEAT)
