# AFNI 3D Undump (Coordinate to Volume)

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Creates a 3D dataset from a text file containing voxel coordinates and values.

**Modality:** Text coordinate file plus master dataset for grid definition.

**Typical Use:** Creating spherical ROIs from peak coordinates.

## Key Parameters

-prefix (output), -master (template grid), -xyz (coordinates are in mm), -srad (sphere radius in mm)

## Key Points

Use -srad to create spherical ROIs at each coordinate. Master dataset defines output grid.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input coordinate text file |  |
| `prefix` | `string` | Yes | Output dataset prefix | `-prefix` |
| `master` | `File` | No | Master dataset determining output geometry | `-master` |
| `dimen` | `int[]` | No | Set output dimensions (I J K voxels) |  |
| `mask` | `File` | No | Mask controlling which voxels receive values | `-mask` |
| `datum` | `enum` | No | Voxel data type (default short) | `-datum` |
| `dval` | `double` | No | Default value for unspecified input voxels (default 1) | `-dval` |
| `fval` | `double` | No | Fill value for unlisted voxels (default 0) | `-fval` |
| `ijk` | `boolean` | No | Input coordinates as (i,j,k) index triples | `-ijk` |
| `xyz` | `boolean` | No | Input coordinates as (x,y,z) spatial mm coordinates | `-xyz` |
| `orient` | `string` | No | Coordinate order (3-letter code) | `-orient` |
| `srad` | `double` | No | Sphere radius around each input point | `-srad` |
| `cubes` | `boolean` | No | Use cubes instead of spheres | `-cubes` |
| `ROImask` | `File` | No | Specify voxel values via ROI dataset labels | `-ROImask` |
| `head_only` | `boolean` | No | Create only .HEAD file | `-head_only` |
| `allow_NaN` | `boolean` | No | Permit NaN floating-point values | `-allow_NaN` |

### Accepted Input Extensions

- **input**: `.1D`, `.txt`
- **master**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **mask**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **ROImask**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `dataset` | `File` | `$(inputs.prefix)+orig.HEAD`, `$(inputs.prefix)+tlrc.HEAD` |
| `log` | `File` | `$(inputs.prefix).log` |

### Output Extensions

- **dataset**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Enum Options

**`datum`**: `byte`, `short`, `float`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Utilities > AFNI > ROI Utilities

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dUndump.html)
