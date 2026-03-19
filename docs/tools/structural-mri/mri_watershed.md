# FreeSurfer MRI Watershed Skull Stripping

**Library:** FreeSurfer | **Docker Image:** `freesurfer/freesurfer`

## Function

Brain extraction using a hybrid watershed/surface deformation algorithm to find the brain-skull boundary.

**Modality:** T1-weighted 3D volume (typically MGZ format within FreeSurfer pipeline).

**Typical Use:** Brain extraction within recon-all pipeline.

## Key Parameters

-T1 (specify T1 volume), -atlas (use atlas for initial estimate), -h (preflooding height, default 25)

## Key Points

Core component of recon-all. Adjust -h parameter if too much/too little brain removed. Usually part of autorecon1.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `subjects_dir` | `Directory` | Yes | FreeSurfer SUBJECTS_DIR |  |
| `fs_license` | `File` | Yes | FreeSurfer license file |  |
| `input` | `File` | Yes | Input T1 volume |  |
| `output` | `string` | Yes | Output brain volume filename |  |
| `atlas` | `boolean` | No | Apply atlas correction to segmentation | `-atlas` |
| `brain_atlas` | `File` | No | Atlas reference file | `-brain_atlas` |
| `preflooding_height` | `int` | No | Preflooding height in percent | `-h` |
| `watershed_weight` | `double` | No | Preweight using atlas information | `-w` |
| `basin_merge` | `double` | No | Basin merging using atlas information | `-b` |
| `less` | `boolean` | No | Shrink the surface (leaves less skull) | `-less` |
| `more` | `boolean` | No | Expand the surface (leaves more skull) | `-more` |
| `threshold` | `int` | No | Adjust watershed threshold | `-t` |
| `seed` | `string` | No | Add seed point coordinates (x y z) | `-s` |
| `center` | `string` | No | Brain center in voxels (x y z) | `-c` |
| `radius` | `int` | No | Brain radius in voxels | `-r` |
| `t1` | `boolean` | No | Specify T1 input (grey value ~110) | `-T1` |
| `no_seedpt` | `boolean` | No | Disable seed points from atlas | `-no_seedpt` |
| `no_wta` | `boolean` | No | Disable preweighting for template deformation | `-no_wta` |
| `no_ta` | `boolean` | No | Disable template deformation using atlas | `-no-ta` |
| `surf` | `string` | No | Save BEM surfaces to directory | `-surf` |
| `brainsurf` | `string` | No | Save brain surface filename | `-brainsurf` |
| `useSRAS` | `boolean` | No | Use surface RAS instead of scanner RAS | `-useSRAS` |
| `watershed_only` | `boolean` | No | Use watershed algorithm only | `-wat` |
| `noT1` | `boolean` | No | Skip T1 analysis to conserve memory | `-noT1` |
| `mask` | `boolean` | No | Mask volume with brain mask | `-mask` |
| `label` | `boolean` | No | Label output into anatomical structures | `-LABEL` |

### Accepted Input Extensions

- **input**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`
- **brain_atlas**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`, `.gca`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `brain` | `File` | `$(inputs.output)*` |
| `bem_surfaces` | `Directory` | `$(inputs.surf)` |
| `log` | `File` | `mri_watershed.log` |

### Output Extensions

- **brain**: `.mgz`, `.mgh`, `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `8.1.0`, `8.0.0`, `7.2.0`, `7.3.0`, `7.3.1`, `7.3.2`, `7.4.1`, `7.1.1`, `6.0`

## Categories

- Structural MRI > FreeSurfer > Surface Reconstruction

## Documentation

[Official Documentation](https://surfer.nmr.mgh.harvard.edu/fswiki/mri_watershed)
