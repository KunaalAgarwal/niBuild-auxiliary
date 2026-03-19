# BIDS Integration

[BIDS (Brain Imaging Data Structure)](https://bids-specification.readthedocs.io/) is a community standard for organizing neuroimaging datasets into a consistent directory hierarchy. niBuild can parse a BIDS dataset and automatically generate typed workflow inputs for your data files.

## BIDS Directory Structure

A BIDS dataset follows this hierarchy:

```
dataset/
├── dataset_description.json   # Required: dataset name, BIDS version
├── participants.tsv           # Subject demographics (age, sex, etc.)
├── sub-01/                    # Subject directory
│   ├── ses-pre/               # Session directory (optional)
│   │   ├── anat/              # Anatomical images
│   │   │   ├── sub-01_ses-pre_T1w.nii.gz
│   │   │   └── sub-01_ses-pre_T1w.json    # Sidecar metadata
│   │   ├── func/              # Functional images
│   │   │   ├── sub-01_ses-pre_task-rest_bold.nii.gz
│   │   │   ├── sub-01_ses-pre_task-rest_bold.json
│   │   │   └── sub-01_ses-pre_task-rest_events.tsv
│   │   ├── dwi/               # Diffusion images
│   │   │   ├── sub-01_ses-pre_dwi.nii.gz
│   │   │   ├── sub-01_ses-pre_dwi.bval
│   │   │   └── sub-01_ses-pre_dwi.bvec
│   │   └── fmap/              # Field maps
│   │       └── sub-01_ses-pre_phasediff.nii.gz
│   └── ses-post/
│       └── ...
└── sub-02/
    └── ...
```

## BIDS Naming Convention

BIDS filenames encode metadata as key-value entity pairs separated by underscores:

```
sub-01_ses-pre_task-rest_run-01_bold.nii.gz
```

Common BIDS entities:

- `sub` — Subject identifier (required)
- `ses` — Session identifier (e.g., pre/post intervention, timepoint)
- `task` — Task name for functional scans (e.g., rest, flanker, nback)
- `acq` — Acquisition parameters (e.g., resolution, sequence variant)
- `run` — Run index when a scan is repeated within a session
- `dir` — Phase-encoding direction (e.g., AP, PA) for field maps
- `echo` — Echo index for multi-echo sequences
- `rec` — Reconstruction method
- `space` — Reference space (e.g., MNI152NLin2009cAsym)

## Data Types

Each subject directory contains subdirectories for different imaging data types:

- `anat` — Structural imaging (T1-weighted, T2-weighted, FLAIR, proton density, etc.)
- `func` — Task-based and resting-state functional MRI (BOLD signal)
- `dwi` — Diffusion-weighted imaging for white matter tractography
- `fmap` — Field maps for distortion correction (magnitude, phase difference, EPI)
- `perf` — Perfusion imaging (arterial spin labeling, M0 calibration scans)
- `pet` — Positron emission tomography
- `meg` / `eeg` / `ieeg` — Magneto/electroencephalography recordings

## Common Suffixes

The suffix at the end of a BIDS filename (before the extension) identifies the image type:

| Suffix | Data Type | Description |
|---|---|---|
| `T1w` | anat | T1-weighted structural image |
| `T2w` | anat | T2-weighted structural image |
| `FLAIR` | anat | Fluid-attenuated inversion recovery |
| `bold` | func | Blood oxygen level dependent (fMRI timeseries) |
| `sbref` | func | Single-band reference image |
| `dwi` | dwi | Diffusion-weighted image |
| `phasediff` | fmap | Phase difference map for B0 unwarping |
| `magnitude1` | fmap | First magnitude image for field mapping |
| `epi` | fmap | EPI-based field map (e.g., reverse phase-encode) |
| `asl` | perf | Arterial spin labeling perfusion image |
| `T1map` | anat | Quantitative T1 relaxation time map |

## File Formats

- `.nii.gz` / `.nii` — NIfTI image data (the primary neuroimaging format)
- `.json` — Sidecar metadata (acquisition parameters like TR, TE, flip angle)
- `.tsv` — Tab-separated values (event timing files, participant demographics)
- `.bval` / `.bvec` — Diffusion gradient tables (b-values and b-vectors)

## Using BIDS in niBuild

1. Expand the "I/O" section in the tool menu and drag **BIDS Dataset** onto the canvas.
2. A modal opens prompting you to select a BIDS-compliant directory from your local filesystem.
3. niBuild parses the directory structure client-side, detecting subjects, sessions, data types, and file suffixes.
4. Use the **subject panel** to select or deselect individual subjects (with Select All / Deselect All buttons). You can search subjects by ID or demographics.
5. Enable or disable **data types** (e.g., anat, func, dwi) in the data type grid. Unavailable data types are grayed out.
6. Configure **output groups**: each group specifies a data type, suffix, and optional filters (task, run, acquisition). Each group becomes an output port on the BIDS node.
7. Connect BIDS output ports to downstream tool inputs just like any other edge connection.

!!! note
    All file parsing happens in your browser — no data is uploaded to any server. The path preview shows exactly which files match your selections. BIDS outputs are always arrays (one file per subject), so scatter is enabled automatically on downstream nodes.

## BIDS Directory Output

In addition to the per-subject file outputs, every BIDS node exposes a **bids_directory** output of type `Directory`. This provides the full dataset root path for tools that accept a BIDS directory as input (e.g., fMRIPrep's `bids_dir`, MRIQC's `bids_dir`).

Unlike the file-array outputs, the `bids_directory` output does **not** carry scatter — it provides the single dataset root directory regardless of how many subjects are selected.
