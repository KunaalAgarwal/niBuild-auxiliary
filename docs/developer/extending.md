# Extending niBuild

Adding a neuroimaging tool to niBuild takes two files: a CWL definition and an annotation entry. Adding a whole library is the same, plus registering its Docker image.

## Add a tool

### 1. Write the CWL file

Create `public/cwl/<library>/<tool>.cwl`. Use CWL v1.2, declare the Docker image under `hints` (so the tool can still run without Docker), give required inputs plain types and optional inputs nullable ones (`['null', double]`), and glob outputs against an input-derived name:

```yaml
cwlVersion: v1.2
class: CommandLineTool
baseCommand: my_tool

hints:
  DockerRequirement:
    dockerPull: brainlife/fsl:latest

inputs:
  input_image:
    type: File
    inputBinding: { position: 1 }
  output_prefix:
    type: string
    inputBinding: { position: 2 }
  threshold:
    type: ['null', double]
    inputBinding: { prefix: -t }

outputs:
  result:
    type: File
    outputBinding:
      glob: $(inputs.output_prefix).nii.gz
```

For mutually exclusive options, use a record type — see `bet.cwl` for an example.

### 2. Add an annotation

Add an entry to `TOOL_ANNOTATIONS` in `src/utils/toolAnnotations.js`. CWL is the ground truth for types and bindings; the annotation adds what the UI needs on top:

```javascript
"my_tool": {
    "cwlPath": "cwl/fsl/my_tool.cwl",
    "fullName": "My Tool Full Name",
    "function": "One-sentence description of what it does.",
    "modality": "Expected input type and format.",
    "keyParameters": "-t (threshold), -o (output prefix)",
    "keyPoints": "Usage notes and gotchas.",
    "typicalUse": "Where it fits in a pipeline.",
    "docUrl": "https://link-to-official-docs",
    // optional validation:
    "inputExtensions": { "input_image": [".nii", ".nii.gz"] },
    "bounds": { "threshold": [0, 1] },
    "enumHints": { "cost_function": ["mutualinfo", "corratio"] }
},
```

The seven fields above `docUrl` are required; the validation blocks are optional.

### 3. Place it in the menu

Add the tool name to `MODALITY_ASSIGNMENTS` in the same file, under the right **modality → library → category** (create a category if none fits):

```javascript
'Structural MRI': {
    FSL: { 'Brain Extraction': ['bet', 'my_tool'] },
},
```

## Add a library

For a new software package, also:

1. Register its image in `DOCKER_IMAGES` and its version tags in `DOCKER_TAGS` (the `DOCKER_TAGS` key must match the library's display name in the menu).
2. Create `public/cwl/<library>/` and point every tool's `dockerPull` at the new image.
3. Add the library under each modality it belongs to in `MODALITY_ASSIGNMENTS`.
4. If it needs a new modality, add it to `modalityOrder` and `modalityDescriptions`.

## Test a CWL tool

Validate every tool definition, then run it on real data:

```bash
# 1. Validate syntax, types, and v1.2 compliance
cwltool --validate public/cwl/fsl/my_tool.cwl

# 2. Generate a job template, then fill it with realistic values
cwltool --make-template public/cwl/fsl/my_tool.cwl > job.yml

# 3. Run it
cwltool public/cwl/fsl/my_tool.cwl job.yml
```

Configure the job to exercise the optional outputs too. Then check that every expected output exists and is non-empty, that headers and dimensions are correct (`fslinfo`, `3dinfo`), and that image values are sane — not all-zero, no NaNs. For tools with highly variable behavior, test a few configurations: defaults, aggressive parameters, and all outputs enabled.

!!! note
    On Windows, run `cwltool` inside WSL — CWL needs a Unix environment.
