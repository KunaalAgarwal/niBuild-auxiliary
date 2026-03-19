# Connectome Workbench Surface Registration Transform

**Library:** Connectome Workbench | **Docker Image:** `khanlab/connectome-workbench`

## Function

Applies MSM or FreeSurfer spherical registration by projecting coordinates through registered sphere to target space.

**Modality:** Surface GIFTI files (sphere-in, sphere-project-to, sphere-unproject-from).

**Typical Use:** Applying surface registration transforms to resample data between atlas spaces.

## Key Parameters

<surface-in> <sphere-in> <sphere-project-to> <sphere-unproject-from> <surface-out>

## Key Points

Core operation for applying surface-based registration. Used to resample surfaces to different template spaces (fsaverage, fs_LR).

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `sphere_in` | `File` | Yes | Input sphere with desired output mesh |  |
| `sphere_project_to` | `File` | Yes | Sphere that aligns with sphere-in |  |
| `sphere_unproject_from` | `File` | Yes | sphere-project-to deformed to the desired output space |  |
| `sphere_out` | `string` | Yes | Output sphere filename |  |

### Accepted Input Extensions

- **sphere_in**: `.surf.gii`
- **sphere_project_to**: `.surf.gii`
- **sphere_unproject_from**: `.surf.gii`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `output_sphere` | `File` | `$(inputs.sphere_out)` |
| `log` | `File` | `wb_surface_sphere_project_unproject.log` |
| `err_log` | `File` | `wb_surface_sphere_project_unproject.err.log` |

### Output Extensions

- **output_sphere**: `.surf.gii`

## Docker Tags

Available versions: `latest`

## Categories

- Structural MRI > Connectome Workbench > Surface Registration

## Documentation

[Official Documentation](https://www.humanconnectome.org/software/workbench-command/-surface-sphere-project-unproject)
