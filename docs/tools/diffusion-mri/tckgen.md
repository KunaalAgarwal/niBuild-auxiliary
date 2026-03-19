# MRtrix3 Streamline Tractography Generation

**Library:** MRtrix3 | **Docker Image:** `mrtrix3/mrtrix3`

## Function

Generates streamline tractograms using various algorithms (iFOD2, FACT, etc.) from FOD or tensor images.

**Modality:** FOD image (from dwi2fod) or tensor image, plus optional seed/mask/ROI images.

**Typical Use:** Generating whole-brain or ROI-seeded tractograms.

## Key Parameters

<source> <output.tck>, -algorithm (iFOD2, FACT, etc.), -seed_image (seeding region), -select (target streamline count), -cutoff (FOD amplitude cutoff)

## Key Points

iFOD2 (default) is probabilistic and handles crossing fibers. Use -select for target count. -cutoff controls termination.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `source` | `File` | Yes | Input FOD or tensor image |  |
| `output` | `string` | Yes | Output tractogram filename |  |
| `algorithm` | `string` | No | Tracking algorithm (iFOD2/Tensor_Det/Tensor_Prob) | `-algorithm` |
| `seed_image` | `File` | No | Seed image for tractography | `-seed_image` |
| `select` | `int` | No | Number of streamlines to select | `-select` |
| `cutoff` | `double` | No | FOD amplitude cutoff for termination | `-cutoff` |
| `act` | `File` | No | ACT tissue-segmented image | `-act` |
| `step` | `double` | No | Step size (mm) | `-step` |
| `angle` | `double` | No | Maximum angle between steps (degrees) | `-angle` |
| `maxlength` | `double` | No | Maximum streamline length (mm) | `-maxlength` |

### Accepted Input Extensions

- **source**: `.mif`, `.nii`, `.nii.gz`, `.mgh`, `.mgz`
- **seed_image**: `.mif`, `.nii`, `.nii.gz`, `.mgh`, `.mgz`
- **act**: `.mif`, `.nii`, `.nii.gz`, `.mgh`, `.mgz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `tractogram` | `File` | `$(inputs.output)` |
| `log` | `File` | `tckgen.log` |

### Output Extensions

- **tractogram**: `.tck`

## Docker Tags

Available versions: `latest`, `3.0.8`, `3.0.7`, `3.0.5`, `3.0.4`, `3.0.3`

## Categories

- Diffusion MRI > MRtrix3 > Tractography

## Documentation

[Official Documentation](https://mrtrix.readthedocs.io/en/latest/reference/commands/tckgen.html)
