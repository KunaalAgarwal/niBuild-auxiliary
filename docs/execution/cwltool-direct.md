# cwltool Direct

Run cwltool on your machine without an orchestration container. cwltool will still use Docker (or Singularity) to run the individual tool containers.

## Prerequisites

- Python 3 with pip
- [cwltool](https://github.com/common-workflow-language/cwltool): `pip install cwltool`
- [Docker](https://docs.docker.com/get-docker/) (for tool containers)

## Windows Users

CWL requires a Unix-like environment. Use WSL (Windows Subsystem for Linux):

1. Install WSL: `wsl --install` (then restart)
2. In WSL: `sudo apt update && sudo apt install python3 python3-pip`
3. `pip install cwltool`

## 1. Unzip

```bash
unzip my_pipeline.crate.zip -d my_workflow
cd my_workflow
chmod +x workflows/*.cwl run.sh run_singularity.sh prefetch_images.sh prefetch_images_singularity.sh
```

## 2. Edit the Job File

Open `workflows/<name>_job.yml` and replace file path placeholders with your actual data paths.

## 3. Run

```bash
cwltool workflows/<name>.cwl workflows/<name>_job.yml
```

With a specific output directory:

```bash
cwltool --outdir ./results workflows/<name>.cwl workflows/<name>_job.yml
```
