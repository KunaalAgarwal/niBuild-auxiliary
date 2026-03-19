# Probabilistic Tractography with Crossing Fibres (probtrackx2)

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Probabilistic tractography using fiber orientation distributions from bedpostx to trace white matter pathways.

**Modality:** BEDPOSTX output directory plus seed mask (3D NIfTI).

**Typical Use:** White matter connectivity analysis, tract-based statistics.

## Key Parameters

-x (seed mask), -s (bedpostx merged samples), --dir (output directory), -l (loop check), --waypoints (waypoint masks), --avoid (exclusion mask)

## Key Points

Requires bedpostx output. Use --omatrix1 for seed-to-voxel connectivity, --omatrix2 for NxN connectivity. Waypoints constrain tractography to specific paths.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `samples_dir` | `Directory` | Yes | bedpostX output directory containing merged samples | `--samples=` |
| `mask` | `File` | Yes | Brain mask in diffusion space | `-m` |
| `seed` | `File` | Yes | Seed volume or text file of coordinates | `-x` |
| `output_dir` | `string` | Yes | Output directory | `--dir=` |
| `n_samples` | `int` | No | Number of samples per voxel (default 5000) | `--nsamples=` |
| `n_steps` | `int` | No | Number of steps per sample (default 2000) | `--nsteps=` |
| `step_length` | `double` | No | Step length in mm (default 0.5) | `--steplength=` |
| `c_thresh` | `double` | No | Curvature threshold (default 0.2) | `--cthr=` |
| `fibthresh` | `double` | No | Minimum fiber volume fraction (default 0.01) | `--fibthresh=` |
| `dist_thresh` | `double` | No | Minimum distance threshold in mm | `--distthresh=` |
| `loopcheck` | `boolean` | No | Enable loop checking | `--loopcheck` |
| `onewaycondition` | `boolean` | No | Apply waypoint conditions to each direction separately | `--onewaycondition` |
| `rand_fib` | `int` | No | Fiber sampling strategy (0=max, 1=sample, 2=sample+reject, 3=sample+reject+modulate) | `--randfib=` |
| `fibst` | `int` | No | Force starting fiber (1-based index) | `--fibst=` |
| `waypoints` | `File` | No | Waypoint mask (paths must pass through ALL) | `--waypoints=` |
| `waycond` | `enum` | No | Waypoint condition (AND or OR) | `--waycond=` |
| `avoid` | `File` | No | Exclusion mask (reject paths through this) | `--avoid=` |
| `stop` | `File` | No | Stop mask (terminate paths here) | `--stop=` |
| `target_masks` | `File` | No | List of target masks | `--targetmasks=` |
| `os2t` | `boolean` | No | Output seeds to targets | `--os2t` |
| `xfm` | `File` | No | Transformation matrix (seed to diffusion space) | `--xfm=` |
| `invxfm` | `File` | No | Inverse transformation matrix | `--invxfm=` |
| `seedref` | `File` | No | Reference image for seed space | `--seedref=` |
| `opd` | `boolean` | No | Output path distribution | `--opd` |
| `pd` | `boolean` | No | Output path distribution for each target | `--pd` |
| `out` | `string` | No | Output file stem | `--out=` |
| `omatrix1` | `boolean` | No | Output matrix (seed x seed) | `--omatrix1` |
| `omatrix2` | `boolean` | No | Output matrix (seed x low-res seed) | `--omatrix2` |
| `omatrix3` | `boolean` | No | Output matrix (seed x target) | `--omatrix3` |
| `omatrix4` | `boolean` | No | Output matrix (tract x tract) | `--omatrix4` |
| `network` | `boolean` | No | Network mode (seed file is list of seeds) | `--network` |
| `simple` | `boolean` | No | Track from single voxel coordinates | `--simple` |
| `force_dir` | `boolean` | No | Use directory as given (don't add .probtrackX) | `--forcedir` |
| `verbose` | `int` | No | Verbosity level (0, 1, or 2) | `-V` |
| `rseed` | `int` | No | Random seed | `--rseed=` |
| `modeuler` | `boolean` | No | Use modified Euler streamlining | `--modeuler` |
| `sampvox` | `double` | No | Sample sub-voxel tracking starting points | `--sampvox=` |

### Accepted Input Extensions

- **mask**: `.nii`, `.nii.gz`
- **seed**: `.nii`, `.nii.gz`, `.txt`
- **waypoints**: `.nii`, `.nii.gz`, `.txt`
- **avoid**: `.nii`, `.nii.gz`
- **stop**: `.nii`, `.nii.gz`
- **target_masks**: `.txt`
- **xfm**: `.mat`
- **invxfm**: `.mat`
- **seedref**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `output_directory` | `Directory` | `$(inputs.output_dir)` |
| `fdt_paths` | `File` | `$(inputs.output_dir)/fdt_paths.nii.gz`, `$(inputs.output_dir)/fdt_paths.nii` |
| `way_total` | `File` | `$(inputs.output_dir)/waytotal` |
| `matrix` | `File` | `$(inputs.output_dir)/fdt_matrix*.dot` |
| `targets` | `File[]` | `$(inputs.output_dir)/seeds_to_*.nii.gz`, `$(inputs.output_dir)/seeds_to_*.nii` |
| `log` | `File` | `probtrackx2.log` |

### Output Extensions

- **fdt_paths**: `.nii`, `.nii.gz`
- **way_total**: `.txt`
- **matrix**: `.dot`
- **targets**: `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Diffusion MRI > FSL > Tractography

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FDT/UserGuide#PROBTRACKX)
