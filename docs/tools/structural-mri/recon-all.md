# FreeSurfer Complete Cortical Reconstruction Pipeline

**Library:** FreeSurfer | **Docker Image:** `freesurfer/freesurfer`

## Function

Fully automated pipeline for cortical surface reconstruction and parcellation, including skull stripping, segmentation, surface tessellation, topology correction, inflation, registration, and parcellation.

**Modality:** T1-weighted 3D NIfTI or DICOM. Optional T2w or FLAIR for pial surface refinement.

**Typical Use:** Complete cortical reconstruction for surface-based morphometry, parcellation-based analysis, and as prerequisite for fMRI surface analysis.

## Key Parameters

-s (subject ID), -i (input T1w), -T2 (T2w image for pial), -FLAIR (FLAIR for pial), -all (run full pipeline), -autorecon1/-autorecon2/-autorecon3 (run specific stages)

## Key Points

Runtime 6-24 hours per subject. Creates cortical surfaces (white, pial), parcellations (Desikan-Killiany, Destrieux), subcortical segmentation (aseg), and morphometric measures. Use -T2pial or -FLAIRpial for improved pial surface placement.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `subjects_dir` | `Directory` | Yes | FreeSurfer subjects directory |  |
| `fs_license` | `File` | Yes | FreeSurfer license file |  |
| `subject_id` | `string` | Yes | Subject identifier | `-s` |
| `input_t1` | `File` | Yes | Input T1-weighted image | `-i` |
| `run_all` | `boolean` | No | Run full pipeline (autorecon1 + autorecon2 + autorecon3) | `-all` |
| `autorecon1` | `boolean` | No | Run autorecon1 (motion correction, skull stripping, Talairach) | `-autorecon1` |
| `autorecon2` | `boolean` | No | Run autorecon2 (segmentation, surface generation, topology fix) | `-autorecon2` |
| `autorecon3` | `boolean` | No | Run autorecon3 (parcellation, statistics, cortical thickness) | `-autorecon3` |
| `t2_image` | `File` | No | T2-weighted image for pial surface refinement | `-T2` |
| `flair_image` | `File` | No | FLAIR image for pial surface refinement | `-FLAIR` |
| `t2pial` | `boolean` | No | Use T2 image for pial surface placement | `-T2pial` |
| `flair_pial` | `boolean` | No | Use FLAIR image for pial surface placement | `-FLAIRpial` |
| `openmp` | `int` | No | Number of OpenMP threads | `-openmp` |
| `parallel` | `boolean` | No | Enable parallel processing where possible | `-parallel` |

### Accepted Input Extensions

- **input_t1**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`
- **t2_image**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`
- **flair_image**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `subjects_output_dir` | `Directory` | `$(inputs.subject_id)` |
| `log` | `File` | `recon-all.log` |
| `err_log` | `File` | `recon-all.err.log` |

## Docker Tags

Available versions: `latest`, `8.1.0`, `8.0.0`, `7.2.0`, `7.3.0`, `7.3.1`, `7.3.2`, `7.4.1`, `7.1.1`, `6.0`

## Categories

- Structural MRI > FreeSurfer > Surface Reconstruction
- Pipelines > FreeSurfer > Surface Reconstruction

## Documentation

[Official Documentation](https://surfer.nmr.mgh.harvard.edu/fswiki/recon-all)
