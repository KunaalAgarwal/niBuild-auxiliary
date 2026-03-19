# Building a Workflow

Build your pipeline by dragging tools onto the canvas and connecting them to define the data flow.

1. Drag a tool from the left-side menu and drop it onto the canvas. A node appears representing that processing step.
2. Drag additional tools to add more steps to your pipeline.
3. Connect two nodes by clicking and dragging from one node's output handle (bottom edge) to another node's input handle (top edge).
4. When a connection is drawn, the Edge Mapping Modal opens automatically so you can map specific outputs to inputs (see [Connecting Nodes](connecting-nodes.md)).

## Canvas Controls

- Scroll to zoom in and out.
- Click and drag on empty canvas space to pan.
- Use the controls in the bottom-left corner for zoom buttons and fit-to-view.
- Click **Auto Layout** (or press `Ctrl+Shift+L`) to automatically arrange nodes as a layered directed graph.
- Click **Hide tools** to collapse the bottom-left toolbar (zoom controls and Auto Layout). The button moves to the corner and reads **Show tools** to restore them.
- The minimap in the bottom-right provides an overview of your full workflow.

## Node Indicators

Tool nodes display visual badges to show active features at a glance:

| Badge | Meaning |
|---|---|
| Docker tag (top-left) | The pinned Docker image version |
| `↻` | Scatter is inherited from upstream nodes |
| `G` | Gather node — array-typed inputs are collecting scattered outputs |
| `?` | A conditional (when) expression is set on this step |
| `fx` | One or more value expressions are active |
| `N` | Notes are attached to this node |

The **info button** (bottom-right corner) shows a pinnable tooltip with the tool's full name, function description, modality, key parameters, key points, and typical use. Click to pin the tooltip open; click again or click elsewhere to dismiss.

## Duplicate Nodes

When the same tool appears multiple times on the canvas (e.g., two FLIRT nodes for different registration steps), niBuild automatically appends numbered suffixes: "flirt (1)", "flirt (2)". This is display-only and does not affect the generated CWL.

## Node Notes

All node types support optional freetext notes. Double-click a node and use the notes field in the modal to document why a particular tool or configuration was chosen. When notes are present, an `N` badge appears on the node. Notes are preserved in saved custom workflows and appear in the workflow comparison diff.

## Output Node Configuration

The **Workflow Output** node lets you select exactly which upstream outputs to include as final workflow results:

1. Drop a Workflow Output node onto the canvas and connect it to one or more upstream tool nodes.
2. Double-click (or click the **config** button) to open the Output Configuration modal.
3. The modal discovers all upstream tool nodes via the graph and lists their outputs with checkboxes.
4. Select the specific outputs you want included in the final workflow. Use **Select All** / **Select None** for bulk operations.
5. The node displays a count badge (e.g., "config (3)") showing how many outputs are selected.

## Removing Elements

- Click a node or edge to select it, then press the **Delete** key to remove it.
- Invalid connections between incompatible tools will show a warning toast explaining the reason.
