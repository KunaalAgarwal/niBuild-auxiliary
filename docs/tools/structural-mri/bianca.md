# Brain Intensity AbNormality Classification Algorithm (BIANCA)

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Automated white matter hyperintensity (WMH) segmentation using supervised machine learning (k-nearest neighbor) trained on manually labeled data.

**Modality:** T1-weighted and FLAIR images (3D NIfTI), plus training data with manual WMH masks.

**Typical Use:** Automated white matter lesion segmentation in aging, small vessel disease, or MS studies.

## Key Parameters

--singlefile (input file list), --labelfeaturenum (which feature is the manual label), --brainmaskfeaturenum (brain mask feature), --querysubjectnum (subject to segment), --trainingnums (training subjects)

## Key Points

Requires training data with manual WMH labels. Uses spatial and intensity features. Performance depends on training data quality and similarity to test data.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `singlefile` | `File` | Yes | Master file listing subjects, images, masks, and transformations | `--singlefile=` |
| `training_data` | `Directory` | Yes | Directory containing all subject data files referenced in master file |  |
| `querysubjectnum` | `int` | Yes | Row number in master file for the subject to segment | `--querysubjectnum=` |
| `brainmaskfeaturenum` | `int` | Yes | Column number in master file containing brain mask | `--brainmaskfeaturenum=` |
| `labelfeaturenum` | `int` | Yes | Column number in master file containing manual lesion mask | `--labelfeaturenum=` |
| `trainingnums` | `string` | Yes | Training subject row numbers (comma-separated) or "all" | `--trainingnums=` |
| `output_name` | `string` | Yes | Output file basename | `-o` |
| `featuresubset` | `string` | No | Comma-separated column numbers for intensity features | `--featuresubset=` |
| `matfeaturenum` | `int` | No | Column number containing MNI transformation matrices | `--matfeaturenum=` |
| `spatialweight` | `double` | No | Weighting for MNI spatial coordinates (default 1) | `--spatialweight=` |
| `patchsizes` | `string` | No | Patch sizes in voxels (comma-separated) | `--patchsizes=` |
| `patch3D` | `boolean` | No | Enable 3D patch processing | `--patch3D` |
| `selectpts` | `enum` | No | Non-lesion point selection strategy | `--selectpts=` |
| `trainingpts` | `string` | No | Max lesion training points per subject (number or "equalpoints") | `--trainingpts=` |
| `nonlespts` | `int` | No | Max non-lesion points per subject | `--nonlespts=` |
| `saveclassifierdata` | `string` | No | Save training data to specified file | `--saveclassifierdata=` |
| `loadclassifierdata` | `string` | No | Load pre-saved classifier data from file | `--loadclassifierdata=` |
| `verbose` | `boolean` | No | Verbose output | `-v` |

### Accepted Input Extensions

- **singlefile**: `.txt`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `wmh_map` | `File` | `$(inputs.output_name).nii.gz`, `$(inputs.output_name)` |
| `log` | `File` | `bianca.log` |
| `err_log` | `File` | `bianca.err.log` |

### Output Extensions

- **wmh_map**: `.nii.gz`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Structural MRI > FSL > Lesion Segmentation

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/BIANCA)
