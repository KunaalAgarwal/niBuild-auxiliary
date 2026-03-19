# Architecture

niBuild is a single-page React application built with functional components and hooks. No class components are used.

## Component Hierarchy

```
ToastProvider                    # Error/success notifications (wraps entire app)
└── CustomWorkflowsProvider      # Custom workflow CRUD + localStorage persistence
    └── App                      # Main application component
        ├── HeaderBar            # Top bar with help modal, GitHub links
        ├── ActionsBar           # Workspace management, export, save buttons
        ├── WorkflowMenu         # Left sidebar with draggable tool items
        ├── WorkflowCanvas       # ReactFlow canvas (center)
        │   ├── ScatterPropagationContext.Provider
        │   ├── WiredInputsContext.Provider
        │   ├── NodeComponent    # Custom ReactFlow node rendering
        │   ├── EdgeMappingModal # Output→input wiring UI
        │   └── BIDSDataModal    # BIDS dataset browser
        ├── CWLPreviewPanel      # Live CWL preview (right)
        └── ToggleWorkflowBar    # Workspace tab switcher (bottom)
```

## State Management

All state uses functional updates (`setState(prev => ...)`). There are no external state management libraries.

- **Workspace state** — persisted to localStorage via `useDebouncedStorage` (300ms debounce)
- **Custom workflows** — persisted to localStorage via `useCustomWorkflows`
- **Node lookups** — memoized `Map<nodeId, node>` via `useNodeLookup`
- **Tool annotations** — module-level `annotationByName` Map for O(1) lookup
- **Scatter propagation** — computed via `useMemo` in `workflowCanvas.jsx`, provided via context
- **Wired inputs** — computed via `useMemo` in `workflowCanvas.jsx`, provided via context

## Three-Layer Tool Configuration

1. **CWL files** (`public/cwl/`) — ground truth for inputs, outputs, types, Docker images
2. **`toolAnnotations.js`** — non-CWL metadata: UI labels, extensions, bounds, menu organization
3. **`toolRegistry.js`** — `getToolConfigSync()` merges CWL + annotations into a single runtime object, cached after first call

On mount, `preloadAllCWL()` fetches and parses all CWL YAML into a sync cache (`cwlParser.js`).

## CWL Generation Pipeline

When the user clicks **Generate Workflow**, the following happens:

1. **`buildCWLWorkflowObject(graph)`** in `buildWorkflow.js`:
    - `expandCustomWorkflowNodes()` — replaces custom workflow nodes with their internal sub-graphs
    - Topological sort via Kahn's algorithm (throws on cycles)
    - For each node: resolves tool config via `getToolConfigSync()`, creates CWL step
    - Wired inputs (from edge mappings) connect to upstream step outputs
    - Unwired required/optional inputs become workflow-level inputs
    - Scatter, conditionals (`when`), expressions (`valueFrom`), multi-source (`linkMerge`) applied per-node
2. **`buildJobTemplate()`** — generates job input YAML from workflow-level inputs
3. **`generateWorkflow()`** hook — fetches individual tool CWL files, injects Docker versions, assembles ZIP:
    - CWL workflow + job template
    - Dockerfile + run.sh
    - Singularity.def + run_singularity.sh
    - Image prefetch scripts
    - RO-Crate metadata (JSON-LD)
    - README
4. Downloads as `{name}.crate.zip`

## Key Data Structures

### Node

```javascript
{
    id: string,              // crypto.randomUUID()
    type: 'default',
    position: { x, y },
    data: {
        label: string,       // tool name
        parameters: object,
        dockerVersion: string,
        scatterInputs: string[],
        scatterMethod: string,
        linkMergeOverrides: object,
        whenExpression: string,
        expressions: object,
        isDummy: boolean,
        isBIDS: boolean,
        isCustomWorkflow: boolean,
    }
}
```

### Edge

```javascript
{
    id: string,
    source: string,          // source node ID
    target: string,          // target node ID
    data: {
        mappings: [{
            sourceOutput: string,
            targetInput: string
        }]
    }
}
```

## Key Files

| File | Purpose |
|---|---|
| `src/main.jsx` | App entry, CWL preloading, workspace management |
| `src/components/workflowCanvas.jsx` | ReactFlow canvas, node drops, edge creation, scatter/wired context |
| `src/components/NodeComponent.jsx` | Routes to ToolNodeComponent, IONodeModal, or CustomWorkflowParamModal |
| `src/components/EdgeMappingModal.jsx` | Output→input wiring UI |
| `src/hooks/buildWorkflow.js` | CWL generation (topo sort, step expansion, scatter handling) |
| `src/hooks/generateWorkflow.js` | RO-Crate ZIP assembly |
| `src/utils/toolAnnotations.js` | Tool metadata, Docker images, modality assignments |
| `src/utils/toolRegistry.js` | Merges CWL + annotations into runtime config |
| `src/utils/cwlParser.js` | CWL YAML parsing and sync cache |
| `src/utils/scatterPropagation.js` | BFS scatter propagation computation |
| `src/utils/edgeMappingUtils.js` | Type compatibility checking, tool IO resolution |
