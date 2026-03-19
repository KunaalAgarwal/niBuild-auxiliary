# Tool Library

niBuild includes **155+ neuroimaging tools** from 11 software libraries, organized by imaging modality. Browse the categories below to find tools for your analysis pipeline.

## Modalities

| Modality | Description |
|---|---|
| [Structural MRI](structural-mri/index.md) | T1/T2-weighted imaging for brain anatomy. Skull-stripping, tissue segmentation, cortical reconstruction, and spatial registration. |
| [Functional MRI](functional-mri/index.md) | Task-based and resting-state fMRI. Motion correction, slice timing, smoothing, temporal filtering, GLM, and ICA. |
| [Diffusion MRI](diffusion-mri/index.md) | DWI/DTI processing. Tensor fitting, tractography, fiber orientation estimation, and connectivity analysis. |
| [Arterial Spin Labeling](arterial-spin-labeling/index.md) | Non-invasive perfusion imaging. Cerebral blood flow quantification and partial volume correction. |
| [PET](pet/index.md) | Positron Emission Tomography. Kinetic modeling, partial volume correction, and tracer quantification. |
| [Multimodal](multimodal/index.md) | Cross-modality analysis pipelines integrating structural, functional, and diffusion data. |
| [Utilities](utilities/index.md) | General-purpose tools for format conversion, image math, resampling, and quality control. |
| [Pipelines](pipelines/index.md) | Complete multi-step analysis pipelines that chain several operations as a single command. |

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
