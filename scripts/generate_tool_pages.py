"""
Generate MkDocs tool reference pages from tool-data.json.

Run standalone: python scripts/generate_tool_pages.py
Or via mkdocs-gen-files plugin at build time.
"""

import json
import os
import re

DOCS_DIR = os.path.join(os.path.dirname(os.path.dirname(__file__)), "docs")
DATA_PATH = os.path.join(DOCS_DIR, "tool-data.json")

# Map modality name to URL slug
MODALITY_SLUGS = {
    "Structural MRI": "structural-mri",
    "Functional MRI": "functional-mri",
    "Diffusion MRI": "diffusion-mri",
    "Arterial Spin Labeling": "arterial-spin-labeling",
    "PET": "pet",
    "Multimodal": "multimodal",
    "Utilities": "utilities",
    "Pipelines": "pipelines",
}

# Map library display name to DOCKER_IMAGES key
LIBRARY_KEYS = {
    "FSL": "fsl",
    "AFNI": "afni",
    "ANTs": "ants",
    "FreeSurfer": "freesurfer",
    "MRtrix3": "mrtrix3",
    "Connectome Workbench": "connectome_workbench",
    "fMRIPrep": "fmriprep",
    "MRIQC": "mriqc",
    "AMICO": "amico",
    "dcm2niix": "dcm2niix",
    "ICA-AROMA": "ica_aroma",
}


def sanitize_filename(name):
    """Convert tool name to safe filename."""
    return re.sub(r"[^a-zA-Z0-9_-]", "_", name)


def generate_tool_page(tool_name, tool, docker_images, docker_tags):
    """Generate markdown content for a single tool page."""
    lines = []

    full_name = tool.get("fullName", tool_name)
    lines.append(f"# {full_name}")
    lines.append("")

    # Metadata badges
    locations = tool.get("locations", [])
    if locations:
        lib = locations[0].get("library", "Unknown")
        lib_key = LIBRARY_KEYS.get(lib, lib.lower())
        docker_image = docker_images.get(lib_key, "")
        lines.append(f"**Library:** {lib} | **Docker Image:** `{docker_image}`")
    else:
        lines.append(f"**Tool ID:** `{tool_name}`")
    lines.append("")

    # Function
    func = tool.get("function")
    if func:
        lines.append(f"## Function")
        lines.append("")
        lines.append(func)
        lines.append("")

    # Modality
    modality = tool.get("modality")
    if modality:
        lines.append(f"**Modality:** {modality}")
        lines.append("")

    # Typical Use
    typical = tool.get("typicalUse")
    if typical:
        lines.append(f"**Typical Use:** {typical}")
        lines.append("")

    # Key Parameters
    key_params = tool.get("keyParameters")
    if key_params:
        lines.append("## Key Parameters")
        lines.append("")
        lines.append(key_params)
        lines.append("")

    # Key Points
    key_points = tool.get("keyPoints")
    if key_points:
        lines.append("## Key Points")
        lines.append("")
        lines.append(key_points)
        lines.append("")

    # CWL Inputs table
    cwl = tool.get("cwl")
    if cwl and cwl.get("inputs"):
        lines.append("## Inputs")
        lines.append("")
        lines.append("| Name | Type | Required | Label | Flag |")
        lines.append("|---|---|---|---|---|")
        for inp_name, inp in cwl["inputs"].items():
            req = "Yes" if inp.get("required") else "No"
            label = inp.get("label") or ""
            prefix = f"`{inp['prefix']}`" if inp.get("prefix") else ""
            inp_type = f"`{inp.get('type', 'any')}`"
            lines.append(f"| `{inp_name}` | {inp_type} | {req} | {label} | {prefix} |")
        lines.append("")

    # Input extensions
    input_ext = tool.get("inputExtensions")
    if input_ext:
        lines.append("### Accepted Input Extensions")
        lines.append("")
        for name, exts in input_ext.items():
            lines.append(f"- **{name}**: {', '.join(f'`{e}`' for e in exts)}")
        lines.append("")

    # CWL Outputs table
    if cwl and cwl.get("outputs"):
        lines.append("## Outputs")
        lines.append("")
        lines.append("| Name | Type | Glob Pattern |")
        lines.append("|---|---|---|")
        for out_name, out in cwl["outputs"].items():
            out_type = f"`{out.get('type', 'File')}`"
            glob = out.get("glob")
            if isinstance(glob, list):
                glob_str = ", ".join(f"`{g}`" for g in glob)
            elif glob:
                glob_str = f"`{glob}`"
            else:
                glob_str = ""
            lines.append(f"| `{out_name}` | {out_type} | {glob_str} |")
        lines.append("")

    # Output extensions
    output_ext = tool.get("outputExtensions")
    if output_ext:
        lines.append("### Output Extensions")
        lines.append("")
        for name, exts in output_ext.items():
            lines.append(f"- **{name}**: {', '.join(f'`{e}`' for e in exts)}")
        lines.append("")

    # Parameter bounds
    bounds = tool.get("bounds")
    if bounds:
        lines.append("## Parameter Bounds")
        lines.append("")
        lines.append("| Parameter | Min | Max |")
        lines.append("|---|---|---|")
        for param, b in bounds.items():
            if isinstance(b, list) and len(b) == 2:
                lines.append(f"| `{param}` | {b[0]} | {b[1]} |")
        lines.append("")

    # Enum hints
    enum_hints = tool.get("enumHints")
    if enum_hints:
        lines.append("## Enum Options")
        lines.append("")
        for param, values in enum_hints.items():
            lines.append(f"**`{param}`**: {', '.join(f'`{v}`' for v in values)}")
            lines.append("")

    # Docker tags
    if locations:
        lib = locations[0].get("library", "")
        tags = docker_tags.get(lib)
        if tags:
            lines.append("## Docker Tags")
            lines.append("")
            lines.append(f"Available versions: {', '.join(f'`{t}`' for t in tags[:10])}")
            if len(tags) > 10:
                lines.append(f" and {len(tags) - 10} more")
            lines.append("")

    # Categories
    if locations:
        lines.append("## Categories")
        lines.append("")
        for loc in locations:
            lines.append(f"- {loc['modality']} > {loc['library']} > {loc['category']}")
        lines.append("")

    # Documentation link
    doc_url = tool.get("docUrl")
    if doc_url:
        lines.append(f"## Documentation")
        lines.append("")
        lines.append(f"[Official Documentation]({doc_url})")
        lines.append("")

    return "\n".join(lines)


def generate_modality_index(modality, description, libraries, tools, docker_images, tool_primary_modality):
    """Generate modality index page listing all tools grouped by library > category."""
    lines = [f"# {modality}", "", description, ""]
    current_slug = MODALITY_SLUGS.get(modality, "")

    for library, categories in libraries.items():
        lib_key = LIBRARY_KEYS.get(library, library.lower())
        docker_image = docker_images.get(lib_key, "")
        lines.append(f"## {library}")
        lines.append("")
        if docker_image:
            lines.append(f"Docker image: `{docker_image}`")
            lines.append("")

        for category, tool_names in categories.items():
            lines.append(f"### {category}")
            lines.append("")
            lines.append("| Tool | Description |")
            lines.append("|---|---|")
            for tname in tool_names:
                tool = tools.get(tname, {})
                full = tool.get("fullName", tname)
                func = tool.get("function", "")
                if len(func) > 120:
                    func = func[:117] + "..."
                slug = sanitize_filename(tname)
                # Link to primary modality directory if tool page lives elsewhere
                primary_mod = tool_primary_modality.get(tname, modality)
                primary_slug = MODALITY_SLUGS.get(primary_mod, "")
                if primary_slug and primary_slug != current_slug:
                    lines.append(f"| [{full}](../{primary_slug}/{slug}.md) | {func} |")
                else:
                    lines.append(f"| [{full}]({slug}.md) | {func} |")
            lines.append("")

    return "\n".join(lines)


def main():
    with open(DATA_PATH, "r", encoding="utf-8") as f:
        data = json.load(f)

    tools = data["tools"]
    modality_assignments = data["modalityAssignments"]
    modality_order = data["modalityOrder"]
    modality_descriptions = data["modalityDescriptions"]
    docker_images = data["dockerImages"]
    docker_tags = data["dockerTags"]

    # Build set of which tools appear in which modality
    tool_primary_modality = {}
    for modality in modality_order:
        libraries = modality_assignments.get(modality, {})
        for library, categories in libraries.items():
            for category, tool_names in categories.items():
                for tname in tool_names:
                    if tname not in tool_primary_modality:
                        tool_primary_modality[tname] = modality

    # Generate modality index pages and individual tool pages
    for modality in modality_order:
        slug = MODALITY_SLUGS.get(modality)
        if not slug:
            continue

        mod_dir = os.path.join(DOCS_DIR, "tools", slug)
        os.makedirs(mod_dir, exist_ok=True)

        libraries = modality_assignments.get(modality, {})
        description = modality_descriptions.get(modality, "")

        # Modality index page
        index_content = generate_modality_index(
            modality, description, libraries, tools, docker_images, tool_primary_modality
        )
        with open(os.path.join(mod_dir, "index.md"), "w", encoding="utf-8") as f:
            f.write(index_content)

        # Individual tool pages — only generate in the tool's primary modality
        for library, categories in libraries.items():
            for category, tool_names in categories.items():
                for tname in tool_names:
                    if tool_primary_modality.get(tname) != modality:
                        continue
                    tool = tools.get(tname)
                    if not tool:
                        continue
                    page_content = generate_tool_page(
                        tname, tool, docker_images, docker_tags
                    )
                    filename = sanitize_filename(tname) + ".md"
                    with open(os.path.join(mod_dir, filename), "w", encoding="utf-8") as f:
                        f.write(page_content)

    # Update the nav in mkdocs.yml would be too complex here —
    # instead, generate a nav snippet that can be reviewed
    print(f"Generated pages for {len(tools)} tools across {len(modality_order)} modalities.")


if __name__ == "__main__":
    main()
