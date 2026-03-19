# FreeSurfer Subcortical Stats to Group Table

**Library:** FreeSurfer | **Docker Image:** `freesurfer/freesurfer`

## Function

Collects subcortical segmentation statistics across multiple subjects into a single table.

**Modality:** Multiple FreeSurfer subject directories with completed recon-all.

**Typical Use:** Group analysis of subcortical volumes.

## Key Parameters

--subjects (subject list), --meas (measure: volume, mean), --tablefile (output table), --stats (stats file name)

## Key Points

Creates one row per subject with subcortical volumes. Default uses aseg.stats.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `subjects_dir` | `Directory` | Yes | FreeSurfer SUBJECTS_DIR |  |
| `fs_license` | `File` | Yes | FreeSurfer license file |  |
| `subjects` | `string[]` | Yes | List of subject names | `--subjects` |
| `tablefile` | `string` | Yes | Output table filename | `--tablefile` |
| `meas` | `enum` | No | Measurement to extract (default volume) | `--meas` |
| `statsfile` | `string` | No | Stats file name (default aseg.stats) | `--statsfile` |
| `delimiter` | `enum` | No | Delimiter for output table | `--delimiter` |
| `subjectsfile` | `File` | No | File containing subject list | `--subjectsfile` |
| `segno` | `int[]` | No | Only output specific segmentation numbers | `--segno` |
| `segids` | `File` | No | File with segmentation IDs to extract | `--segids` |
| `skip` | `boolean` | No | Skip subjects with missing data | `--skip` |
| `all_segs` | `boolean` | No | Include all segmentations | `--all-segs` |
| `common_segs` | `boolean` | No | Only output segs common to all subjects | `--common-segs` |
| `transpose` | `boolean` | No | Transpose output table | `--transpose` |
| `etiv` | `boolean` | No | Include estimated total intracranial volume | `--etiv` |
| `etiv_only` | `boolean` | No | Only output eTIV | `--etiv-only` |
| `eulerNo` | `boolean` | No | Include Euler number | `--euler` |

### Accepted Input Extensions

- **subjectsfile**: `.txt`
- **segids**: `.txt`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `table` | `File` | `$(inputs.tablefile)` |
| `log` | `File` | `asegstats2table.log` |

### Output Extensions

- **table**: `.txt`, `.csv`, `.dat`

## Enum Options

**`meas`**: `volume`, `mean`

**`delimiter`**: `tab`, `comma`, `space`, `semicolon`

## Docker Tags

Available versions: `latest`, `8.1.0`, `8.0.0`, `7.2.0`, `7.3.0`, `7.3.1`, `7.3.2`, `7.4.1`, `7.1.1`, `6.0`

## Categories

- Structural MRI > FreeSurfer > Morphometry

## Documentation

[Official Documentation](https://surfer.nmr.mgh.harvard.edu/fswiki/asegstats2table)
