# FreeSurfer Segmentation Statistics

**Library:** FreeSurfer | **Docker Image:** `freesurfer/freesurfer`

## Function

Computes volume and intensity statistics for each region in a segmentation volume.

**Modality:** Segmentation volume (e.g., aseg.mgz) plus optional intensity volume.

**Typical Use:** Extracting regional volumes and mean intensities per structure.

## Key Parameters

--seg (segmentation), --i (intensity volume), --ctab (color table), --sum (output summary file), --excludeid 0 (exclude background)

## Key Points

Reports volume, mean intensity, and other statistics per region. Can use any segmentation volume.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `subjects_dir` | `Directory` | Yes | FreeSurfer SUBJECTS_DIR |  |
| `fs_license` | `File` | Yes | FreeSurfer license file |  |
| `seg` | `File` | Yes | Segmentation volume | `--seg` |
| `sum` | `string` | Yes | Output summary file | `--sum` |
| `in` | `File` | No | Input volume for intensity statistics | `--in` |
| `ctab` | `File` | No | Color table file (e.g., FreeSurferColorLUT.txt) | `--ctab` |
| `ctab_default` | `boolean` | No | Use default FreeSurfer color table | `--ctab-default` |
| `annot` | `string` | No | Annotation (subject hemi parc) | `--annot` |
| `slabel` | `string` | No | Surface label (subject hemi label) | `--slabel` |
| `id` | `int[]` | No | Only report these segmentation IDs | `--id` |
| `excludeid` | `int` | No | Exclude this segmentation ID (usually 0) | `--excludeid` |
| `excl_ctxgmwm` | `boolean` | No | Exclude cortex GM and WM | `--excl-ctxgmwm` |
| `nonempty` | `boolean` | No | Only report non-empty segmentations | `--nonempty` |
| `mask` | `File` | No | Mask volume | `--mask` |
| `maskthresh` | `double` | No | Mask threshold | `--maskthresh` |
| `maskinvert` | `boolean` | No | Invert mask | `--maskinvert` |
| `subject` | `string` | No | Subject name | `--subject` |
| `avgwf` | `string` | No | Output average waveform file | `--avgwf` |
| `avgwfvol` | `string` | No | Output average waveform as volume | `--avgwfvol` |
| `sfavg` | `string` | No | Spatial-frame average file | `--sfavg` |
| `brain_vol_from_seg` | `boolean` | No | Compute brain volume from segmentation | `--brain-vol-from-seg` |
| `brainmask` | `File` | No | Brain mask file | `--brainmask` |
| `pv` | `File` | No | Partial volume file | `--pv` |
| `robust` | `double` | No | Compute robust statistics (percent) | `--robust` |
| `euler` | `boolean` | No | Report Euler number | `--euler` |

### Accepted Input Extensions

- **seg**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`
- **in**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`
- **ctab**: `.txt`, `.ctab`
- **mask**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`
- **brainmask**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`
- **pv**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `summary` | `File` | `$(inputs.sum)` |
| `avgwf_file` | `File` | `$(inputs.avgwf)` |
| `avgwfvol_file` | `File` | `$(inputs.avgwfvol)` |
| `log` | `File` | `mri_segstats.log` |

### Output Extensions

- **summary**: `.stats`, `.txt`, `.dat`, `.csv`
- **avgwf_file**: `.txt`, `.dat`
- **avgwfvol_file**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `8.1.0`, `8.0.0`, `7.2.0`, `7.3.0`, `7.3.1`, `7.3.2`, `7.4.1`, `7.1.1`, `6.0`

## Categories

- Structural MRI > FreeSurfer > Morphometry

## Documentation

[Official Documentation](https://surfer.nmr.mgh.harvard.edu/fswiki/mri_segstats)
