# Execution & Output

Every workflow you export from niBuild is a self-contained `.crate.zip` bundle — everything needed to run the pipeline on any machine, with niBuild no longer involved.

## What's in the bundle

| File | Purpose |
|---|---|
| `workflows/<name>.cwl` | The CWL workflow |
| `workflows/<name>_job.yml` | Job template, pre-filled with your parameter values |
| `cwl/<library>/<tool>.cwl` | Individual tool definitions, with pinned Docker versions |
| `Dockerfile` + `run.sh` | One-command execution via Docker |
| `Singularity.def` + `run_singularity.sh` | Execution on HPC with Singularity / Apptainer |
| `prefetch_images*.sh` | Optional — pre-pull tool images (Docker) or convert them to SIF (Singularity) |
| `additional_inputs/` | Bundled Standard Template files (MNI152, fsaverage, atlases) |
| `bids_query.json` + `resolve_bids.py` | BIDS path resolver — present only when the workflow has a BIDS node |
| `ro-crate-metadata.json` | FAIR metadata (JSON-LD), conforming to the [Workflow RO-Crate](https://w3id.org/workflowhub/workflow-ro-crate/1.0) profile for sharing on [WorkflowHub](https://workflowhub.eu/) |
| `README.md` | Setup and execution instructions |

## Two-layer containers

A running workflow uses two layers of containers:

- **Tool containers** (`brainlife/fsl`, `antsx/ants`, …) — pre-built images on Docker Hub holding the neuroimaging software. You never build these; each tool's CWL references the one it needs.
- **Orchestration container** (built from `Dockerfile` / `Singularity.def`) — holds [cwltool](https://github.com/common-workflow-language/cwltool), the CWL engine, which reads the workflow and launches the tool containers step by step.

You can also skip the orchestration container and run cwltool directly.

## Edit the job file

Before running, open `workflows/<name>_job.yml` and replace the file-path placeholders with paths to your data. Scalar parameters (thresholds, flags) are already filled in from your canvas configuration.

```yaml
input_image: null  # {class: File, path: <your/file/path>}
subject_list: []   # [{class: File, path: <your/file/path>}]
```

## Run it

Pick whichever runtime fits your environment.

### Docker

Only Docker is required — the orchestration container brings cwltool.

```bash
unzip my_pipeline.crate.zip -d my_workflow && cd my_workflow
docker build -t my-pipeline .
docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /path/to/data:/data \
  -v /path/to/output:/output \
  my-pipeline
```

The Docker-socket mount lets cwltool inside the container launch the tool containers; use `/data/...` paths in the job file to match the data mount.

### cwltool directly

Skip the orchestration container and run the engine yourself. Needs Python, `cwltool` (`pip install cwltool`), and Docker for the tool containers.

```bash
cwltool --outdir ./results workflows/<name>.cwl workflows/<name>_job.yml
```

On Windows, run this inside WSL — CWL needs a Unix environment.

### Singularity / HPC

[Singularity / Apptainer](https://apptainer.org/) needs no root access, so it suits shared clusters. cwltool reads the same tool definitions but pulls and runs them with Singularity:

```bash
cwltool --singularity --outdir ./results \
  workflows/<name>.cwl workflows/<name>_job.yml
```

On compute nodes with limited internet, run `bash prefetch_images_singularity.sh` on a login node first to pre-build the SIF images.

### BIDS datasets

If the workflow has a BIDS node, `resolve_bids.py` fills the job file's input paths straight from a BIDS dataset — no manual path editing. Point it at the dataset root with an **absolute path**:

```bash
./run.sh --bids /absolute/path/to/bids/dataset
```

It reads the existing job file first, so your configured scalar parameters are preserved. For the cwltool-direct path, run `resolve_bids.py` first to produce a merged job file, then pass that to cwltool.

## Validating

To check a workflow before running it:

```bash
cwltool --validate workflows/<name>.cwl
```
