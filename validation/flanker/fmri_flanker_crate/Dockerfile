FROM python:3.11-slim

# Install cwltool (pinned for reproducibility)
RUN pip install --no-cache-dir cwltool==3.1.20240508115724

# Install docker CLI (needed for cwltool to invoke per-tool containers)
RUN apt-get update && \
    apt-get install -y --no-install-recommends docker.io && \
    rm -rf /var/lib/apt/lists/*

# Copy workflow files
WORKDIR /workflow
COPY workflows/ ./workflows/
COPY cwl/ ./cwl/
COPY workflows/fmri_flanker_job.yml ./job.yml
COPY bids_query.json .
COPY resolve_bids.py .
COPY run.sh .
RUN chmod +x run.sh

ENTRYPOINT ["./run.sh"]
