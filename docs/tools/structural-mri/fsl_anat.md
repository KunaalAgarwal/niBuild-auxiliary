# FSL Anatomical Processing Pipeline

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Comprehensive automated pipeline for structural T1 processing including reorientation, cropping, bias correction, registration, segmentation, and subcortical segmentation.

**Modality:** T1-weighted 3D NIfTI volume.

**Typical Use:** Full structural preprocessing from T1 image.

## Key Parameters

-i (input image), --noseg (skip segmentation), --nosubcortseg (skip subcortical), --nononlinreg (skip non-linear registration)

## Key Points

Runs BET, FAST, FLIRT, FNIRT, and FIRST in sequence. Creates output directory with all intermediate files. Good for standardized structural processing.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input structural image | `-i` |
| `output_dir` | `string` | No | Output directory name | `-o` |
| `t2` | `boolean` | No | Input is T2-weighted (default T1) | `--t2` |
| `weakbias` | `boolean` | No | Use weak bias field correction | `--weakbias` |
| `noreorient` | `boolean` | No | Skip reorientation to standard | `--noreorient` |
| `nocrop` | `boolean` | No | Skip robustfov cropping | `--nocrop` |
| `nobias` | `boolean` | No | Skip bias field correction | `--nobias` |
| `noreg` | `boolean` | No | Skip registration to standard space | `--noreg` |
| `nononlinreg` | `boolean` | No | Skip non-linear registration | `--nononlinreg` |
| `noseg` | `boolean` | No | Skip tissue segmentation | `--noseg` |
| `nosubcortseg` | `boolean` | No | Skip subcortical segmentation (FIRST) | `--nosubcortseg` |
| `nocleanup` | `boolean` | No | Do not remove intermediate files | `--nocleanup` |
| `betfparam` | `double` | No | BET -f parameter (brain extraction threshold) | `--betfparam=` |
| `bias_smoothing` | `double` | No | Bias field smoothing (mm) | `-s` |
| `clobber` | `boolean` | No | Overwrite existing output directory | `--clobber` |
| `nosearch` | `boolean` | No | Do not search for existing .anat directory | `--nosearch` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `output_directory` | `Directory` | `$( (inputs.output_dir ? inputs.output_dir : inputs.input.nameroot.replace(/\.nii$/, "")) + ".anat")` |
| `t1` | `File` | `$( (inputs.output_dir ? inputs.output_dir : inputs.input.nameroot.replace(/\.nii$/, "")) + ".anat")/T1.nii.gz`, `$( (inputs.output_dir ? inputs.output_dir : inputs.input.nameroot.replace(/\.nii$/, "")) + ".anat")/T1.nii` |
| `t1_brain` | `File` | `$( (inputs.output_dir ? inputs.output_dir : inputs.input.nameroot.replace(/\.nii$/, "")) + ".anat")/T1_brain.nii.gz`, `$( (inputs.output_dir ? inputs.output_dir : inputs.input.nameroot.replace(/\.nii$/, "")) + ".anat")/T1_brain.nii` |
| `t1_brain_mask` | `File` | `$( (inputs.output_dir ? inputs.output_dir : inputs.input.nameroot.replace(/\.nii$/, "")) + ".anat")/T1_brain_mask.nii.gz`, `$( (inputs.output_dir ? inputs.output_dir : inputs.input.nameroot.replace(/\.nii$/, "")) + ".anat")/T1_brain_mask.nii` |
| `t1_biascorr` | `File` | `$( (inputs.output_dir ? inputs.output_dir : inputs.input.nameroot.replace(/\.nii$/, "")) + ".anat")/T1_biascorr.nii.gz`, `$( (inputs.output_dir ? inputs.output_dir : inputs.input.nameroot.replace(/\.nii$/, "")) + ".anat")/T1_biascorr.nii` |
| `t1_biascorr_brain` | `File` | `$( (inputs.output_dir ? inputs.output_dir : inputs.input.nameroot.replace(/\.nii$/, "")) + ".anat")/T1_biascorr_brain.nii.gz`, `$( (inputs.output_dir ? inputs.output_dir : inputs.input.nameroot.replace(/\.nii$/, "")) + ".anat")/T1_biascorr_brain.nii` |
| `mni_to_t1_nonlin_warp` | `File` | `$( (inputs.output_dir ? inputs.output_dir : inputs.input.nameroot.replace(/\.nii$/, "")) + ".anat")/MNI_to_T1_nonlin_field.nii.gz`, `$( (inputs.output_dir ? inputs.output_dir : inputs.input.nameroot.replace(/\.nii$/, "")) + ".anat")/MNI_to_T1_nonlin_field.nii` |
| `t1_to_mni_nonlin_warp` | `File` | `$( (inputs.output_dir ? inputs.output_dir : inputs.input.nameroot.replace(/\.nii$/, "")) + ".anat")/T1_to_MNI_nonlin_field.nii.gz`, `$( (inputs.output_dir ? inputs.output_dir : inputs.input.nameroot.replace(/\.nii$/, "")) + ".anat")/T1_to_MNI_nonlin_field.nii` |
| `segmentation` | `File` | `$( (inputs.output_dir ? inputs.output_dir : inputs.input.nameroot.replace(/\.nii$/, "")) + ".anat")/T1_fast_seg.nii.gz`, `$( (inputs.output_dir ? inputs.output_dir : inputs.input.nameroot.replace(/\.nii$/, "")) + ".anat")/T1_fast_seg.nii` |
| `subcortical_seg` | `File` | `$( (inputs.output_dir ? inputs.output_dir : inputs.input.nameroot.replace(/\.nii$/, "")) + ".anat")/first_results/T1_first_all_fast_firstseg.nii.gz`, `$( (inputs.output_dir ? inputs.output_dir : inputs.input.nameroot.replace(/\.nii$/, "")) + ".anat")/first_results/T1_first_all_fast_firstseg.nii` |
| `log` | `File` | `fsl_anat.log` |

### Output Extensions

- **t1**: `.nii`, `.nii.gz`
- **t1_brain**: `.nii`, `.nii.gz`
- **t1_brain_mask**: `.nii`, `.nii.gz`
- **t1_biascorr**: `.nii`, `.nii.gz`
- **t1_biascorr_brain**: `.nii`, `.nii.gz`
- **mni_to_t1_nonlin_warp**: `.nii`, `.nii.gz`
- **t1_to_mni_nonlin_warp**: `.nii`, `.nii.gz`
- **segmentation**: `.nii`, `.nii.gz`
- **subcortical_seg**: `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Structural MRI > FSL > Pipelines
- Pipelines > FSL > Structural

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/fsl_anat)
