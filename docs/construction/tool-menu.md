# Tool Menu & Search

The left sidebar contains all available neuroimaging tools organized hierarchically: first by **imaging modality**, then by **software library**, then by **functional category**. The sidebar can be collapsed with the arrow button at the top to maximize canvas space. Collapse state persists across sessions.

1. Click a modality header to expand it and see the libraries within.
2. Expand a library to see individual tools grouped by category.
3. Hover over any tool to see a tooltip with its full name, function description, expected input, key parameters, and typical use case.
4. Double-click a tool in the menu to open its official documentation in a new tab.
5. Drag a tool from the menu and drop it onto the canvas to add it to your workflow.

## Imaging Modalities

Tools are organized into 7 imaging modalities:

- **Structural MRI** — T1/T2-weighted imaging for brain anatomy. Tools for skull-stripping, tissue segmentation, cortical reconstruction, and spatial registration.
- **Functional MRI** — BOLD-contrast imaging for brain activity. Tools for motion correction, slice timing, spatial smoothing, temporal filtering, and statistical modeling.
- **Diffusion MRI** — Diffusion-weighted imaging (DWI) for white matter microstructure. Tools for eddy current correction, tensor fitting, tractography, and connectivity analysis.
- **Arterial Spin Labeling (ASL)** — Non-invasive perfusion imaging using magnetically labeled blood. Tools for cerebral blood flow (CBF) quantification and partial volume correction.
- **PET** — Positron Emission Tomography for molecular imaging. Tools for kinetic modeling, partial volume correction, and tracer-specific quantification.
- **Multimodal** — Cross-modality analysis pipelines. Tools that integrate structural, functional, and diffusion data for comprehensive brain mapping.
- **Utilities** — General-purpose neuroimaging utilities for format conversion, image math, resampling, and quality control.

## Software Libraries

niBuild includes tools from 9 neuroimaging software libraries. Each library runs inside its own Docker container:

| Library | Docker Image | Description |
|---|---|---|
| **FSL** | `brainlife/fsl` | FMRIB Software Library. Comprehensive suite for structural, functional, and diffusion analysis. Includes BET, FLIRT, FAST, FEAT, MELODIC, FDT, TBSS, and more. |
| **AFNI** | `brainlife/afni` | Analysis of Functional NeuroImages. Extensive tools for functional MRI analysis including motion correction, denoising, smoothing, statistical modeling, and connectivity. |
| **FreeSurfer** | `freesurfer/freesurfer` | Cortical surface reconstruction and parcellation. Includes recon-all for automated cortical analysis, mri_convert for format conversion, and PET processing tools. |
| **ANTs** | `antsx/ants` | Advanced Normalization Tools. State-of-the-art image registration (SyN), segmentation (Atropos), cortical thickness (DiReCT), and bias correction (N4). |
| **MRtrix3** | `mrtrix3/mrtrix3` | Diffusion MRI analysis toolkit. Specializes in constrained spherical deconvolution (CSD), fiber orientation distribution (FOD) estimation, and anatomically-constrained tractography (ACT). |
| **Connectome Workbench** | `khanlab/connectome-workbench` | HCP Connectome tools for surface-based analysis. CIFTI file operations and surface data smoothing for cortical analysis. |
| **fMRIPrep** | `nipreps/fmriprep` | Robust, automated fMRI preprocessing pipeline. Produces analysis-ready BOLD data with comprehensive quality reports. |
| **MRIQC** | `nipreps/mriqc` | MRI Quality Control. Extracts image quality metrics (SNR, CNR, motion parameters) and generates visual quality reports. |
| **AMICO** | `cookpa/amico-noddi` | Accelerated Microstructure Imaging via Convex Optimization. Fits biophysical models (NODDI) to diffusion MRI data for neurite density and orientation dispersion. |

## Library Coverage by Modality

| Library | Structural | Functional | Diffusion | ASL | PET | Multimodal | Utilities |
|---|---|---|---|---|---|---|---|
| FSL | ✓ | ✓ | ✓ | ✓ | | | ✓ |
| AFNI | ✓ | ✓ | | | | | ✓ |
| FreeSurfer | ✓ | ✓ | ✓ | | ✓ | | ✓ |
| ANTs | ✓ | ✓ | | | | ✓ | ✓ |
| MRtrix3 | | | ✓ | | | | |
| Workbench | ✓ | ✓ | | | | | |
| fMRIPrep | | ✓ | | | | | |
| MRIQC | | ✓ | | | | | |
| AMICO | | | ✓ | | | | |

## Search

- Type in the search bar to filter tools by name, function description, or modality.
- Use modality prefix syntax for targeted filtering:
    - `Structural MRI/` — shows all structural MRI tools
    - `MRI/bet` — searches for "bet" within all MRI modalities
    - `Diffusion/` — shows all diffusion tools
- Custom workflows are also searchable by name or by the tools they contain.

## I/O Nodes

The "I/O" section at the top of the menu contains special nodes that define pipeline entry and exit points:

- **Workflow Input** — defines an input file or value that the user supplies when running the pipeline.
- **Workflow Output** — collects specific results as final pipeline outputs. Connect it to upstream nodes, then double-click to open the Output Configuration modal where you can select exactly which outputs to include.
- **BIDS Dataset** — imports files from a BIDS-compliant dataset directory (see [BIDS Integration](bids-integration.md)).
