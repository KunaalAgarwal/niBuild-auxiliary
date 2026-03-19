# FMRIB's Integrated Registration and Segmentation Tool (FIRST)

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Multi-step pipeline for subcortical structure segmentation. Internally chains registration, boundary correction, and shape-model segmentation for 15 subcortical structures.

**Modality:** T1-weighted 3D NIfTI volume (does not need to be brain-extracted).

**Typical Use:** Volumetric analysis of subcortical structures (hippocampus, amygdala, caudate, etc.).

## Key Parameters

-i (input image), -o (output basename), -b (run BET first), -s (comma-separated structures list)

## Key Points

Models 15 subcortical structures. Outputs meshes (.vtk) and volumetric labels. Can run on selected structures only with -s flag.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input T1-weighted image | `-i` |
| `output` | `string` | Yes | Output basename | `-o` |
| `brain_extracted` | `boolean` | No | Input is already brain extracted | `-b` |
| `method` | `enum` | No | Boundary correction method | `-m` |
| `structures` | `string` | No | Run only on specified structures (comma-separated list) | `-s` |
| `affine` | `File` | No | Use this affine matrix for registration | `-a` |
| `three_stage` | `boolean` | No | Use 3-stage registration | `-3` |
| `verbose` | `boolean` | No | Verbose output | `-v` |
| `debug` | `boolean` | No | Debug mode (don't delete temporary files) | `-d` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`
- **affine**: `.mat`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `segmentation_files` | `File[]` | `$(inputs.output)_all_fast_firstseg.nii.gz`, `$(inputs.output)_all_fast_origsegs.nii.gz`, `$(inputs.output)-*_first.nii.gz` |
| `vtk_meshes` | `File[]` | `$(inputs.output)-*.vtk` |
| `bvars` | `File[]` | `$(inputs.output)-*.bvars` |
| `log` | `File` | `run_first_all.log` |

### Output Extensions

- **segmentation_files**: `.nii.gz`
- **vtk_meshes**: `.vtk`
- **bvars**: `.bvars`

## Enum Options

**`method`**: `auto`, `fast`, `none`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Structural MRI > FSL > Tissue Segmentation
- Pipelines > FSL > Structural

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FIRST)
