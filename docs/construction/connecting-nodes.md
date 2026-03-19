# Connecting Nodes

Connections define how data flows between processing steps. Each connection maps specific outputs of a source tool to specific inputs of a target tool.

1. Draw a connection between two nodes (or double-click an existing edge) to open the Edge Mapping Modal.
2. The left column shows all available **outputs** from the source node. The right column shows all available **inputs** on the target node.
3. Click an output on the left, then click an input on the right to create a mapping. A connecting line appears between them.
4. Click on a connecting line to remove that mapping.
5. You can create multiple mappings per edge to pass several outputs to different inputs simultaneously.

## Link Merge Strategy

When multiple edges feed the same input on a node, you must choose a merge strategy. Set this in the node's parameter modal (double-click the target node):

- `merge_flattened` — combines all upstream outputs into a single flat array, e.g. `[a, b, c]`
- `merge_nested` — preserves grouping per source, e.g. `[[a], [b, c]]`

## Type Compatibility

- niBuild validates type compatibility (File vs. non-File, array vs. scalar) and file extension compatibility between outputs and inputs.
- Incompatible mappings are highlighted with warnings. Only valid mappings can be saved.
