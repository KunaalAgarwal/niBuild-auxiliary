# Configuring Parameters

Double-click any node on the canvas to open its parameter configuration modal.

## Docker Image Version

At the top of the modal, select or type a specific Docker image tag to pin the tool to a particular software version. This ensures reproducibility across different computing environments. A dropdown lists all known tags for the tool's library. If you enter a custom tag not in the list, a validation warning appears — you can still use it, but double-check the tag exists on Docker Hub.

## Parameters

- **Required parameters** are shown first and must be set or wired from an upstream connection.
- **Optional parameters** are shown below a separator and have sensible defaults.

## Parameter Types

- **Numbers** — numeric input fields, some with min/max bounds shown as placeholders.
- **Text** — string input fields for filenames, labels, or other text values.
- **Booleans** — toggle switches for on/off flags.
- **Enums** — dropdown menus with predefined valid values.
- **Files / Directories** — wired automatically from upstream connections (shown with a blue highlight and the source node name).

!!! tip
    Parameters that are already wired from an upstream connection display the source node and output name. You don't need to set these manually.

## Operation Ordering

Some tools apply operations in the order they appear on the command line — the result depends on which operations run first. These tools (e.g., `fslmaths`) are flagged as **order-sensitive** and display an **Operation Order** panel at the bottom of the parameter modal.

The panel shows a reorderable list of all active operations. An operation becomes "active" when:

- A file input is wired from an upstream connection
- A file input is manually added via the **+** button
- A scalar or boolean parameter has a value set

Use the **up/down arrows** to reorder operations. The order in this list directly controls the order of flags on the command line.

!!! example
    For `fslmaths`, `-add image.nii -mul 2` gives a different result than `-mul 2 -add image.nii`. The first adds then multiplies; the second multiplies then adds.
