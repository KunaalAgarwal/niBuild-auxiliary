# FreeSurfer Cortical Stats to Group Table

**Library:** FreeSurfer | **Docker Image:** `freesurfer/freesurfer`

## Function

Collects cortical parcellation statistics across multiple subjects into a single table for group analysis.

**Modality:** Multiple FreeSurfer subject directories with completed recon-all.

**Typical Use:** Creating group spreadsheet of cortical morphometry for statistical analysis.

## Key Parameters

--subjects (subject list), --hemi (hemisphere), --meas (measure: thickness, area, volume), --tablefile (output table)

## Key Points

Creates one row per subject, one column per region. Output table ready for statistical software.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `subjects_dir` | `Directory` | Yes | FreeSurfer SUBJECTS_DIR |  |
| `fs_license` | `File` | Yes | FreeSurfer license file |  |
| `subjects` | `string[]` | Yes | List of subject names | `--subjects` |
| `hemi` | `enum` | Yes | Hemisphere (lh or rh) | `--hemi` |
| `tablefile` | `string` | Yes | Output table filename | `--tablefile` |
| `parc` | `string` | No | Parcellation name (default aparc) | `--parc` |
| `meas` | `enum` | No | Measurement to extract | `--meas` |
| `delimiter` | `enum` | No | Delimiter for output table | `--delimiter` |
| `subjectsfile` | `File` | No | File containing subject list | `--subjectsfile` |
| `skip` | `boolean` | No | Skip subjects with missing data | `--skip` |
| `parcid_only` | `boolean` | No | Only output parcellation IDs | `--parcid-only` |
| `common_parcs` | `boolean` | No | Only output parcels common to all subjects | `--common-parcs` |
| `report_rois` | `boolean` | No | Report which ROIs differ | `--report-rois` |
| `transpose` | `boolean` | No | Transpose output table | `--transpose` |

### Accepted Input Extensions

- **subjectsfile**: `.txt`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `table` | `File` | `$(inputs.tablefile)` |
| `log` | `File` | `aparcstats2table.log` |

### Output Extensions

- **table**: `.txt`, `.csv`, `.dat`

## Enum Options

**`meas`**: `area`, `volume`, `thickness`, `thicknessstd`, `meancurv`, `gauscurv`, `foldind`, `curvind`

**`delimiter`**: `tab`, `comma`, `space`, `semicolon`

## Docker Tags

Available versions: `latest`, `8.1.0`, `8.0.0`, `7.2.0`, `7.3.0`, `7.3.1`, `7.3.2`, `7.4.1`, `7.1.1`, `6.0`

## Categories

- Structural MRI > FreeSurfer > Morphometry

## Documentation

[Official Documentation](https://surfer.nmr.mgh.harvard.edu/fswiki/aparcstats2table)
