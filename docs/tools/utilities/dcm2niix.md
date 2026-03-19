# DICOM to NIfTI Converter (dcm2niix)

**Library:** dcm2niix | **Docker Image:** `xnat/dcm2niix`

## Function

Converts DICOM medical images to NIfTI format with BIDS-compatible JSON sidecar files, preserving acquisition metadata.

**Modality:** DICOM image directory from any MRI acquisition.

**Typical Use:** First step in any neuroimaging pipeline: converting raw DICOM acquisitions to analysis-ready NIfTI.

## Key Parameters

-o (output directory), -f (filename format), -z (compression: y/n/o/i), -b (BIDS sidecar: y/n/o)

## Key Points

Generates BIDS-compatible JSON sidecars. Handles multi-echo, diffusion (bval/bvec), and Philips/Siemens/GE formats. Default filename format is %f_%p_%t_%s.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input_dir` | `Directory` | Yes | Input DICOM directory |  |
| `filename` | `string` | No | Output filename format (default %f_%p_%t_%s) | `-f` |
| `compress` | `enum` | No | Compression (y=pigz, o=optimal, i=internal, n=none, 3=save .nii and .gz) | `-z` |
| `merge` | `enum` | No | Merge 2D slices (0=no, 1=yes, 2=auto) | `-m` |
| `single_file` | `enum` | No | Single file mode for 4D (y/n) | `-s` |
| `bids` | `enum` | No | BIDS sidecar (y=yes, n=no, o=only) | `-b` |
| `anonymize` | `enum` | No | Anonymize BIDS sidecar (y/n) | `-ba` |
| `ignore_derived` | `boolean` | No | Ignore derived/localizer/2D images | `-i` |
| `verbose` | `enum` | No | Verbosity level (0=none, 1=some, 2=all) | `-v` |

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `nifti_files` | `File[]` | `*.nii.gz`, `*.nii` |
| `json_sidecars` | `File[]` | `*.json` |
| `bval_files` | `File[]` | `*.bval` |
| `bvec_files` | `File[]` | `*.bvec` |
| `log` | `File` | `dcm2niix.log` |

### Output Extensions

- **nifti_files**: `.nii`, `.nii.gz`
- **json_sidecars**: `.json`
- **bval_files**: `.bval`
- **bvec_files**: `.bvec`

## Docker Tags

Available versions: `latest`, `1.0.20240202`

## Categories

- Utilities > dcm2niix > Format Conversion

## Documentation

[Official Documentation](https://github.com/rordenlab/dcm2niix)
