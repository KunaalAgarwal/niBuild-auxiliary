# fMRIPrep: Robust fMRI Preprocessing Pipeline

**Library:** fMRIPrep | **Docker Image:** `nipreps/fmriprep`

## Function

Automated, robust preprocessing pipeline for task-based and resting-state fMRI, combining tools from FSL, FreeSurfer, ANTs, and AFNI with best practices.

**Modality:** BIDS-formatted dataset containing T1w anatomical and BOLD fMRI data (NIfTI format).

**Typical Use:** Complete standardized fMRI preprocessing from BIDS data to analysis-ready outputs.

## Key Parameters

<bids_dir> <output_dir> participant, --participant-label (subject IDs), --output-spaces (target spaces), --fs-license-file (FreeSurfer license)

## Key Points

Requires BIDS-formatted input. Handles brain extraction, segmentation, registration, motion correction, distortion correction, and confound estimation. Generates comprehensive visual QC reports.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `bids_dir` | `Directory` | Yes | BIDS dataset directory |  |
| `output_dir` | `string` | Yes | Output directory |  |
| `analysis_level` | `string` | Yes | Analysis level (participant) |  |
| `participant_label` | `string` | No | Participant label (without sub- prefix) | `--participant-label` |
| `output_spaces` | `string` | No | Output spaces (e.g., MNI152NLin2009cAsym) | `--output-spaces` |
| `fs_license_file` | `File` | No | FreeSurfer license file | `--fs-license-file` |
| `nprocs` | `int` | No | Number of processors | `--nprocs` |
| `mem_mb` | `int` | No | Memory limit (MB) | `--mem-mb` |
| `skip_bids_validation` | `boolean` | No | Skip BIDS validation | `--skip-bids-validation` |

### Accepted Input Extensions

- **fs_license_file**: `.txt`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `output_directory` | `Directory` | `$(inputs.output_dir)` |
| `log` | `File` | `fmriprep.log` |

## Docker Tags

Available versions: `latest`, `unstable`, `25.2.4`, `premask`, `25.2.3`, `25.2.2`, `25.2.1`, `25.2.0`, `pre-release`, `25.1.4`
 and 5 more

## Categories

- Functional MRI > fMRIPrep > Pipeline
- Pipelines > fMRIPrep > fMRI Preprocessing

## Documentation

[Official Documentation](https://fmriprep.org/en/stable/)
