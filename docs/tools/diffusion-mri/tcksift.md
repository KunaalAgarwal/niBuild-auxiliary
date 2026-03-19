# MRtrix3 SIFT Tractogram Filtering

**Library:** MRtrix3 | **Docker Image:** `mrtrix3/mrtrix3`

## Function

Filters tractograms to improve biological plausibility by matching streamline density to FOD lobe integrals.

**Modality:** Tractogram (.tck) plus FOD image used for tractography.

**Typical Use:** Improving tractogram biological accuracy before connectome construction.

## Key Parameters

<input.tck> <output.tck>, -act (ACT image), -term_number (target streamline count)

## Key Points

Dramatically improves connectome quantification. Run after tckgen. SIFT2 (tcksift2) outputs weights instead of filtering.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input_tracks` | `File` | Yes | Input tractogram |  |
| `fod` | `File` | Yes | FOD image for filtering |  |
| `output` | `string` | Yes | Output filtered tractogram |  |
| `act` | `File` | No | ACT tissue-segmented image | `-act` |
| `term_number` | `int` | No | Target number of streamlines | `-term_number` |
| `term_ratio` | `double` | No | Target ratio of streamlines to keep | `-term_ratio` |

### Accepted Input Extensions

- **input_tracks**: `.tck`
- **fod**: `.mif`, `.nii`, `.nii.gz`, `.mgh`, `.mgz`
- **act**: `.mif`, `.nii`, `.nii.gz`, `.mgh`, `.mgz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `filtered_tractogram` | `File` | `$(inputs.output)` |
| `log` | `File` | `tcksift.log` |

### Output Extensions

- **filtered_tractogram**: `.tck`

## Docker Tags

Available versions: `latest`, `3.0.8`, `3.0.7`, `3.0.5`, `3.0.4`, `3.0.3`

## Categories

- Diffusion MRI > MRtrix3 > Tractography

## Documentation

[Official Documentation](https://mrtrix.readthedocs.io/en/latest/reference/commands/tcksift.html)
