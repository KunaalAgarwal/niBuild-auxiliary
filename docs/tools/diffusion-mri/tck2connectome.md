# MRtrix3 Tractogram to Connectome

**Library:** MRtrix3 | **Docker Image:** `mrtrix3/mrtrix3`

## Function

Constructs a structural connectivity matrix by counting streamlines connecting pairs of regions from a parcellation.

**Modality:** Tractogram (.tck) plus parcellation volume (integer-labeled 3D NIfTI).

**Typical Use:** Building structural connectivity matrices from tractography and parcellation.

## Key Parameters

<input.tck> <parcellation> <output.csv>, -assignment_radial_search (search radius), -scale_length (length scaling)

## Key Points

Output is NxN matrix. Use SIFT/SIFT2 filtered tractogram for quantitative connectomics. -symmetric recommended.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input_tracks` | `File` | Yes | Input tractogram |  |
| `parcellation` | `File` | Yes | Parcellation image (atlas) |  |
| `output` | `string` | Yes | Output connectivity matrix filename |  |
| `assignment_radial_search` | `double` | No | Radial search distance for node assignment (mm) | `-assignment_radial_search` |
| `scale_length` | `boolean` | No | Scale by streamline length | `-scale_length` |
| `scale_invlength` | `boolean` | No | Scale by inverse streamline length | `-scale_invlength` |
| `scale_invnodevol` | `boolean` | No | Scale by inverse node volume | `-scale_invnodevol` |
| `stat_edge` | `string` | No | Edge statistic (sum/mean/min/max) | `-stat_edge` |
| `symmetric` | `boolean` | No | Make matrix symmetric | `-symmetric` |
| `zero_diagonal` | `boolean` | No | Zero the diagonal of the matrix | `-zero_diagonal` |

### Accepted Input Extensions

- **input_tracks**: `.tck`
- **parcellation**: `.mif`, `.nii`, `.nii.gz`, `.mgh`, `.mgz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `connectome` | `File` | `$(inputs.output)` |
| `log` | `File` | `tck2connectome.log` |

### Output Extensions

- **connectome**: `.csv`

## Docker Tags

Available versions: `latest`, `3.0.8`, `3.0.7`, `3.0.5`, `3.0.4`, `3.0.3`

## Categories

- Diffusion MRI > MRtrix3 > Tractography

## Documentation

[Official Documentation](https://mrtrix.readthedocs.io/en/latest/reference/commands/tck2connectome.html)
