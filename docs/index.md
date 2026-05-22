# niBuild

niBuild is a browser-based visual editor for neuroimaging analysis workflows. Drag tools onto a canvas, wire them into a pipeline, and export a self-contained bundle — a CWL workflow, container definitions, and FAIR metadata — that runs unchanged on any machine with Docker or Singularity.

## Why niBuild

Neuroimaging analysis rarely follows a standardized, shareable workflow. The result is irreproducible findings, opacity in the literature, and the persistence of esoteric, hard-to-audit analysis practices. niBuild makes workflows explicit, portable, and reproducible by construction:

- **No-code construction** — assemble multi-modal preprocessing and analysis pipelines visually, with no scripting.
- **Standardized tools** — every operation is a [CWL](https://www.commonwl.org/v1.2/) command-line tool pinned to a versioned Docker image, so a workflow runs identically anywhere.
- **FAIR by default** — exports are [Workflow RO-Crates](https://w3id.org/workflowhub/workflow-ro-crate/1.0), ready to share, cite, and publish to [WorkflowHub](https://workflowhub.eu/).
- **155 tools** spanning structural, functional, diffusion, ASL, and PET imaging — FSL, AFNI, FreeSurfer, ANTs, MRtrix3, and more.

niBuild runs entirely in the browser. No installation, and your data never leaves your machine.

## Where to go next

| Section | What it covers |
|---|---|
| [Using niBuild](construction/index.md) | Build, configure, and export a workflow |
| [Execution & Output](execution/index.md) | Run an exported bundle with Docker, Singularity, or cwltool |
| [Tool Library](tools/index.md) | The 155 available tools, by modality |
| [Examples & Tutorials](tutorials/index.md) | Complete analyses — task fMRI and VBM |
| [Developer](developer/index.md) | Run niBuild locally and add new tools |

## Project links

- [niBuild repository](https://github.com/KunaalAgarwal/niBuild)
- [Poster — UVA Brain Symposium](https://github.com/KunaalAgarwal/works/blob/main/Agarwal_niBuild_UVA_Brain_Symposium.pdf)
