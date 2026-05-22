# Building Workflows

A niBuild workflow is a directed graph: each node is a processing tool, each edge carries data from one tool's output to the next tool's input. This page covers building that graph; [Saving & Exporting](saving-exporting.md) covers turning it into a runnable bundle.

## The interface

niBuild is laid out as an IDE:

- **Top bar** — search / command palette (`Ctrl+K`), and the **Save as Workflow**, **Save as Custom Node**, and **Generate** actions.
- **Tab strip** — the pinned **Workflow Manager** plus one tab per open workspace.
- **Left sidebar** — four tabs: **Tools**, **Parameters**, **BIDS**, and **Changes**.
- **Center** — the canvas where you build the pipeline.
- **Right panel** — a live [CWL preview](saving-exporting.md#cwl-preview) of the workflow.
- **Bottom bar** — **Problems**, **I/O**, **Log**, **Env**, and **Server** tabs.

Every panel is resizable and collapsible.

## How niBuild maps to CWL

niBuild generates [CWL v1.2](https://www.commonwl.org/v1.2/) — an open standard for portable, containerized workflows. The canvas maps directly onto it:

| niBuild | CWL |
|---|---|
| Node on canvas | Workflow step |
| Edge between nodes | Step input wiring (`source:`) |
| Parameter value | Step input `default:` |
| Docker version selector | `dockerPull:` image tag |
| Workflow Input / Output node | Top-level workflow input / output |
| Scatter toggle | `scatter:` directive |
| When expression | `when:` condition |

You never write CWL by hand — but the [CWL preview](saving-exporting.md#cwl-preview) shows exactly what each canvas change produces.

## The tool menu

The **Tools** sidebar tab lists every node, organized by **imaging modality → software library → category**. Drag a tool onto the canvas to add it as a step. Hover for a tooltip (full name, function, key parameters); double-click to open the tool's official documentation.

Search filters by name, function, or modality. Prefix syntax narrows the scope — `Diffusion/` lists all diffusion tools, `MRI/bet` searches `bet` within MRI modalities.

### I/O nodes

The **I/O** section holds four nodes that define a pipeline's entry and exit points:

- **Workflow Input** — an external file or value supplied at runtime.
- **Workflow Output** — collects upstream outputs as final results. Double-click to choose which outputs to include.
- **BIDS Dataset** — imports files from a [BIDS dataset](bids.md); configured in the **BIDS** sidebar tab.
- **Standard Template** — a canonical reference (MNI152, fsaverage, an atlas). The resolved file is bundled into the export.

## Connecting nodes

Drag from a node's output handle (right edge) to another node's input handle (left edge). The **Edge Mapping** modal opens: pick a source output on the left and a target input on the right to wire them. One edge can carry several mappings.

niBuild validates every mapping — type (File vs. scalar, array vs. scalar) and file extension must be compatible; invalid mappings are rejected with a reason.

When two edges feed the same input, set a merge strategy in the target node's **Parameters** panel: `merge_flattened` combines all sources into one flat array, `merge_nested` keeps them grouped per source.

### Node badges

A node shows badges for its active features:

| Badge | Meaning |
|---|---|
| Docker tag | Pinned image version |
| `↻` | Scatter inherited from upstream |
| `G` | Gather — an array input collecting scattered outputs |
| `?` | A conditional (`when`) expression is set |
| `fx` | A value expression is active |
| `N` | Notes are attached |

Use **Auto Layout** (`Ctrl+Shift+L`) to arrange the graph; the minimap and zoom controls sit in the canvas corners. Select a node or edge and press **Delete** to remove it.

## Configuring parameters

Select a node — its parameters load in the **Parameters** sidebar tab. (For more room, pop the panel out as an editor tab from the command palette.)

- **Docker version** — pin the tool's image tag at the top of the panel. An unknown tag still works but raises a warning.
- **Required parameters** appear first; **optional** ones follow a separator, with sensible defaults.
- Inputs **wired from an upstream connection** show the source node and are highlighted — you don't set these by hand.
- Parameter types: numbers, text, boolean toggles, and enum dropdowns.

Click the **fx** button beside any parameter to transform its value with a CWL expression — see [Expressions](advanced.md#expressions).

### Operation ordering

Some tools — `fslmaths` is the canonical case — apply operations in command-line order, so the result depends on sequence. These show an **Operation Order** panel listing every active operation; reorder it with the up/down arrows. For `fslmaths`, `-add image -mul 2` (add, then multiply) differs from `-mul 2 -add image` (multiply, then add).
