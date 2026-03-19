# AFNI align_epi_anat — EPI-to-Anatomy Alignment

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Aligns EPI functional images to anatomical images with optional distortion correction using local Pearson correlation.

**Modality:** EPI volume (3D NIfTI) plus T1-weighted anatomical.

**Typical Use:** Core EPI-to-structural alignment in functional preprocessing.

## Key Parameters

-epi (EPI dataset), -anat (anatomical), -epi_base (EPI reference volume), -cost (cost function, default lpc)

## Key Points

lpc cost function designed for EPI-to-T1 alignment. Central tool in afni_proc.py.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `epi` | `File` | Yes | EPI dataset to align | `-epi` |
| `anat` | `File` | Yes | Anatomical dataset | `-anat` |
| `epi_base` | `string` | Yes | EPI base used in alignment (0/mean/median/max/subbrick#) | `-epi_base` |
| `anat2epi` | `boolean` | No | Align anatomical to EPI (default) | `-anat2epi` |
| `epi2anat` | `boolean` | No | Align EPI to anatomical instead | `-epi2anat` |
| `suffix` | `string` | No | Suffix to append to output names (default _al) | `-suffix` |
| `output_dir` | `string` | No | Output directory for results | `-output_dir` |
| `big_move` | `boolean` | No | Enable two-pass alignment for larger displacements | `-big_move` |
| `giant_move` | `boolean` | No | Even larger movement - uses cmass, two passes, very large angles | `-giant_move` |
| `ginormous_move` | `boolean` | No | Combines giant_move with center alignment | `-ginormous_move` |
| `rigid_body` | `boolean` | No | Limit transformation to translation and rotation only | `-rigid_body` |
| `volreg` | `enum` | No | Perform volume registration on EPI (default on) | `-volreg` |
| `tshift` | `enum` | No | Enable time-series correction (default on) | `-tshift` |
| `deoblique` | `enum` | No | Correct oblique dataset orientations (default on) | `-deoblique` |
| `cost` | `string` | No | Alignment cost function (default lpc) | `-cost` |
| `edge` | `boolean` | No | Use edge-detection method instead of standard cost | `-edge` |
| `save_all` | `boolean` | No | Preserve all intermediate datasets | `-save_all` |
| `save_vr` | `boolean` | No | Save motion-corrected EPI dataset | `-save_vr` |
| `save_skullstrip` | `boolean` | No | Save skull-stripped anatomy | `-save_skullstrip` |
| `anat_has_skull` | `enum` | No | Whether anatomical has skull | `-anat_has_skull` |
| `epi_strip` | `enum` | No | Method for stripping EPI | `-epi_strip` |

### Accepted Input Extensions

- **epi**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **anat**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `aligned_anat` | `File` | `*_al+orig.HEAD`, `*_al+tlrc.HEAD` |
| `aligned_epi` | `File` | `*_al_reg+orig.HEAD`, `*_al_reg+tlrc.HEAD` |
| `transform_matrix` | `File[]` | `*.aff12.1D` |
| `volreg_output` | `File` | `*_vr+orig.HEAD`, `*_vr+tlrc.HEAD` |
| `log` | `File` | `align_epi_anat.log` |

### Output Extensions

- **aligned_anat**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **aligned_epi**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **transform_matrix**: `.aff12.1D`
- **volreg_output**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Functional MRI > AFNI > Registration

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/align_epi_anat.py.html)
