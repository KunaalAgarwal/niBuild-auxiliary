# AFNI 3D Dataset Information (3dinfo)

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Displays header information and metadata from AFNI/NIfTI datasets.

**Modality:** Any NIfTI or AFNI format dataset.

**Typical Use:** Quality control, scripting decisions based on data properties.

## Key Parameters

-n4 (dimensions), -tr (TR), -orient (orientation), -prefix (prefix only), -space (coordinate space)

## Key Points

Essential for scripting and QC. Use specific flags for machine-readable output.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input dataset |  |
| `verb` | `boolean` | No | Output extensive information | `-verb` |
| `VERB` | `boolean` | No | Additional details including slice timing | `-VERB` |
| `short` | `boolean` | No | Minimal output (default) | `-short` |
| `no_hist` | `boolean` | No | Omit history text | `-no_hist` |
| `exists` | `boolean` | No | Returns 1 if loadable, 0 otherwise | `-exists` |
| `id` | `boolean` | No | Display idcode string | `-id` |
| `prefix` | `boolean` | No | Return dataset prefix | `-prefix` |
| `prefix_noext` | `boolean` | No | Return prefix without extensions | `-prefix_noext` |
| `space` | `boolean` | No | Show coordinate space | `-space` |
| `is_nifti` | `boolean` | No | Indicate NIFTI format | `-is_nifti` |
| `is_oblique` | `boolean` | No | Report obliquity status | `-is_oblique` |
| `handedness` | `boolean` | No | Return L or R for orientation | `-handedness` |
| `ni` | `boolean` | No | Voxel count in i dimension | `-ni` |
| `nj` | `boolean` | No | Voxel count in j dimension | `-nj` |
| `nk` | `boolean` | No | Voxel count in k dimension | `-nk` |
| `nt` | `boolean` | No | Number of time points | `-nt` |
| `nv` | `boolean` | No | Number of sub-bricks | `-nv` |
| `nijk` | `boolean` | No | Total voxel count | `-nijk` |
| `di` | `boolean` | No | Signed voxel displacement in i | `-di` |
| `dj` | `boolean` | No | Signed voxel displacement in j | `-dj` |
| `dk` | `boolean` | No | Signed voxel displacement in k | `-dk` |
| `tr` | `boolean` | No | Repetition time in seconds | `-tr` |
| `voxvol` | `boolean` | No | Voxel volume in cubic mm | `-voxvol` |
| `dmin` | `boolean` | No | Minimum value | `-dmin` |
| `dmax` | `boolean` | No | Maximum value | `-dmax` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `info` | `stdout` |  |
| `log` | `File` | `3dinfo.log` |

### Output Extensions

- **info**: `.txt`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Utilities > AFNI > Dataset Operations

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dinfo.html)
