# AFNI 3D Cluster Size Simulation (3dClustSim)

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Simulates null distribution of cluster sizes for determining cluster-extent thresholds that control family-wise error rate.

**Modality:** Brain mask (3D NIfTI/AFNI) plus smoothness estimates from 3dFWHMx.

**Typical Use:** Determining cluster size thresholds for multiple comparison correction.

## Key Parameters

-mask (brain mask), -acf (ACF parameters from 3dFWHMx), -athr (per-voxel alpha), -pthr (per-voxel p thresholds)

## Key Points

Use ACF-based smoothness (not FWHM) from 3dFWHMx on residuals. Updated in 2016 for non-Gaussian assumptions.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `prefix` | `string` | Yes | Output filename prefix | `-prefix` |
| `nxyz` | `string` | No | Size of 3D grid (n1 n2 n3, default 64 64 32) | `-nxyz` |
| `dxyz` | `string` | No | Voxel dimensions in mm (d1 d2 d3, default 3.5 3.5 3.5) | `-dxyz` |
| `mask` | `File` | No | Mask dataset defining analysis region | `-mask` |
| `BALL` | `boolean` | No | Restrict simulation to spherical volume | `-BALL` |
| `inset` | `File[]` | No | Use these volumes as simulations | `-inset` |
| `fwhm` | `double` | No | Gaussian filter width in mm (not recommended) | `-fwhm` |
| `acf` | `string` | No | ACF parameters (a b c) from 3dFWHMx | `-acf` |
| `nopad` | `boolean` | No | Disable edge padding | `-nopad` |
| `pthr` | `string` | No | Per-voxel p-value thresholds | `-pthr` |
| `athr` | `string` | No | Whole-volume alpha significance levels | `-athr` |
| `iter` | `int` | No | Number of Monte Carlo simulations (default 10000) | `-iter` |
| `seed` | `int` | No | Random number seed | `-seed` |
| `niml` | `boolean` | No | Output in NIML/XML format | `-niml` |
| `both` | `boolean` | No | Output both NIML and .1D formats | `-both` |
| `nodec` | `boolean` | No | Remove decimal places from thresholds | `-nodec` |
| `quiet` | `boolean` | No | Suppress progress messages | `-quiet` |

### Accepted Input Extensions

- **mask**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **inset**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `clustsim_1D` | `File[]` | `$(inputs.prefix).NN*.1D` |
| `clustsim_niml` | `File[]` | `$(inputs.prefix).NN*.niml` |
| `log` | `File` | `$(inputs.prefix).log` |

### Output Extensions

- **clustsim_1D**: `.1D`
- **clustsim_niml**: `.niml`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Functional MRI > AFNI > Multiple Comparisons

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dClustSim.html)
