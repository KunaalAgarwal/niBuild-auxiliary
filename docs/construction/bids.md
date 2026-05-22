# BIDS Datasets

The **BIDS Dataset** I/O node turns a [BIDS](https://bids-specification.readthedocs.io/)-formatted dataset into typed workflow inputs — niBuild reads the directory structure and exposes each subject's files as ready-to-wire output ports.

## Adding a BIDS dataset

1. Drag **BIDS Dataset** from the **I/O** menu onto the canvas and select it — the **BIDS** sidebar tab activates.
2. Choose a BIDS directory from your local filesystem. niBuild parses it in the browser; no data is uploaded.
3. Select **subjects** and enable the **data types** (anat, func, dwi, …) you need.
4. Define **output groups** — each is a data type + suffix + optional filters (task, run, acquisition), and becomes an output port on the node.
5. Wire those ports to downstream tools like any other edge.

## Scatter and the directory output

BIDS outputs are always arrays (one file per subject-run), so [scatter](advanced.md) propagates automatically through every downstream node — each subject-run is processed independently.

Every BIDS node also exposes a **`bids_directory`** output of type `Directory` — the dataset root, for tools that take a whole BIDS directory (such as fMRIPrep or MRIQC). Unlike the file-array outputs, it does not carry scatter.
