# Setup & Architecture

How to run niBuild locally, and how the app is put together. To add tools or libraries, see [Extending niBuild](extending.md).

## Local setup

**Prerequisites:** [Node.js](https://nodejs.org/) 18+ and [Git](https://git-scm.com/).

```bash
git clone https://github.com/KunaalAgarwal/niBuild.git
cd niBuild
npm install
npm run dev          # dev server at http://localhost:5173
```

`npm run build` produces a production build in `dist/`, deployed to GitHub Pages on merge to `main`. `npm run lint` and `npm run format` run ESLint and Prettier.

## Tech stack

React 18 single-page app, built with Vite. The canvas is [ReactFlow](https://reactflow.dev/); UI components are React Bootstrap. CWL is parsed and serialized with `js-yaml`; exports are zipped with JSZip. There is no external state library — state lives in hooks and context.

## Project structure

```
niBuild/
├── src/
│   ├── main.jsx        # entry, provider stack, command palette, save bindings
│   ├── components/     # IDE shell, sidebar/canvas/node renderers, modals
│   ├── context/        # cross-cutting providers (toast, aux tabs, sidebar, …)
│   ├── hooks/          # useWorkspaces, useCustomWorkflows, buildWorkflow, …
│   ├── utils/          # CWL parser, tool registry/annotations, BIDS, RO-Crate
│   └── data/           # standard-template registry
├── public/cwl/         # 155 CWL tool definitions, by library
└── scripts/            # fetchDockerTags.mjs
```

## Architecture

The UI is an IDE shell — tab strip, collapsible left sidebar, right CWL-preview panel, bottom utility bar — wrapping a ReactFlow canvas. Cross-cutting concerns (toasts, aux tabs, saved entries, sidebar state, template assets) are React context providers stacked in `main.jsx`.

Workspaces, saved entries, and aux tabs are each managed by a hook and persisted to `localStorage` (debounced). A saved entry carries a `kind` — `workflow` or `custom-node` — that determines whether a drop expands into nodes or inserts a single composite node.

### Three-layer tool configuration

Each tool's runtime config is assembled from three layers:

1. **CWL files** (`public/cwl/`) — ground truth for inputs, outputs, types, and Docker images.
2. **`toolAnnotations.js`** — non-CWL metadata: UI labels, extension and bounds validation, and modality/library/category placement.
3. **`toolRegistry.js`** — `getToolConfigSync()` merges the two into one cached config object.

On startup, every CWL file is fetched and parsed into a synchronous cache.

### CWL generation

Clicking **Generate** runs `buildWorkflow.js`, which:

1. Expands any custom-node composites into their sub-graphs.
2. Topologically sorts the nodes (failing on cycles).
3. Turns each node into a CWL step — wiring edge mappings to upstream outputs, lifting unwired inputs to workflow-level inputs, and applying scatter, conditionals, and expressions.

`generateWorkflow.js` then injects pinned Docker versions, stages template files, builds the RO-Crate metadata, and assembles the `.crate.zip`.
