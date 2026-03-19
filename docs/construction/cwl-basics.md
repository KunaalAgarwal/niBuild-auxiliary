# CWL Basics

[CWL (Common Workflow Language)](https://www.commonwl.org/v1.2/) is an open standard for describing computational workflows. niBuild generates CWL v1.2 workflows that can be executed by any CWL-compliant engine (e.g., [cwltool](https://github.com/common-workflow-language/cwltool), [Toil](https://toil.ucsc-cgl.org/), [Arvados](https://www.arvados.org/)).

## Key Concepts

- **Workflow** — A directed graph of processing steps. Each step runs a command-line tool inside a Docker container. niBuild generates one `.cwl` workflow file for your entire pipeline.
- **Step** — A single processing operation (e.g., brain extraction, registration). Each node on the niBuild canvas becomes a step in the CWL workflow.
- **CommandLineTool** — The CWL definition for a single tool, specifying its Docker image, command-line arguments, inputs, and outputs. niBuild includes pre-built `.cwl` files for every tool.
- **Inputs & Outputs** — Each step declares typed inputs it consumes and outputs it produces. Connections on the canvas wire outputs of one step to inputs of the next.
- **Job Template** — A `.yml` file that provides concrete values for the workflow's top-level inputs (file paths, parameter values). niBuild pre-fills this with your configured parameters.

## CWL Data Types

CWL uses a typed system for inputs and outputs. niBuild handles type matching automatically when you connect nodes:

- `File` — A file path (e.g., a NIfTI image). Most neuroimaging tool inputs and outputs are Files.
- `Directory` — A directory path (e.g., a FreeSurfer subjects directory).
- `string` — A text value (e.g., a subject ID or output prefix).
- `int` / `float` — Numeric values (e.g., a smoothing kernel size or a threshold).
- `boolean` — A true/false flag (e.g., whether to generate a brain mask).
- `enum` — One of a fixed set of values (e.g., a cost function or interpolation method).
- `File[]` / `string[]` — Arrays of the above types, used with scatter (batch processing).

## How niBuild Maps to CWL

| niBuild | CWL |
|---|---|
| Node on canvas | Workflow step |
| Edge between nodes | Step input wiring (`source:`) |
| Parameter value in modal | Step input `default:` value |
| Docker version selector | `dockerPull:` image tag |
| Workflow Input node | Top-level workflow input |
| Workflow Output node | Top-level workflow output |
| Scatter toggle | `scatter:` directive on step |
| When expression | `when:` condition on step |

## Docker Containers

Every tool in niBuild runs inside a Docker container, ensuring reproducibility regardless of the host system. Each library has its own Docker image. When you select a Docker version in the parameter modal, you're pinning the exact software version that will be used at runtime. The exported bundle includes all container references and scripts to pre-pull images.
