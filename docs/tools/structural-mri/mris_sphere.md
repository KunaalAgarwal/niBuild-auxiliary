# FreeSurfer Surface to Sphere Mapping

**Library:** FreeSurfer | **Docker Image:** `freesurfer/freesurfer`

## Function

Maps the inflated cortical surface to a sphere for inter-subject spherical registration.

**Modality:** FreeSurfer inflated surface file.

**Typical Use:** Preparing cortical surface for spherical registration and atlas labeling.

## Key Parameters

(minimal user-facing parameters; uses inflated surface)

## Key Points

Prerequisite for cortical atlas registration. Part of recon-all. Spherical mapping enables vertex-wise inter-subject comparisons.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `subjects_dir` | `Directory` | Yes | FreeSurfer SUBJECTS_DIR |  |
| `fs_license` | `File` | Yes | FreeSurfer license file |  |
| `input` | `File` | Yes | Input inflated surface file |  |
| `output` | `string` | Yes | Output spherical surface filename |  |
| `seed` | `int` | No | Random number generator seed | `-seed` |
| `q` | `boolean` | No | Omit self-intersection and vertex location info | `-q` |
| `p` | `boolean` | No | Write intermediate surfaces | `-p` |
| `dist` | `double` | No | Expand surface outward | `-dist` |
| `mval` | `double` | No | Magic value for processing | `-v` |
| `in_smoothwm` | `File` | No | Smooth white matter reference surface | `-w` |
| `niters` | `int` | No | Number of iterations | `-i` |
| `dt` | `double` | No | Time step for integration | `-dt` |
| `remove` | `boolean` | No | Remove interseced faces | `-remove` |

### Accepted Input Extensions

- **input**: `.inflated`, `.white`, `.pial`, `.smoothwm`, `.orig`
- **in_smoothwm**: `.smoothwm`, `.white`, `.pial`, `.orig`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `sphere` | `File` | `$(inputs.output)*` |
| `log` | `File` | `mris_sphere.log` |

### Output Extensions

- **sphere**: `.sphere`

## Docker Tags

Available versions: `latest`, `8.1.0`, `8.0.0`, `7.2.0`, `7.3.0`, `7.3.1`, `7.3.2`, `7.4.1`, `7.1.1`, `6.0`

## Categories

- Structural MRI > FreeSurfer > Surface Reconstruction

## Documentation

[Official Documentation](https://surfer.nmr.mgh.harvard.edu/fswiki/mris_sphere)
