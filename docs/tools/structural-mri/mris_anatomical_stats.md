# FreeSurfer Surface Anatomical Statistics

**Library:** FreeSurfer | **Docker Image:** `freesurfer/freesurfer`

## Function

Computes surface-based morphometric measures (thickness, area, volume, curvature) for each region in a parcellation.

**Modality:** FreeSurfer subject directory with completed recon-all.

**Typical Use:** Extracting regional cortical thickness, area, and volume measures.

## Key Parameters

-a (annotation file), -f (output stats file), -b (output table format)

## Key Points

Outputs per-region cortical thickness, surface area, gray matter volume, and curvature.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `subjects_dir` | `Directory` | Yes | FreeSurfer SUBJECTS_DIR |  |
| `fs_license` | `File` | Yes | FreeSurfer license file |  |
| `subject` | `string` | Yes | Subject name |  |
| `hemi` | `enum` | Yes | Hemisphere (lh or rh) |  |
| `annotation` | `File` | No | Annotation file for parcellation | `-a` |
| `tablefile` | `string` | No | Output table filename | `-f` |
| `white` | `string` | No | White surface name (default white) |  |
| `pial` | `string` | No | Pial surface name | `-pial` |
| `label` | `File` | No | Limit stats to label region | `-l` |
| `cortex` | `File` | No | Cortex label file | `-cortex` |
| `th3` | `boolean` | No | Use tetrahedra for volume (recommended) | `-th3` |
| `thickness` | `string` | No | Thickness file name | `-t` |
| `b` | `boolean` | No | Report total brain volume | `-b` |
| `noglobal` | `boolean` | No | Do not compute global stats | `-noglobal` |
| `log` | `string` | No | Log file name | `-log` |
| `ctab` | `File` | No | Color table file | `-ctab` |
| `mgz` | `boolean` | No | Use mgz format | `-mgz` |

### Accepted Input Extensions

- **annotation**: `.annot`
- **label**: `.label`
- **cortex**: `.label`
- **ctab**: `.txt`, `.ctab`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `stats_table` | `File` | `$(inputs.tablefile)` |
| `stats` | `File` | `*.stats` |
| `log_file` | `File` | `mris_anatomical_stats.log` |

### Output Extensions

- **stats_table**: `.txt`, `.csv`, `.dat`
- **stats**: `.stats`

## Docker Tags

Available versions: `latest`, `8.1.0`, `8.0.0`, `7.2.0`, `7.3.0`, `7.3.1`, `7.3.2`, `7.4.1`, `7.1.1`, `6.0`

## Categories

- Structural MRI > FreeSurfer > Morphometry

## Documentation

[Official Documentation](https://surfer.nmr.mgh.harvard.edu/fswiki/mris_anatomical_stats)
