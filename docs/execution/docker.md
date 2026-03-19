# Docker

Run your workflow using Docker. Only Docker is required — no Python or cwltool installation needed, as the orchestration container includes everything.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)

## 1. Unzip and (optionally) pre-pull tool images

```bash
unzip my_pipeline.crate.zip -d my_workflow
cd my_workflow

# Optional: pre-download tool container images so the first run doesn't stall.
# Without this, cwltool will pull images on-the-fly as needed.
bash prefetch_images.sh
```

## 2. Edit the Job File

Open `workflows/<name>_job.yml` and replace file path placeholders with your actual data paths. Use `/data/...` paths (e.g. `/data/my_brain.nii.gz`) to match the volume mount in the run command below.

## 3. Build the Orchestration Container

This builds a container with cwltool and your workflow files inside. It does **not** include your data or the tool containers — those are handled separately at runtime.

```bash
docker build -t my-pipeline .
```

## 4. Run the Workflow

```bash
docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /path/to/data:/data \
  -v /path/to/output:/output \
  my-pipeline
```

### Volume Mounts

| Mount | Purpose |
|---|---|
| `-v /var/run/docker.sock:...` | Gives the orchestration container access to Docker so cwltool can launch tool containers |
| `-v /path/to/data:/data` | Makes your input data available inside the container at `/data` — job file paths should use `/data/...` |
| `-v /path/to/output:/output` | Where cwltool writes workflow results (output directory) |

### Additional Options

```bash
# Show usage info
docker run my-pipeline --help

# Run with verbose output
docker run --rm -v ... my-pipeline --verbose
```

## Troubleshooting

**Docker not found** — Ensure Docker is running: `docker --version`

**Permission denied on Docker** — Add your user to the docker group: `sudo usermod -aG docker $USER` (log out and back in)

**Validation errors** — Validate the workflow: `cwltool --validate workflows/<name>.cwl`
