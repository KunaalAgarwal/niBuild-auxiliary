# FreeSurfer Cortical Atlas Labeling

**Library:** FreeSurfer | **Docker Image:** `freesurfer/freesurfer`

## Function

Applies a cortical parcellation atlas to an individual subject using trained classifier on spherical surface.

**Modality:** FreeSurfer subject directory with sphere.reg (requires completed recon-all).

**Typical Use:** Applying cortical parcellation atlas to individual subjects.

## Key Parameters

<subject> <hemisphere> <sphere.reg> <atlas.gcs> <output_annotation>

## Key Points

Uses Gaussian classifier atlas trained on manual labels. Part of recon-all. Different atlases available.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `subjects_dir` | `Directory` | Yes | FreeSurfer SUBJECTS_DIR |  |
| `fs_license` | `File` | Yes | FreeSurfer license file |  |
| `subject` | `string` | Yes | Subject name |  |
| `hemi` | `enum` | Yes | Hemisphere (lh or rh) |  |
| `canonsurf` | `File` | Yes | Canonical surface (e.g., sphere.reg) |  |
| `classifier` | `File` | Yes | Atlas classifier file (.gcs) |  |
| `output` | `string` | Yes | Output annotation filename |  |
| `aseg` | `File` | No | Aseg volume for additional context | `-aseg` |
| `l` | `File` | No | Label file to restrict annotation | `-l` |
| `seed` | `int` | No | Random seed | `-seed` |
| `t` | `File` | No | Color table for output | `-t` |
| `orig` | `string` | No | Original surface name | `-orig` |
| `sdir` | `string` | No | Subjects directory | `-sdir` |
| `novar` | `boolean` | No | Do not use variance in classification | `-novar` |
| `nbrs` | `int` | No | Number of neighbors for classification | `-nbrs` |

### Accepted Input Extensions

- **canonsurf**: `.sphere.reg`, `.sphere`
- **classifier**: `.gcs`
- **aseg**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`
- **l**: `.label`
- **t**: `.txt`, `.ctab`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `annotation` | `File` | `$(inputs.output)*` |
| `log` | `File` | `mris_ca_label.log` |

### Output Extensions

- **annotation**: `.annot`

## Docker Tags

Available versions: `latest`, `8.1.0`, `8.0.0`, `7.2.0`, `7.3.0`, `7.3.1`, `7.3.2`, `7.4.1`, `7.1.1`, `6.0`

## Categories

- Structural MRI > FreeSurfer > Parcellation

## Documentation

[Official Documentation](https://surfer.nmr.mgh.harvard.edu/fswiki/mris_ca_label)
