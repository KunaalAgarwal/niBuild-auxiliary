# FreeSurfer Annotation to Individual Labels

**Library:** FreeSurfer | **Docker Image:** `freesurfer/freesurfer`

## Function

Extracts individual region labels from a surface annotation file into separate label files.

**Modality:** FreeSurfer annotation file (e.g., lh.aparc.annot).

**Typical Use:** Extracting individual ROIs from parcellation for targeted analysis.

## Key Parameters

--subject (subject), --hemi (hemisphere), --annotation (annotation name), --outdir (output directory)

## Key Points

Creates one .label file per region. Label files contain vertex indices and coordinates.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `subjects_dir` | `Directory` | Yes | FreeSurfer SUBJECTS_DIR |  |
| `fs_license` | `File` | Yes | FreeSurfer license file |  |
| `subject` | `string` | Yes | Subject name | `--subject` |
| `hemi` | `enum` | Yes | Hemisphere (lh or rh) | `--hemi` |
| `annotation` | `string` | No | Annotation name (default aparc) | `--annotation` |
| `surface` | `string` | No | Surface name (default white) | `--surface` |
| `outdir` | `string` | Yes | Output directory for label files | `--outdir` |
| `labelbase` | `string` | No | Base name for output labels | `--labelbase` |
| `border` | `string` | No | Output border file | `--border` |
| `borderdilate` | `int` | No | Dilate border by N | `--borderdilate` |
| `ctab` | `File` | No | Color table file | `--ctab` |
| `seg` | `boolean` | No | Output segmentation instead of labels | `--seg` |

### Accepted Input Extensions

- **ctab**: `.txt`, `.ctab`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `labels` | `Directory` | `$(inputs.outdir)` |
| `border_file` | `File` | `$(inputs.border)` |
| `log` | `File` | `mri_annotation2label.log` |

### Output Extensions

- **border_file**: `.border`

## Docker Tags

Available versions: `latest`, `8.1.0`, `8.0.0`, `7.2.0`, `7.3.0`, `7.3.1`, `7.3.2`, `7.4.1`, `7.1.1`, `6.0`

## Categories

- Structural MRI > FreeSurfer > Parcellation

## Documentation

[Official Documentation](https://surfer.nmr.mgh.harvard.edu/fswiki/mri_annotation2label)
