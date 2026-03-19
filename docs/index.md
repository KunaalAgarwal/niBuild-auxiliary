# niBuild

**A no-code, browser-based GUI for building reproducible neuroimaging analysis workflows.**

Neuroimaging analysis suffers from a reproducibility crisis. The same dataset analyzed by different teams produces divergent results due to software versions, parameter choices, and undocumented processing steps. Manual pipeline scripting is error-prone, hard to share, and rarely portable across computing environments.

niBuild addresses this by providing a visual workflow builder where researchers design analysis pipelines from **155+ neuroimaging tools across 11 libraries**, then export a self-contained [Workflow RO-Crate](https://w3id.org/workflowhub/workflow-ro-crate/1.0) bundle with [CWL](https://www.commonwl.org/) workflows, Docker/Singularity containers, and FAIR-compliant metadata — all without installing anything.

[Launch niBuild](https://kunaalagarwal.github.io/niBuild/){ .md-button .md-button--primary }
[View on GitHub](https://github.com/KunaalAgarwal/niBuild){ .md-button }

---

## What You Can Do

- **Design workflows visually** — Drag tools onto a canvas, configure parameters, and connect processing steps
- **Browse 155+ tools** — From FSL, AFNI, FreeSurfer, ANTs, MRtrix3, Connectome Workbench, fMRIPrep, MRIQC, AMICO, and more
- **Import BIDS datasets** — Browse and select subjects, sessions, and datatypes from BIDS-formatted data
- **Export portable bundles** — Generate a `.crate.zip` with everything needed to run the workflow on any machine

## Export Bundle

Clicking **Export** generates a `.crate.zip` containing:

```
my_pipeline.crate.zip/
├── workflows/my_pipeline.cwl          # CWL workflow definition
├── workflows/my_pipeline_job.yml      # Pre-configured job template
├── cwl/                               # Tool CWL files (with pinned Docker versions)
├── Dockerfile                         # Docker orchestration container
├── run.sh                             # Docker execution entrypoint
├── prefetch_images.sh                 # Pre-pull tool images
├── Singularity.def                    # Singularity/Apptainer container
├── run_singularity.sh                 # HPC execution entrypoint
├── prefetch_images_singularity.sh     # Convert images to SIF format
├── ro-crate-metadata.json             # JSON-LD metadata (FAIR compliance)
└── README.md                          # Execution instructions
```

## Getting Started

<div class="grid cards" markdown>

-   **Workflow Construction**

    ---

    Learn how to build analysis pipelines using the visual canvas.

    [:octicons-arrow-right-24: User Guide](construction/index.md)

-   **Workflow Execution**

    ---

    Run your exported workflows with Docker, Singularity, or cwltool.

    [:octicons-arrow-right-24: Execution Guide](execution/index.md)

-   **Tool Library**

    ---

    Browse all 155+ neuroimaging tools organized by imaging modality.

    [:octicons-arrow-right-24: Tool Reference](tools/index.md)

-   **Developer Documentation**

    ---

    Contribute to niBuild — add tools, extend libraries, or improve the codebase.

    [:octicons-arrow-right-24: Developer Guide](developer/index.md)

</div>

## Citation

niBuild was created by **Kunaal Agarwal** and **Javier Rasero, PhD**, under the funding of the **University of Virginia Harrison Research Award**.

!!! note "Publication forthcoming"
    If you use niBuild in your research, please cite the [GitHub repository](https://github.com/KunaalAgarwal/niBuild).
