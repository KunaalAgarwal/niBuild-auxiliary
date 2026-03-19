# Workspaces & Export

## Workspaces

- Each workspace is an independent canvas with its own nodes and edges.
- Create a new workspace with **New Workspace**, clear the current one with **Clear Workspace**, or remove it with **Remove Workspace**.
- Navigate between workspaces using the page tabs at the bottom of the screen.
- Workspace state is automatically saved in your browser storage.

## Output Name

Set the exported filename using the **Output** input field in the toolbar. This name is used for the CWL workflow file and the downloaded bundle.

## Generate Workflow

Click **Generate Workflow** to download a `.crate.zip` bundle containing everything needed to run your pipeline:

- `workflows/pipeline.cwl` — CWL workflow definition
- `workflows/pipeline_job.yml` — job template pre-filled with your configured parameter values
- `cwl/` — individual tool CWL files with pinned Docker image versions
- `Dockerfile` + `run.sh` — one-command execution via Docker
- `Singularity.def` + `run_singularity.sh` — for HPC environments using Singularity/Apptainer
- `prefetch_images.sh` — pre-pull all required container images
- `ro-crate-metadata.json` — JSON-LD metadata for FAIR compliance and [WorkflowHub](https://workflowhub.eu/) discovery
- `README.md` — setup and execution instructions

!!! tip
    The exported bundle is a [CWL v1.2](https://www.commonwl.org/v1.2/) Workflow RO-Crate. Run it with any CWL-compliant engine (e.g., cwltool, Toil) or use the included Docker/Singularity scripts.
