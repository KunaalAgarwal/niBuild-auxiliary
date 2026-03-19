# FMRIB's Linear Image Registration Tool (FLIRT)

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Linear (affine) registration between images using optimized cost functions with 6, 7, 9, or 12 degrees of freedom.

**Modality:** Any 3D NIfTI volume pair (structural, functional, or standard template).

**Typical Use:** EPI-to-structural alignment, structural-to-standard registration.

## Key Parameters

-ref (reference image), -dof (degrees of freedom: 6/7/9/12), -cost (cost function), -omat (output matrix)

## Key Points

Use 6-DOF for within-subject rigid-body, 12-DOF for cross-subject affine. Cost function matters: corratio for intra-modal, mutualinfo for inter-modal.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input image | `-in` |
| `reference` | `File` | Yes | Reference image | `-ref` |
| `output` | `string` | Yes | Output registered image filename | `-out` |
| `output_matrix` | `string` | No | Output transformation matrix filename | `-omat` |
| `dof` | `int` | No | Degrees of freedom (6, 7, 9, or 12) | `-dof` |
| `init_matrix` | `File` | No | Initial transformation matrix | `-init` |
| `apply_xfm` | `boolean` | No | Apply transformation (requires init_matrix) | `-applyxfm` |
| `apply_isoxfm` | `double` | No | Apply transformation and resample to isotropic voxels | `-applyisoxfm` |
| `uses_qform` | `boolean` | No | Use qform/sform for initialization | `-usesqform` |
| `rigid2D` | `boolean` | No | Use 2D rigid body mode | `-2D` |
| `cost` | `enum` | No | Cost function | `-cost` |
| `search_cost` | `enum` | No | Search cost function (if different from cost) | `-searchcost` |
| `searchr_x` | `string` | No | X-axis search range in degrees (e.g., "-90 90") | `-searchrx` |
| `searchr_y` | `string` | No | Y-axis search range in degrees | `-searchry` |
| `searchr_z` | `string` | No | Z-axis search range in degrees | `-searchrz` |
| `no_search` | `boolean` | No | Disable angular search | `-nosearch` |
| `coarse_search` | `int` | No | Coarse search angular step (degrees) | `-coarsesearch` |
| `fine_search` | `int` | No | Fine search angular step (degrees) | `-finesearch` |
| `interp` | `enum` | No | Interpolation method | `-interp` |
| `sinc_width` | `int` | No | Sinc window width in voxels | `-sincwidth` |
| `sinc_window` | `enum` | No | Sinc window type | `-sincwindow` |
| `in_weight` | `File` | No | Input weighting volume | `-inweight` |
| `ref_weight` | `File` | No | Reference weighting volume | `-refweight` |
| `bins` | `int` | No | Number of histogram bins | `-bins` |
| `min_sampling` | `double` | No | Minimum voxel dimension for sampling | `-minsampling` |
| `no_clamp` | `boolean` | No | Do not clamp intensities | `-noclamp` |
| `no_resample` | `boolean` | No | Do not resample output | `-noresample` |
| `padding_size` | `int` | No | Padding size | `-paddingsize` |
| `datatype` | `enum` | No | Output data type | `-datatype` |
| `verbose` | `int` | No | Verbosity level (0, 1, or 2) | `-verbose` |
| `wm_seg` | `File` | No | White matter segmentation for BBR | `-wmseg` |
| `bbrslope` | `double` | No | BBR slope value | `-bbrslope` |
| `bbrtype` | `enum` | No | BBR cost variant | `-bbrtype` |
| `fieldmap` | `File` | No | Fieldmap image in rad/s | `-fieldmap` |
| `fieldmapmask` | `File` | No | Fieldmap mask | `-fieldmapmask` |
| `echospacing` | `double` | No | EPI echo spacing in seconds | `-echospacing` |
| `pedir` | `int` | No | Phase encode direction (1, 2, 3, -1, -2, -3) | `-pedir` |
| `schedule` | `File` | No | Custom optimization schedule file | `-schedule` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`
- **reference**: `.nii`, `.nii.gz`
- **init_matrix**: `.mat`
- **in_weight**: `.nii`, `.nii.gz`
- **ref_weight**: `.nii`, `.nii.gz`
- **wm_seg**: `.nii`, `.nii.gz`
- **fieldmap**: `.nii`, `.nii.gz`
- **fieldmapmask**: `.nii`, `.nii.gz`
- **schedule**: `.sch`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `registered_image` | `File` | `$(inputs.output).nii.gz`, `$(inputs.output).nii` |
| `transformation_matrix` | `File` | `$(inputs.output_matrix)` |
| `log` | `File` | `flirt.log` |

### Output Extensions

- **registered_image**: `.nii`, `.nii.gz`
- **transformation_matrix**: `.mat`

## Enum Options

**`cost`**: `mutualinfo`, `corratio`, `normcorr`, `normmi`, `leastsq`, `bbr`

**`interp`**: `trilinear`, `nearestneighbour`, `sinc`, `spline`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Structural MRI > FSL > Registration

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FLIRT)
