# FreeSurfer Geometric Transfer Matrix Partial Volume Correction

**Library:** FreeSurfer | **Docker Image:** `freesurfer/freesurfer`

## Function

Performs partial volume correction for PET data using the geometric transfer matrix method based on high-resolution anatomical segmentation.

**Modality:** PET volume (3D NIfTI/MGZ) plus FreeSurfer segmentation (aparc+aseg).

**Typical Use:** Partial volume correction of PET data using anatomical segmentation.

## Key Parameters

--i (input PET), --seg (segmentation), --reg (registration to anatomy), --psf (point spread function FWHM in mm), --o (output directory)

## Key Points

Accounts for PET spatial resolution blurring across tissue boundaries. PSF should match scanner resolution (~4-6mm).

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `subjects_dir` | `Directory` | Yes | FreeSurfer SUBJECTS_DIR |  |
| `fs_license` | `File` | Yes | FreeSurfer license file |  |
| `input` | `File` | Yes | Input PET image | `--i` |
| `psf` | `double` | Yes | Point spread function FWHM (mm) | `--psf` |
| `seg` | `File` | Yes | Segmentation file | `--seg` |
| `output_dir` | `string` | Yes | Output directory | `--o` |
| `auto_mask_fwhm` | `double` | No | Auto-mask smoothing FWHM (mm) | `--auto-mask` |
| `auto_mask_thresh` | `double` | No | Auto-mask threshold (use with auto_mask_fwhm) |  |
| `reg` | `File` | No | Registration file (LTA or reg.dat) | `--reg` |
| `regheader` | `boolean` | No | Assume registration is identity (header registration) | `--regheader` |
| `no_rescale` | `boolean` | No | Do not global rescale | `--no-rescale` |
| `no_reduce_fov` | `boolean` | No | Do not reduce FOV | `--no-reduce-fov` |
| `default_seg_merge` | `boolean` | No | Use default scheme to merge hemispheres and set tissue types | `--default-seg-merge` |
| `ctab_default` | `boolean` | No | Use default FreeSurfer color table with tissue types | `--ctab-default` |
| `vg_thresh` | `double` | No | Volume geometry threshold for registration check | `--vg-thresh` |

### Accepted Input Extensions

- **input**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`
- **seg**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`
- **reg**: `.lta`, `.dat`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `output_directory` | `Directory` | `$(inputs.output_dir)` |
| `gtm_stats` | `File` | `$(inputs.output_dir)/gtm.stats.dat` |
| `log` | `File` | `mri_gtmpvc.log` |
| `err_log` | `File` | `mri_gtmpvc.err.log` |

### Output Extensions

- **gtm_stats**: `.dat`

## Docker Tags

Available versions: `latest`, `8.1.0`, `8.0.0`, `7.2.0`, `7.3.0`, `7.3.1`, `7.3.2`, `7.4.1`, `7.1.1`, `6.0`

## Categories

- PET > FreeSurfer > PET Processing

## Documentation

[Official Documentation](https://surfer.nmr.mgh.harvard.edu/fswiki/PetSurfer)
