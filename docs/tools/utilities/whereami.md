# AFNI Atlas Location Query (whereami)

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Reports anatomical atlas labels for given coordinates or identifies regions in multiple atlases simultaneously.

**Modality:** MNI or Talairach coordinates, or labeled dataset.

**Typical Use:** Identifying anatomical locations of activation peaks.

## Key Parameters

-coord_file (coordinate file), -atlas (atlas name), -lpi/-rai (coordinate system)

## Key Points

Queries multiple atlases at once by default. Coordinates must match atlas space.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `coord` | `double[]` | No | Brain location in mm (x y z) |  |
| `coord_file` | `File` | No | Input coordinates from file | `-coord_file` |
| `lpi` | `boolean` | No | Input uses LPI/SPM orientation | `-lpi` |
| `rai` | `boolean` | No | Input uses RAI/DICOM orientation | `-rai` |
| `atlas` | `string` | No | Specify atlas(es) to use | `-atlas` |
| `show_atlas_code` | `boolean` | No | Show integer code to area label map | `-show_atlas_code` |
| `show_atlas_region` | `string` | No | Show region using symbolic notation (Atlas:Side:Area) | `-show_atlas_region` |
| `mask_atlas_region` | `string` | No | Create mask for specified region | `-mask_atlas_region` |
| `prefix` | `string` | No | Output prefix for mask datasets | `-prefix` |
| `space` | `string` | No | Template space (MNI, TLRC, etc.) | `-space` |
| `dset` | `File` | No | Determine template space from reference dataset | `-dset` |
| `max_areas` | `int` | No | Maximum distinct areas to report | `-max_areas` |
| `max_search_radius` | `double` | No | Maximum search distance | `-max_search_radius` |
| `min_prob` | `double` | No | Minimum probability threshold for probabilistic atlases | `-min_prob` |
| `bmask` | `File` | No | Report overlap of non-zero voxels with atlas regions | `-bmask` |
| `omask` | `File` | No | Report each ROI overlap separately | `-omask` |
| `classic` | `boolean` | No | Standard output format | `-classic` |
| `tab` | `boolean` | No | Tab-delimited output format | `-tab` |

### Accepted Input Extensions

- **coord_file**: `.1D`, `.txt`
- **dset**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **bmask**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **omask**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `output` | `stdout` |  |
| `mask_output` | `File` | `$(inputs.prefix)+tlrc.*`, `$(inputs.prefix)+orig.*`, `$(inputs.prefix).nii*` |
| `log` | `File` | `whereami.log` |

### Output Extensions

- **output**: `.txt`
- **mask_output**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`, `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Utilities > AFNI > ROI Utilities

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/whereami.html)
