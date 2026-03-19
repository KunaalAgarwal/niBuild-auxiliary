# FSL Cluster Analysis (cluster)

**Library:** FSL | **Docker Image:** `brainlife/fsl`

## Function

Identifies contiguous clusters of suprathreshold voxels in statistical images and reports their properties.

**Modality:** Statistical map (z-stat or p-value 3D NIfTI).

**Typical Use:** Cluster-based thresholding and extracting peak coordinates from statistical maps.

## Key Parameters

-i (input stat image), -t (z threshold), -p (p threshold), --oindex (cluster index output), --olmax (local maxima output), -c (cope image for effect sizes)

## Key Points

Reports cluster size, peak coordinates, and p-values. Use with -c to get mean COPE within clusters. GRF-based p-values require smoothness estimates.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input statistical image (e.g., z-stat) | `--in=` |
| `threshold` | `double` | Yes | Threshold value for cluster formation | `--thresh=` |
| `oindex` | `string` | No | Output cluster index image filename | `--oindex=` |
| `othresh` | `string` | No | Output thresholded image filename | `--othresh=` |
| `olmax` | `string` | No | Output local maxima text file | `--olmax=` |
| `olmaxim` | `string` | No | Output local maxima image filename | `--olmaxim=` |
| `osize` | `string` | No | Output cluster size image filename | `--osize=` |
| `omax` | `string` | No | Output max intensity image filename | `--omax=` |
| `omean` | `string` | No | Output mean intensity image filename | `--omean=` |
| `opvals` | `string` | No | Output log p-values image filename | `--opvals=` |
| `pthresh` | `double` | No | P-threshold for clusters | `--pthresh=` |
| `dlh` | `double` | No | Smoothness estimate (sqrt determinant of Lambda) | `--dlh=` |
| `volume` | `int` | No | Number of voxels in mask | `--volume=` |
| `cope` | `File` | No | COPE image for effect size reporting | `--cope=` |
| `peakdist` | `double` | No | Minimum distance between peaks in mm | `--peakdist=` |
| `connectivity` | `int` | No | Voxel connectivity (6, 18, or 26) | `--connectivity=` |
| `fractional` | `boolean` | No | Interpret threshold as fraction of robust range | `--fractional` |
| `mm` | `boolean` | No | Use mm coordinates instead of voxel | `--mm` |
| `find_minima` | `boolean` | No | Find minima instead of maxima | `--min` |
| `num_maxima` | `int` | No | Number of local maxima to report | `--num=` |
| `xfm` | `File` | No | Linear transformation matrix file | `--xfm=` |
| `stdvol` | `File` | No | Standard space volume for coordinate transformation | `--stdvol=` |
| `warpvol` | `File` | No | Warp field for non-linear transformation | `--warpvol=` |
| `minclustersize` | `boolean` | No | Print minimum significant cluster size | `--minclustersize` |
| `no_table` | `boolean` | No | Suppress printing of cluster table | `--no_table` |
| `verbose` | `boolean` | No | Enable verbose output | `--verbose` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`
- **cope**: `.nii`, `.nii.gz`
- **xfm**: `.mat`
- **stdvol**: `.nii`, `.nii.gz`
- **warpvol**: `.nii`, `.nii.gz`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `cluster_table` | `File` | `cluster_table.txt` |
| `cluster_index` | `File` | `$(inputs.oindex).nii.gz`, `$(inputs.oindex).nii` |
| `thresholded_image` | `File` | `$(inputs.othresh).nii.gz`, `$(inputs.othresh).nii` |
| `local_maxima_txt` | `File` | `$(inputs.olmax)` |
| `local_maxima_image` | `File` | `$(inputs.olmaxim).nii.gz`, `$(inputs.olmaxim).nii` |
| `size_image` | `File` | `$(inputs.osize).nii.gz`, `$(inputs.osize).nii` |
| `max_image` | `File` | `$(inputs.omax).nii.gz`, `$(inputs.omax).nii` |
| `mean_image` | `File` | `$(inputs.omean).nii.gz`, `$(inputs.omean).nii` |
| `pvals_image` | `File` | `$(inputs.opvals).nii.gz`, `$(inputs.opvals).nii` |
| `log` | `File` | `cluster.log` |

### Output Extensions

- **cluster_table**: `.txt`
- **cluster_index**: `.nii`, `.nii.gz`
- **thresholded_image**: `.nii`, `.nii.gz`
- **local_maxima_txt**: `.txt`
- **local_maxima_image**: `.nii`, `.nii.gz`
- **size_image**: `.nii`, `.nii.gz`
- **max_image**: `.nii`, `.nii.gz`
- **mean_image**: `.nii`, `.nii.gz`
- **pvals_image**: `.nii`, `.nii.gz`

## Docker Tags

Available versions: `latest`, `6.0.4-patched2`, `6.0.4-patched`, `6.0.4`, `6.0.4-xenial`, `5.0.11`, `6.0.0`, `6.0.1`, `5.0.9`

## Categories

- Utilities > FSL > Clustering

## Documentation

[Official Documentation](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/Cluster)
