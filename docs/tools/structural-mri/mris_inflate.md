# FreeSurfer Surface Inflation

**Library:** FreeSurfer | **Docker Image:** `freesurfer/freesurfer`

## Function

Inflates folded cortical surface to a smooth shape while minimizing metric distortion for visualization.

**Modality:** FreeSurfer surface file (e.g., lh.smoothwm).

**Typical Use:** Creating inflated surfaces for visualization of cortical data.

## Key Parameters

-n (number of iterations), -dist (target distance)

## Key Points

Creates inflated surface for visualizing buried cortex. Part of recon-all. Metric distortion encoded in sulc file.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `subjects_dir` | `Directory` | Yes | FreeSurfer SUBJECTS_DIR |  |
| `fs_license` | `File` | Yes | FreeSurfer license file |  |
| `input` | `File` | Yes | Input surface file |  |
| `output` | `string` | Yes | Output inflated surface filename |  |
| `n` | `int` | No | Maximum number of iterations (default 10) | `-n` |
| `dist` | `double` | No | Distance for inflation | `-dist` |
| `no_save_sulc` | `boolean` | No | Do not save sulc file | `-no-save-sulc` |
| `sulc` | `string` | No | Output sulc filename | `-sulc` |
| `nbrs` | `int` | No | Number of neighbors for smoothing | `-nbrs` |
| `spring` | `double` | No | Spring constant | `-spring` |
| `area` | `double` | No | Area coefficient | `-area` |
| `w` | `int` | No | Write intermediate surfaces every N iterations | `-w` |

### Accepted Input Extensions

- **input**: `.white`, `.pial`, `.smoothwm`, `.orig`, `.inflated`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `inflated` | `File` | `$(inputs.output)*` |
| `sulc_file` | `File` | `$(inputs.sulc)`, `*.sulc` |
| `log` | `File` | `mris_inflate.log` |

### Output Extensions

- **inflated**: `.inflated`
- **sulc_file**: `.sulc`

## Docker Tags

Available versions: `latest`, `8.1.0`, `8.0.0`, `7.2.0`, `7.3.0`, `7.3.1`, `7.3.2`, `7.4.1`, `7.1.1`, `6.0`

## Categories

- Structural MRI > FreeSurfer > Surface Reconstruction

## Documentation

[Official Documentation](https://surfer.nmr.mgh.harvard.edu/fswiki/mris_inflate)
