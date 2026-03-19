# ASL Calibration (asl_calib)

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Calibrates ASL perfusion data to absolute CBF units (ml/100g/min) using an M0 calibration image.

**Modality:** Perfusion image (3D NIfTI) plus M0 calibration image and structural reference.

**Typical Use:** Converting relative perfusion signals to absolute CBF values.

## Key Parameters

-i (perfusion image), -c (M0 calibration image), -s (structural image), --mode (voxelwise or reference region), --tr (TR of calibration)

## Key Points

Two modes: voxelwise (divides each voxel by local M0) or reference region (uses CSF M0 as reference). Reference region mode more robust to coil sensitivity variations.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `calib_image` | `File` | Yes | Calibration image (M0/proton density) | `-c` |
| `perfusion` | `File` | No | CBF image for calibration (ASL native space) | `-i` |
| `structural` | `File` | No | Structural image (already BETed) | `-s` |
| `transform` | `File` | No | ASL-to-structural transformation matrix | `-t` |
| `mask` | `File` | No | Reference mask in calibration image space | `-m` |
| `bmask` | `File` | No | Brain mask (ASL space) for sensitivity or tissue T1 estimation | `--bmask` |
| `output_dir` | `string` | No | Output directory name | `-o` |
| `output_file` | `string` | No | Output filename for calibrated image (requires -i) | `--of` |
| `mode` | `string` | No | Calibration mode (longtr or satrecov) | `--mode` |
| `tissref` | `string` | No | Tissue reference type (csf, wm, gm, none) | `--tissref` |
| `te` | `double` | No | TE used in sequence (ms) | `--te` |
| `tr` | `double` | No | TR used in calibration sequence (s, default 3.2, longtr mode) | `--tr` |
| `cgain` | `double` | No | Relative gain between calibration and ASL data (default 1, longtr mode) | `--cgain` |
| `t2star` | `boolean` | No | Correct with T2* rather than T2 | `--t2star` |
| `t1r` | `double` | No | T1 of reference tissue (s) | `--t1r` |
| `t2r` | `double` | No | T2(*) of reference tissue (ms) | `--t2r` |
| `t2b` | `double` | No | T2(*) of blood (ms) | `--t2b` |
| `pc` | `double` | No | Partition co-efficient | `--pc` |
| `csfmaskingoff` | `boolean` | No | Turn off ventricle masking (segmentation only) | `--csfmaskingoff` |
| `str2std` | `File` | No | Structural to MNI152 linear registration (.mat) | `--str2std` |
| `warp` | `File` | No | Structural to MNI152 non-linear registration (warp) | `--warp` |

### Accepted Input Extensions

- **calib_image**: `.nii`, `.nii.gz`
- **perfusion**: `.nii`, `.nii.gz`
- **structural**: `.nii`, `.nii.gz`
- **transform**: `.mat`
- **mask**: `.nii`, `.nii.gz`
- **bmask**: `.nii`, `.nii.gz`
- **str2std**: `.mat`
- **warp**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `output_directory` | `Directory` | `$(inputs.output_dir)` |
| `calibrated_perfusion` | `File` | `$(inputs.output_file).nii.gz`, `$(inputs.output_file).nii` |
| `log` | `File` | `asl_calib.log` |
| `err_log` | `File` | `asl_calib.err.log` |

### Output Extensions

- **calibrated_perfusion**: `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Arterial Spin Labeling > FSL > ASL Processing

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/BASIL)
