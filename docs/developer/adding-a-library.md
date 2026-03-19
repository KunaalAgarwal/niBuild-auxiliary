# Adding a Library

This guide covers adding an entirely new software library to niBuild (e.g., a new neuroimaging package not yet supported).

## Step 1: Docker Image

Add the library's Docker image to `DOCKER_IMAGES` in `src/utils/toolAnnotations.js`:

```javascript
export const DOCKER_IMAGES = {
    "fsl": "brainlife/fsl",
    "afni": "brainlife/afni",
    // ...
    "my_library": "dockerhub-user/my-library",  // ← add here
};
```

## Step 2: Docker Tags

Add available version tags to `DOCKER_TAGS`:

```javascript
export const DOCKER_TAGS = {
    // ...
    "My Library": [
        "latest",
        "1.0.0",
        "0.9.0",
    ],
};
```

The key must match how the library name appears in the menu (`MODALITY_ASSIGNMENTS`).

## Step 3: Create CWL Directory

Create a subdirectory in `public/cwl/` for the library:

```
public/cwl/my_library/
├── tool_a.cwl
├── tool_b.cwl
└── tool_c.cwl
```

Each CWL file should reference the Docker image from Step 1:

```yaml
hints:
  DockerRequirement:
    dockerPull: dockerhub-user/my-library:latest
```

## Step 4: Add Tool Annotations

Add entries for each tool in `TOOL_ANNOTATIONS` (see [Adding a Tool](adding-a-tool.md) for the full field reference).

## Step 5: Add to Menu

Add the library to `MODALITY_ASSIGNMENTS` under the appropriate modality:

```javascript
'Structural MRI': {
    FSL: { /* ... */ },
    'My Library': {
        'Category Name': ['tool_a', 'tool_b'],
        'Another Category': ['tool_c'],
    },
},
```

If the library spans multiple modalities, add it to each relevant modality section.

## Step 6: Modality (Optional)

If the library requires a new imaging modality, add it to:

```javascript
export const modalityOrder = [
    "Structural MRI", "Functional MRI", /* ... */,
    "My New Modality",  // ← add here
];

export const modalityDescriptions = {
    // ...
    "My New Modality": "Description of the imaging modality.",
};
```

## Verification

1. `npm run dev` — verify tools appear in the correct modality/library section
2. Check Docker version dropdown shows the tags from Step 2
3. Build and export a test workflow using the new tools
4. Validate the exported CWL: `cwltool --validate workflows/test.cwl`
