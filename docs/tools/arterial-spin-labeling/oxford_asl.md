# Oxford ASL Processing Pipeline

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Multi-step pipeline for ASL MRI quantification. Internally chains motion correction, registration, BASIL kinetic modeling, calibration, and partial volume correction.

**Modality:** 4D ASL NIfTI (tag/control pairs) plus structural T1 image.

**Typical Use:** Complete ASL quantification from raw data to calibrated CBF maps.

## Key Parameters

-i (input ASL), -o (output dir), -s (structural image), --casl/--pasl (labeling type), --iaf (input format: tc/ct/diff), --tis (inversion times)

## Key Points

Handles both pASL and CASL/pCASL. Performs kinetic modeling via BASIL internally. Use --wp for white paper quantification mode. Requires calibration image for absolute CBF.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input ASL data | `-i` |
| `output_dir` | `string` | Yes | Output directory name | `-o` |
| `mask` | `File` | No | Mask in native ASL space | `-m` |
| `spatial` | `boolean` | No | Perform analysis with automatic spatial smoothing of CBF | `--spatial` |
| `structural` | `File` | No | Structural (T1) image (already BETed) | `-s` |
| `casl` | `boolean` | No | Data is CASL/pCASL (continuous ASL) rather than pASL | `--casl` |
| `artsupp` | `boolean` | No | Arterial suppression (vascular crushing) was used | `--artsupp` |
| `tis` | `string` | No | Inversion times (comma-separated) | `--tis` |
| `bolus` | `double` | No | Bolus duration (seconds) | `--bolus` |
| `bat` | `double` | No | Bolus arrival time (seconds) | `--bat` |
| `t1` | `double` | No | Tissue T1 value (default 1.3) | `--t1` |
| `t1b` | `double` | No | Blood T1 value (default 1.65) | `--t1b` |
| `slicedt` | `double` | No | Timing difference between slices (default 0) | `--slicedt` |
| `calib` | `File` | No | Calibration (M0) image | `-c` |
| `M0` | `double` | No | Precomputed M0 value | `--M0` |
| `alpha` | `double` | No | Inversion efficiency (default 0.98 pASL, 0.85 cASL) | `--alpha` |
| `tr` | `double` | No | TR of calibration data (default 3.2s) | `--tr` |
| `wp` | `boolean` | No | Use white paper quantification | `--wp` |
| `senscorr` | `boolean` | No | Use bias field from segmentation for sensitivity correction | `--senscorr` |
| `vars` | `boolean` | No | Also save parameter estimated variances | `--vars` |
| `report` | `boolean` | No | Report mean perfusion within GM mask (requires structural) | `--report` |
| `norm` | `boolean` | No | Output perfusion maps normalised by GM mean (requires structural) | `--norm` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`
- **mask**: `.nii`, `.nii.gz`
- **structural**: `.nii`, `.nii.gz`
- **calib**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `output_directory` | `Directory` | `$(inputs.output_dir)` |
| `perfusion` | `File` | `$(inputs.output_dir)/native_space/perfusion.nii.gz` |
| `arrival` | `File` | `$(inputs.output_dir)/native_space/arrival.nii.gz` |
| `log` | `File` | `oxford_asl.log` |
| `err_log` | `File` | `oxford_asl.err.log` |

### Output Extensions

- **perfusion**: `.nii.gz`
- **arrival**: `.nii.gz`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Arterial Spin Labeling > FSL > ASL Processing
- Pipelines > FSL > ASL

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/BASIL)
