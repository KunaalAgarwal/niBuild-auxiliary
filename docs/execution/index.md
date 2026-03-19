# Workflow Execution

Each workflow exported from niBuild is a self-contained `.crate.zip` bundle with everything needed to run the pipeline on any machine.

## Bundle Contents

| File | Purpose |
|---|---|
| `workflows/<name>.cwl` | Main CWL workflow file |
| `workflows/<name>_job.yml` | Job file with pre-configured parameters |
| `cwl/` | Individual tool CWL definitions |
| `Dockerfile` | Recipe for building the Docker orchestration container |
| `run.sh` | Entrypoint script for Docker execution |
| `prefetch_images.sh` | Pre-pull tool Docker images (optional) |
| `Singularity.def` | Recipe for building the Singularity/Apptainer container |
| `run_singularity.sh` | Entrypoint script for Singularity execution |
| `prefetch_images_singularity.sh` | Convert Docker images to SIF files (optional) |
| `ro-crate-metadata.json` | [Workflow RO-Crate](https://w3id.org/workflowhub/workflow-ro-crate/1.0) metadata (JSON-LD) |
| `README.md` | Setup and execution instructions |

## Two-Layer Container Architecture

niBuild workflows use a **two-layer container architecture**:

1. **Tool containers** (e.g. `brainlife/fsl:6.0.5`) — Pre-built images hosted on Docker Hub containing neuroimaging software (FSL, AFNI, ANTs, FreeSurfer, etc.). Each CWL tool definition references its required container image. You do not build these yourself.

2. **Orchestration container** (built from `Dockerfile` or `Singularity.def`) — Contains [cwltool](https://github.com/common-workflow-language/cwltool), the CWL execution engine, along with your workflow and job files. When run, cwltool reads the CWL workflow and launches the appropriate tool containers to execute each processing step.

You can also skip the orchestration container entirely and run cwltool directly on your machine.

## Runtime File Inputs

Before running, you must edit the job file (`workflows/<name>_job.yml`) to supply paths to your actual data files. Scalar parameters (thresholds, flags, etc.) are already pre-configured from your niBuild settings.

File inputs are marked with comments showing the expected structure:

```yaml
input_image: null  # {class: File, path: <your/file/path>}
subject_list: []   # [{class: File, path: <your/file/path>}]
```

## Execution Options

| Method | Prerequisites | Best For |
|---|---|---|
| [Docker](docker.md) | Docker only | Local workstations, simplest setup |
| [cwltool Direct](cwltool-direct.md) | Python + cwltool + Docker | Development, debugging |
| [Singularity / HPC](singularity.md) | Singularity/Apptainer + cwltool | HPC clusters, shared environments |
| [BIDS Runtime](bids-runtime.md) | Python 3.6+ | Auto-resolving inputs from BIDS datasets |

## Key Concepts

| Term | Description |
|---|---|
| **Container image** | A packaged filesystem with an OS and software pre-installed — a "frozen environment" you can run anywhere |
| **Dockerfile / Singularity.def** | Text recipes for building container images. `docker build` and `singularity build` read these to produce images |
| **Volume mount** (`-v` / `--bind`) | Makes a directory on your host machine accessible inside the container |
| **cwltool** | The CWL execution engine — reads the workflow CWL and launches tool containers for each step |
| **Docker-in-Docker** | The orchestration container uses the Docker socket (`/var/run/docker.sock`) to launch tool containers |

## RO-Crate Metadata

Exported bundles conform to the [Workflow RO-Crate 1.0](https://w3id.org/workflowhub/workflow-ro-crate/1.0) profile. The `ro-crate-metadata.json` file describes all workflow components in JSON-LD format, enabling discovery and reuse through platforms like [WorkflowHub](https://workflowhub.eu/).

## Resources

- [CWL User Guide](https://www.commonwl.org/user_guide/)
- [cwltool Documentation](https://github.com/common-workflow-language/cwltool)
- [RO-Crate Specification](https://www.researchobject.org/ro-crate/)
