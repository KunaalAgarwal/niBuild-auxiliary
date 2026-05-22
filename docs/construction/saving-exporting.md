# Saving & Exporting

niBuild keeps three distinct things, and it helps to be clear on which is which:

| Concept | What it is | Where it lives |
|---|---|---|
| **Workspace** | A live editing canvas — your scratch surface for building a pipeline. Several can be open at once. | A tab in the tab strip |
| **Saved Workflow** | A workspace saved for reuse. Dropped onto a canvas later, it **expands** into all its nodes and edges, fully editable. | **My Workflows**, in the Tools menu |
| **Custom Node** | A workspace saved for reuse. Dropped onto a canvas later, it appears as **one composite node** that hides its internals. | **Custom Nodes**, in the Tools menu |

A workspace is *where you work*; a Saved Workflow and a Custom Node are two ways to *keep* that work and reuse it elsewhere. The **Workflow Manager** is where you browse and manage everything you have saved.

## Workspaces

Each workspace is an independent canvas — its own nodes, edges, and viewport — shown as a tab. Create one with the **+** button, rename it by double-clicking the tab, and reorder tabs by dragging. Workspace state auto-saves to your browser's `localStorage`, so an open workspace survives a page reload — but it is not a catalogued, reusable entry until you explicitly save it.

The workspace name is the export filename — there is no separate output-name field.

## Saving a workspace for reuse

The same workspace can be saved as a **Saved Workflow**, a **Custom Node**, or both. The two kinds hold the same pipeline; they differ only in how they behave when dragged back onto a canvas:

| Kind | Save button | Drop behavior | Best for |
|---|---|---|---|
| **Saved Workflow** | Save as Workflow | Expands into all its nodes and edges, fully editable | Pipelines you fork or tweak per project |
| **Custom Node** | Save as Custom Node | Inserts a single composite node that hides its internals | Stable subroutines reused across many workflows |

Once saved, a workspace is **bound** to that entry: the matching button changes to **Update** and enables only when there are unsaved changes. A workspace can be bound to one of each kind at once, so the other button stays in **Save as…** mode. The **Changes** sidebar tab shows a diff of the live canvas against each bound entry — additions (green), removals (red), modifications (orange) — with its own **Update** and **Revert** controls.

Saved entries are searchable in the **Tools** menu by name or by the tools they contain.

## The Workflow Manager

The **Workflow Manager** is a pinned tab — always first in the tab strip — that catalogs every Saved Workflow and Custom Node in a single table. Where a workspace is for *building* one pipeline, the Workflow Manager is for *managing* all of them: each row can be opened in a workspace, exported directly as CWL / YML / Crate, duplicated, renamed, annotated with notes, or deleted.

## CWL preview

The right-side panel shows the generated workflow live as you edit. Toggle between the **.cwl** view (workflow definition) and the **.yml** view (job template with your parameter values), and copy either to the clipboard. Expand it into a full editor tab to scroll long pipelines.

## Generating the bundle

Click **Generate** to download `<workspace>.crate.zip` — a self-contained [Workflow RO-Crate](https://w3id.org/workflowhub/workflow-ro-crate/1.0) holding the CWL workflow, a pre-filled job template, every tool definition, Docker and Singularity run scripts, and FAIR metadata. Custom Node instances are expanded into their underlying steps first — the bundle never references a composite as a black box.

See [Execution & Output](../execution/index.md) for the full bundle contents and how to run it.
