# Custom Workflows

Save and reuse common processing pipelines as custom workflow nodes. A custom workflow encapsulates a multi-step pipeline into a single reusable node.

## Saving a Workflow

1. Build a pipeline on the canvas as usual.
2. Enter a name in the **Workflow Name** input field above the canvas.
3. Click **Save Workflow** in the actions bar. If the name already exists, the existing workflow is updated.

## Using a Custom Workflow

1. Saved workflows appear in the **My Workflows** section of the tool menu.
2. Drag a custom workflow onto any workspace to use it as a single reusable node.
3. Double-click the custom workflow node to configure parameters for each internal step. Use the arrow buttons to navigate between steps.

## Managing Custom Workflows

- Click the **pencil icon** next to a saved workflow to edit it in a new workspace.
- Click the **X icon** to delete a workflow (with confirmation). Deleting also removes instances from all workspaces.
- Custom workflows are stored in your browser's localStorage and persist across sessions.
- At export time, custom workflow nodes are expanded into their constituent processing steps in the generated CWL.

## Staged Changes & Comparison

When you're editing a saved custom workflow, the **Save Workflow** button changes to **Staged Changes**. Clicking it opens a diff modal that shows exactly what has changed since the last save:

- **Metadata changes** — workflow name or output name modifications
- **Node changes** — added, removed, or modified nodes with details on Docker version, parameters, conditionals, expressions, scatter settings, and notes
- **Edge changes** — added, removed, or modified edge mappings

Changes are color-coded: +Added (green), -Removed (red), ~Modified (orange).

The modal provides two actions:

- **Update Workflow** — saves all changes to the custom workflow
- **Revert Changes** — discards all changes and restores the workflow to its last saved state
