# Singularity / HPC

[Singularity](https://sylabs.io/singularity/) (now [Apptainer](https://apptainer.org/)) is the standard container runtime on HPC clusters. Unlike Docker, it does **not require root access**, making it suitable for shared compute environments.

cwltool natively supports Singularity — when you pass the `--singularity` flag, it reads the same `DockerRequirement` from each CWL tool definition but uses Singularity to pull and run the container instead of Docker.

## Prerequisites

- [Singularity](https://sylabs.io/singularity/) or [Apptainer](https://apptainer.org/) (v3.0+)
- Python 3 with pip
- [cwltool](https://github.com/common-workflow-language/cwltool): `pip install cwltool`

## 1. Unzip and (optionally) pre-convert images

```bash
unzip my_pipeline.crate.zip -d my_workflow
cd my_workflow

# Optional: convert Docker images to Singularity SIF files ahead of time.
# This is recommended on HPC compute nodes with limited internet access —
# run this on a login node, then transfer the .sif files.
# Without this, cwltool will auto-pull and convert images at runtime.
bash prefetch_images_singularity.sh
```

## 2. Edit the Job File

Open `workflows/<name>_job.yml` and replace file path placeholders with your actual data paths.

## 3. Run

```bash
cwltool --singularity --outdir ./results \
  workflows/<name>.cwl \
  workflows/<name>_job.yml
```

Or use the provided run script:

```bash
bash run_singularity.sh
```

## Alternative: Singularity Orchestration Container

You can also build an orchestration container (similar to the Docker approach):

```bash
singularity build my-pipeline.sif Singularity.def
singularity run --bind /path/to/data:/data --bind /path/to/output:/output my-pipeline.sif
```

## Troubleshooting

**FUSE/mount errors** — On some HPC systems you may need `--fakeroot` or ask your admin to configure user namespaces.

**Image cache location** — Set `SINGULARITY_CACHEDIR` to control where SIF files are stored:

```bash
export SINGULARITY_CACHEDIR=/scratch/$USER/.singularity
```
