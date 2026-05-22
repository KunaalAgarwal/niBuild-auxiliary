# Tool Library

niBuild includes **155 neuroimaging tools** from 11 software libraries, organized by imaging modality. Every tool is a CWL command-line tool backed by a versioned Docker image.

## Modalities

| Modality | Description |
|---|---|
| [Structural MRI](structural-mri/index.md) | T1/T2-weighted anatomy — skull-stripping, tissue segmentation, cortical reconstruction, registration. |
| [Functional MRI](functional-mri/index.md) | Task and resting-state fMRI — motion correction, slice timing, smoothing, filtering, GLM, ICA. |
| [Diffusion MRI](diffusion-mri/index.md) | DWI/DTI — tensor fitting, tractography, fiber orientation, connectivity. |
| [Arterial Spin Labeling](arterial-spin-labeling/index.md) | Perfusion imaging — cerebral blood flow quantification and partial volume correction. |
| [PET](pet/index.md) | Positron emission tomography — kinetic modeling and partial volume correction. |
| [Multimodal](multimodal/index.md) | Cross-modality pipelines integrating structural, functional, and diffusion data. |
| [Utilities](utilities/index.md) | Format conversion, image math, resampling, and quality control. |
| [Pipelines](pipelines/index.md) | Complete multi-step pipelines that chain several operations as one command. |

## Libraries

| Library | Tools | Docker Image |
|---|---|---|
| FSL | 51 | `brainlife/fsl` |
| AFNI | 47 | `brainlife/afni` |
| FreeSurfer | 22 | `freesurfer/freesurfer` |
| ANTs | 17 | `antsx/ants` |
| MRtrix3 | 8 | `mrtrix3/mrtrix3` |
| Connectome Workbench | 5 | `khanlab/connectome-workbench` |
| fMRIPrep | 1 | `nipreps/fmriprep` |
| MRIQC | 1 | `nipreps/mriqc` |
| AMICO | 1 | `cookpa/amico-noddi` |
| dcm2niix | 1 | `xnat/dcm2niix` |
| ICA-AROMA | 1 | `rtrhd/ica-aroma` |
