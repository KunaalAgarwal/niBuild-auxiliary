# MRIQC: MRI Quality Control Pipeline

**Library:** MRIQC | **Docker Image:** `nipreps/mriqc`

## Function

Multi-step quality control pipeline. Internally chains brain extraction, spatial normalization, and computation of dozens of image quality metrics (SNR, CNR, EFC, FBER, motion) with visual report generation.

**Modality:** BIDS-formatted dataset containing T1w, T2w, and/or BOLD fMRI data (NIfTI format).

**Typical Use:** Automated quality assessment of MRI data before preprocessing.

## Key Parameters

<bids_dir> <output_dir> participant, --participant-label (subject IDs), --modalities (T1w, T2w, bold), --no-sub (skip submission to web API)

## Key Points

Requires BIDS-formatted input. Computes dozens of IQMs (SNR, CNR, EFC, FBER, motion metrics). Generates individual and group-level visual reports.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `bids_dir` | `Directory` | Yes | BIDS dataset directory |  |
| `output_dir` | `string` | Yes | Output directory |  |
| `analysis_level` | `string` | Yes | Analysis level (participant/group) |  |
| `participant_label` | `string` | No | Participant label (without sub- prefix) | `--participant-label` |
| `modalities` | `string` | No | Modalities to process (T1w/T2w/bold) | `--modalities` |
| `no_sub` | `boolean` | No | Disable submission of quality metrics | `--no-sub` |
| `nprocs` | `int` | No | Number of processors | `--nprocs` |
| `mem_gb` | `int` | No | Memory limit (GB) | `--mem-gb` |

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `output_directory` | `Directory` | `$(inputs.output_dir)` |
| `log` | `File` | `mriqc.log` |

## Docker Tags

Available versions: `latest`, `experimental`, `25.0.0rc0`, `24.0.2`, `24.0.1`, `24.0.0`, `24.0.0rc8`, `24.0.0rc7`, `24.0.0rc6`, `24.0.0rc5`
 and 5 more

## Categories

- Functional MRI > MRIQC > Pipeline
- Pipelines > MRIQC > Quality Control

## Documentation

[Official Documentation](https://mriqc.readthedocs.io/en/stable/)
