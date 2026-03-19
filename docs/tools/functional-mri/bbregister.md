# FreeSurfer Boundary-Based Registration (bbregister)

**Library:** FreeSurfer | **Docker Image:** `freesurfer/freesurfer`

## Function

High-quality registration of functional EPI images to FreeSurfer anatomy using white matter boundary contrast.

**Modality:** 3D EPI volume (mean/example func) plus FreeSurfer subject directory.

**Typical Use:** High-quality EPI to T1 registration using cortical surfaces.

## Key Parameters

--s (subject), --mov (moving/source image), --reg (output registration), --init-fsl (initialization method), --bold (contrast type)

## Key Points

Superior to volume-based registration for EPI-to-T1. Requires completed recon-all. --init-fsl recommended.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `subjects_dir` | `Directory` | Yes | FreeSurfer SUBJECTS_DIR |  |
| `fs_license` | `File` | Yes | FreeSurfer license file |  |
| `subject` | `string` | Yes | FreeSurfer subject name | `--s` |
| `source_file` | `File` | Yes | Source (moveable) volume to register | `--mov` |
| `out_reg_file` | `string` | Yes | Output registration file (.dat) | `--reg` |
| `contrast_type` | `enum` | No | Contrast type of source image |  |
| `init_coreg` | `boolean` | No | Initialize using mri_coreg (default) | `--init-coreg` |
| `init_header` | `boolean` | No | Initialize using header geometry | `--init-header` |
| `init_reg` | `File` | No | Initialize with existing registration file | `--init-reg` |
| `no_coreg_ref_mask` | `boolean` | No | Do not use aparc+aseg.mgz as reference mask | `--no-coreg-ref-mask` |
| `dof` | `enum` | No | Degrees of freedom (6=rigid, 9=+scaling, 12=affine) | `--dof` |
| `tol` | `double` | No | Second stage loop tolerance | `--tol` |
| `tol1d` | `double` | No | Second stage 1D tolerance | `--tol1d` |
| `nmax` | `int` | No | Max number of iterations | `--nmax` |
| `subsamp` | `int` | No | Second stage vertex subsampling | `--subsamp` |
| `subsamp1` | `int` | No | Pass 1 vertex subsampling | `--subsamp1` |
| `brute1max` | `double` | No | Pass 1 brute force max translation | `--brute1max` |
| `brute1delta` | `double` | No | Pass 1 brute force delta | `--brute1delta` |
| `no_brute2` | `boolean` | No | Disable brute force search on pass 2 | `--no-brute2` |
| `lta` | `boolean` | No | Output as LTA format | `--lta` |
| `fslmat` | `string` | No | Output FSL-style matrix file | `--fslmat` |
| `int` | `File` | No | Intermediate volume for registration | `--int` |
| `mid_frame` | `boolean` | No | Use middle frame of source | `--mid-frame` |
| `frame` | `int` | No | Use specific frame of source (0-based) | `--frame` |
| `fsl_bet_mov` | `boolean` | No | Apply BET to moveable volume | `--fsl-bet-mov` |
| `no_fsl_bet_mov` | `boolean` | No | Do not apply BET to moveable volume | `--no-fsl-bet-mov` |
| `tmp` | `string` | No | Temporary directory | `--tmp` |
| `nocleanup` | `boolean` | No | Do not delete temporary files | `--nocleanup` |

### Accepted Input Extensions

- **source_file**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`
- **init_reg**: `.dat`, `.lta`
- **int**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `out_reg` | `File` | `$(inputs.out_reg_file)` |
| `out_fsl_mat` | `File` | `$(inputs.fslmat)` |
| `mincost` | `File` | `*.mincost` |
| `log` | `File` | `bbregister.log` |

### Output Extensions

- **out_reg**: `.dat`, `.lta`
- **out_fsl_mat**: `.mat`
- **mincost**: `.mincost`

## Enum Options

**`contrast_type`**: `t1`, `t2`, `bold`, `dti`

**`init`**: `coreg`, `rr`, `spm`, `fsl`, `header`, `best`

**`dof`**: `6`, `9`, `12`

## Docker Tags

Available versions: `latest`, `8.1.0`, `8.0.0`, `7.2.0`, `7.3.0`, `7.3.1`, `7.3.2`, `7.4.1`, `7.1.1`, `6.0`

## Categories

- Functional MRI > FreeSurfer > Functional Analysis

## Documentation

[Official Documentation](https://surfer.nmr.mgh.harvard.edu/fswiki/bbregister)
