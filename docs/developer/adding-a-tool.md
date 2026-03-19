# Adding a Tool

This guide walks through adding a new neuroimaging tool to niBuild. Adding a tool requires two files: a CWL definition and an annotation entry.

## Step 1: Write the CWL File

Create a new `.cwl` file in `public/cwl/<library>/` (e.g., `public/cwl/fsl/my_tool.cwl`).

```yaml
cwlVersion: v1.2
class: CommandLineTool
baseCommand: my_tool

hints:
  DockerRequirement:
    dockerPull: brainlife/fsl:latest

stdout: $(inputs.output_prefix).log
stderr: $(inputs.output_prefix).log

inputs:
  input_image:
    type: File
    label: Input NIfTI image
    inputBinding:
      position: 1

  output_prefix:
    type: string
    label: Output filename prefix
    inputBinding:
      position: 2

  # Optional parameters use nullable types
  threshold:
    type: ['null', double]
    label: Intensity threshold
    inputBinding:
      prefix: -t
      position: 3

outputs:
  result:
    type: File
    outputBinding:
      glob: $(inputs.output_prefix).nii.gz

  log:
    type: File
    outputBinding:
      glob: $(inputs.output_prefix).log
```

### Key Conventions

- **`cwlVersion: v1.2`** — always use CWL v1.2
- **`hints.DockerRequirement`** — specify the Docker image (use `hints` not `requirements` so the tool can run without Docker)
- **Required inputs** — use plain types (`File`, `string`, `int`, etc.)
- **Optional inputs** — wrap in nullable array: `['null', double]`
- **Mutually exclusive options** — use a record type (see `bet.cwl` for an example)
- **Output globs** — reference `$(inputs.output_prefix)` or similar to match output filenames

## Step 2: Add the Annotation

Add an entry to `src/utils/toolAnnotations.js` in the `TOOL_ANNOTATIONS` object:

```javascript
"my_tool": {
    "cwlPath": "cwl/fsl/my_tool.cwl",

    // UI display metadata
    "fullName": "My Tool Full Name",
    "function": "One-sentence description of what the tool does.",
    "modality": "Expected input type and format.",
    "keyParameters": "-t (threshold), -o (output prefix)",
    "keyPoints": "Usage notes and best practices.",
    "typicalUse": "Where this tool fits in a typical pipeline.",
    "docUrl": "https://link-to-official-docs",

    // File extension validation (optional)
    "inputExtensions": {
        "input_image": [".nii", ".nii.gz"]
    },
    "outputExtensions": {
        "result": [".nii", ".nii.gz"]
    },

    // Parameter constraints (optional)
    "bounds": {
        "threshold": [0, 1]
    },

    // Conditional outputs (optional)
    // Maps output name to the boolean parameter that enables it
    "requires": {
        "optional_output": "enable_flag"
    },

    // Enum hints for string parameters (optional)
    "enumHints": {
        "cost_function": ["mutualinfo", "corratio", "normcorr"]
    }
},
```

### Annotation Fields

| Field | Required | Description |
|---|---|---|
| `cwlPath` | Yes | Path to CWL file relative to `public/` |
| `fullName` | Yes | Human-readable tool name |
| `function` | Yes | What the tool does (one sentence) |
| `modality` | Yes | Expected input data description |
| `keyParameters` | Yes | Important command-line flags |
| `keyPoints` | Yes | Usage notes and gotchas |
| `typicalUse` | Yes | Where this fits in a pipeline |
| `docUrl` | Yes | Link to official documentation |
| `inputExtensions` | No | Valid file extensions per input |
| `outputExtensions` | No | Expected file extensions per output |
| `bounds` | No | `[min, max]` for numeric parameters |
| `requires` | No | Output → boolean flag dependency |
| `enumHints` | No | Fixed valid values for string params |

## Step 3: Add to Menu Organization

Add the tool to `MODALITY_ASSIGNMENTS` in `toolAnnotations.js`:

```javascript
export const MODALITY_ASSIGNMENTS = {
    'Structural MRI': {
        FSL: {
            'Brain Extraction': ['bet', 'my_tool'],  // ← add here
            // ...
        },
    },
};
```

Choose the appropriate modality → library → category. Create a new category if none fits.

## Step 4: Validate

1. Run `npm run dev` and verify the tool appears in the menu
2. Drag it onto the canvas and check that parameters render correctly
3. Connect it to other tools and verify type compatibility
4. Check the CWL Preview panel for correct output

## How It Works

niBuild uses a three-layer system for tool configuration:

1. **CWL files** (ground truth) — define inputs, outputs, types, Docker images, command-line bindings
2. **`toolAnnotations.js`** — adds non-CWL metadata: UI labels, extensions, bounds, menu organization
3. **`toolRegistry.js`** — merges both via `getToolConfigSync()` into a single runtime config object

On app mount, `preloadAllCWL()` fetches and parses all CWL files into a sync cache. When a tool is first used, `getToolConfigSync()` merges the parsed CWL data with annotations and caches the result.
