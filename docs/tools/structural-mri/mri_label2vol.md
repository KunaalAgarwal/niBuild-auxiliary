# FreeSurfer Label to Volume Conversion

**Library:** FreeSurfer | **Docker Image:** `freesurfer/freesurfer`

## Function

Converts surface-based labels to volumetric ROIs using a registration matrix.

**Modality:** FreeSurfer label file plus template volume and registration.

**Typical Use:** Creating volumetric ROIs from FreeSurfer surface parcellations.

## Key Parameters

--label (input label), --temp (template volume), --reg (registration file), --o (output volume), --proj (projection parameters)

## Key Points

Requires registration between surface and target volume space. Use --proj to control projection depth.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `subjects_dir` | `Directory` | Yes | FreeSurfer SUBJECTS_DIR |  |
| `fs_license` | `File` | Yes | FreeSurfer license file |  |
| `label` | `File` | No | Label file to convert | `--label` |
| `annot` | `File` | No | Annotation file to convert | `--annot` |
| `seg` | `File` | No | Segmentation file to convert | `--seg` |
| `temp` | `File` | Yes | Template volume for output geometry | `--temp` |
| `output` | `string` | Yes | Output volume filename | `--o` |
| `reg` | `File` | No | Registration file (source to anat) | `--reg` |
| `identity` | `boolean` | No | Use identity matrix for registration | `--identity` |
| `subject` | `string` | No | Subject name for surface labels | `--subject` |
| `hemi` | `enum` | No | Hemisphere for surface labels | `--hemi` |
| `proj` | `string` | No | Projection method and parameters (frac/abs start stop delta) | `--proj` |
| `fill_thresh` | `double` | No | Fill threshold (0-1) | `--fillthresh` |
| `label_voxel_volume` | `boolean` | No | Fill with voxel volume instead of 1 | `--label-voxel-volume` |
| `native_vox2ras` | `boolean` | No | Use native vox2ras | `--native-vox2ras` |
| `surf` | `string` | No | Surface name for projection (default white) | `--surf` |
| `hits` | `string` | No | Save hits volume | `--hits` |
| `labvoxvol` | `boolean` | No | Label with voxel volume | `--labvoxvol` |

### Accepted Input Extensions

- **label**: `.label`
- **annot**: `.annot`
- **seg**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`
- **temp**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`
- **reg**: `.dat`, `.lta`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `label_volume` | `File` | `$(inputs.output)*` |
| `hits_volume` | `File` | `$(inputs.hits)` |
| `log` | `File` | `mri_label2vol.log` |

### Output Extensions

- **label_volume**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`
- **hits_volume**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `8.1.0`, `8.0.0`, `7.2.0`, `7.3.0`, `7.3.1`, `7.3.2`, `7.4.1`, `7.1.1`, `6.0`

## Categories

- Structural MRI > FreeSurfer > Parcellation

## Documentation

[Official Documentation](https://surfer.nmr.mgh.harvard.edu/fswiki/mri_label2vol)
