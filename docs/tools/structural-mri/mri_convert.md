# FreeSurfer MRI Format Conversion (mri_convert)

**Library:** FreeSurfer | **Docker Image:** `freesurfer/freesurfer`

## Function

Converts between neuroimaging file formats (DICOM, NIfTI, MGH/MGZ, ANALYZE, etc.) with optional resampling and conforming.

**Modality:** Any neuroimaging volume format.

**Typical Use:** Converting DICOM to NIfTI, conforming images to FreeSurfer standards.

## Key Parameters

--conform (resample to 256 cubed at 1mm isotropic), --out_type (output format), -vs (voxel size)

## Key Points

Use --conform to prepare T1 for FreeSurfer processing. Handles DICOM to NIfTI conversion. Can change voxel size and data type.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `subjects_dir` | `Directory` | Yes | FreeSurfer SUBJECTS_DIR |  |
| `fs_license` | `File` | Yes | FreeSurfer license file |  |
| `input` | `File` | Yes | Input volume file |  |
| `output` | `string` | Yes | Output filename |  |
| `in_type` | `string` | No | Input file format (cor, mgh, mgz, minc, analyze, nifti1, nii) | `--in_type` |
| `out_type` | `string` | No | Output file format (cor, mgh, mgz, minc, analyze, nifti1, nii) | `--out_type` |
| `conform` | `boolean` | No | Conform to 1mm voxel size in coronal slices | `--conform` |
| `conform_min` | `boolean` | No | Conform to minimum voxel direction size | `--conform_min` |
| `conform_size` | `double` | No | Conform to specified voxel size in mm | `--conform_size` |
| `vox_size` | `string` | No | Output voxel size (x y z) in mm | `--voxsize` |
| `out_orientation` | `string` | No | Output orientation (e.g., RAS, LPS) | `--out_orientation` |
| `in_orientation` | `string` | No | Input orientation (e.g., RAS, LPS) | `--in_orientation` |
| `resample_type` | `enum` | No | Interpolation method | `--resample_type` |
| `reslice_like` | `File` | No | Reslice to match template geometry | `--reslice_like` |
| `apply_transform` | `File` | No | Apply transformation (xfm or m3z) | `--apply_transform` |
| `apply_inverse_transform` | `File` | No | Apply inverse transformation | `--apply_inverse_transform` |
| `crop` | `string` | No | Crop to 256 around center (x y z) | `--crop` |
| `cropsize` | `string` | No | Crop to specified size (dx dy dz) | `--cropsize` |
| `frame` | `int` | No | Keep specified 0-based frame number | `--frame` |
| `mid_frame` | `boolean` | No | Keep only middle frame | `--mid-frame` |
| `nskip` | `int` | No | Skip first n frames | `--nskip` |
| `ndrop` | `int` | No | Drop last n frames | `--ndrop` |
| `out_data_type` | `enum` | No | Output data type | `--out_data_type` |
| `fwhm` | `double` | No | Smooth input volume by FWHM in mm | `--fwhm` |
| `no_scale` | `boolean` | No | Do not rescale values for COR | `--no_scale` |
| `force_ras` | `boolean` | No | Use default when orientation info absent | `--force_ras_good` |
| `split` | `boolean` | No | Split output frames into separate files | `--split` |
| `ascii` | `boolean` | No | Save output as ASCII | `--ascii` |
| `read_only` | `boolean` | No | Read-only mode (no output written) | `--read_only` |

### Accepted Input Extensions

- **input**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`, `.img`, `.hdr`, `.mnc`
- **reslice_like**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`
- **apply_transform**: `.xfm`, `.m3z`, `.lta`
- **apply_inverse_transform**: `.xfm`, `.m3z`, `.lta`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `converted` | `File` | `$(inputs.output)*` |
| `log` | `File` | `mri_convert.log` |

### Output Extensions

- **converted**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`

## Enum Options

**`resample_type`**: `interpolate`, `weighted`, `nearest`, `sinc`, `cubic`

## Docker Tags

Available versions: `latest`, `8.1.0`, `8.0.0`, `7.2.0`, `7.3.0`, `7.3.1`, `7.3.2`, `7.4.1`, `7.1.1`, `6.0`

## Categories

- Structural MRI > FreeSurfer > Surface Reconstruction
- Utilities > FreeSurfer > Format Conversion

## Documentation

[Official Documentation](https://surfer.nmr.mgh.harvard.edu/fswiki/mri_convert)
