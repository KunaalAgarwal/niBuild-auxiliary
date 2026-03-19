# AMICO NODDI Fitting

**Library:** AMICO | **Docker Image:** `cookpa/amico-noddi`

## Function

Fits the NODDI (Neurite Orientation Dispersion and Density Imaging) model to multi-shell diffusion MRI data using convex optimization for fast and robust estimation.

**Modality:** Multi-shell diffusion MRI (4D NIfTI) with b-values and b-vectors, plus brain mask.

**Typical Use:** Microstructural imaging for neurite density and orientation dispersion in white matter.

## Key Parameters

Python: amico.core.setup(), amico.core.load_data(), amico.core.set_model("NODDI"), amico.core.fit()

## Key Points

Requires multi-shell acquisition (recommended: b=0,1000,2000 s/mm2). Outputs NDI (neurite density), ODI (orientation dispersion), and fISO (isotropic fraction). Much faster than original NODDI MATLAB toolbox.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `dwi` | `File` | Yes | Multi-shell diffusion MRI 4D image |  |
| `bvals` | `File` | Yes | b-values file |  |
| `bvecs` | `File` | Yes | b-vectors file |  |
| `mask` | `File` | Yes | Brain mask image |  |
| `num_threads` | `int` | No | Maximum number of CPU threads (default 1) | `--num-threads` |
| `b0_threshold` | `int` | No | Threshold for considering measurements b=0 (default 10) | `--b0-threshold` |
| `csf_diffusivity` | `double` | No | CSF diffusivity in mm^2/s (default 0.003) | `--csf-diffusivity` |
| `parallel_diffusivity` | `double` | No | Intracellular diffusivity parallel to neurites in mm^2/s (default 0.0017) | `--parallel-diffusivity` |
| `ex_vivo` | `boolean` | No | Use ex-vivo AMICO model | `--ex-vivo` |

### Accepted Input Extensions

- **dwi**: `.nii`, `.nii.gz`
- **bvals**: `.bval`
- **bvecs**: `.bvec`
- **mask**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `ndi_map` | `File` | `output/NODDI*ICVF.nii.gz` |
| `odi_map` | `File` | `output/NODDI*OD.nii.gz` |
| `fiso_map` | `File` | `output/NODDI*ISOVF.nii.gz` |
| `log` | `File` | `amico_noddi.log` |
| `err_log` | `File` | `amico_noddi.err.log` |

### Output Extensions

- **ndi_map**: `.nii.gz`
- **odi_map**: `.nii.gz`
- **fiso_map**: `.nii.gz`

## Docker Tags

Available versions: `latest`, `0.1.2`, `0.1.1`, `0.0.4`

## Categories

- Diffusion MRI > AMICO > Microstructure Modeling

## Documentation

[Official Documentation](https://github.com/daducci/AMICO)
