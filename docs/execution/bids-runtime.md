# BIDS Runtime

Workflows built with BIDS Dataset nodes support automatic input resolution from BIDS-formatted datasets at runtime. The resolver script reads your existing job file (which contains pre-configured scalar parameters like thresholds and flags) and merges in the resolved BIDS file paths, so no parameters are lost.

## Prerequisites

- A BIDS-valid dataset (validated with the [BIDS Validator](https://bids-validator.readthedocs.io))
- Python 3.6+ (standard library only — no additional packages required)

## Usage

!!! warning "Important"
    The `--bids-dir` / `--bids` argument must be an **absolute path** to your BIDS dataset root directory (e.g. `/home/user/data/my_bids_dataset`, not a relative path).

### Docker-based execution

```bash
./run.sh --bids /absolute/path/to/your/bids/dataset
```

### Direct cwltool execution

```bash
python3 resolve_bids.py \
  --bids-dir /absolute/path/to/your/bids/dataset \
  --query bids_query.json \
  --job workflows/<name>_job.yml \
  --output job.yml \
  --relative-to .

cwltool workflows/<name>.cwl job.yml
```

The `--job` flag tells the resolver to read the existing job file first, preserving all scalar parameters. The `--output` flag specifies where to write the merged result.

## Manual Override

You can edit the job file directly to specify custom file paths without using the BIDS resolver.
