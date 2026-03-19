# FreeSurfer MRI White Matter Segmentation

**Library:** FreeSurfer | **Docker Image:** `freesurfer/freesurfer`

## Function

Segments white matter from normalized T1 image using intensity thresholding and morphological operations.

**Modality:** Intensity-normalized T1 volume (T1.mgz from mri_normalize).

**Typical Use:** White matter identification for surface reconstruction.

## Key Parameters

-thicken (thicken WM), -wlo/-whi (WM intensity range)

## Key Points

Part of recon-all. Outputs wm.mgz used for surface reconstruction. Quality depends on good intensity normalization.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `subjects_dir` | `Directory` | Yes | FreeSurfer SUBJECTS_DIR |  |
| `fs_license` | `File` | Yes | FreeSurfer license file |  |
| `input` | `File` | Yes | Input normalized volume (white matter ~110) |  |
| `output` | `string` | Yes | Output segmentation filename |  |
| `wlo` | `double` | No | White matter low intensity threshold | `-wlo` |
| `whi` | `double` | No | White matter high intensity threshold | `-whi` |
| `glo` | `double` | No | Gray matter low intensity threshold | `-glo` |
| `ghi` | `double` | No | Gray matter high intensity threshold | `-ghi` |
| `thicken` | `int` | No | Thicken option (0 to disable) | `-thicken` |
| `nseg` | `int` | No | Number of segmentation classes | `-nseg` |
| `mprage` | `boolean` | No | Assume MPRAGE contrast (darker gray matter) | `-mprage` |
| `slope` | `double` | No | Slope for threshold adjustment | `-slope` |
| `nmin` | `int` | No | Minimum number of white matter voxels | `-nmin` |
| `keep` | `boolean` | No | Keep intermediate files | `-keep` |

### Accepted Input Extensions

- **input**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `segmentation` | `File` | `$(inputs.output)*` |
| `log` | `File` | `mri_segment.log` |

### Output Extensions

- **segmentation**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `8.1.0`, `8.0.0`, `7.2.0`, `7.3.0`, `7.3.1`, `7.3.2`, `7.4.1`, `7.1.1`, `6.0`

## Categories

- Structural MRI > FreeSurfer > Surface Reconstruction

## Documentation

[Official Documentation](https://surfer.nmr.mgh.harvard.edu/fswiki/mri_segment)
