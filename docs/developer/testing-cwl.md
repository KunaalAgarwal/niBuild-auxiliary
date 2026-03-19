# Testing CWL Tools

Every CWL tool definition should be validated and tested. Tests live in the `utils/` directory of the niBuild repository.

## Testing Workflow

### 1. Validate the CWL File

```bash
cwltool --validate public/cwl/fsl/my_tool.cwl
```

This checks syntax, type consistency, and CWL v1.2 compliance.

### 2. Generate a Job Template

```bash
cwltool --make-template public/cwl/fsl/my_tool.cwl > template_job.yml
```

This generates a YAML template with placeholder values for all inputs.

### 3. Fill the Template

Edit `template_job.yml` with reasonable parameters that a researcher would actually use. Configure the tool to generate all optional outputs where possible.

```yaml
input_image:
  class: File
  path: /path/to/test_brain.nii.gz
output_prefix: test_output
threshold: 0.5
mask: true
```

### 4. Run the Tool

```bash
cwltool public/cwl/fsl/my_tool.cwl template_job.yml
```

!!! note
    cwltool is only available in WSL on Windows. Use `wsl` to run these commands.

### 5. Inspect Outputs

Verify:

- All expected output files are generated and non-empty
- Image dimensions and headers are correct (use `fslinfo` or `3dinfo`)
- Log files contain no errors
- For image outputs, check that voxel values are reasonable (not all zeros, no NaN)

```bash
fslinfo test_output.nii.gz
fslstats test_output.nii.gz -R   # min/max range
```

## Test Organization

```
utils/
├── <modality>/
│   └── tests/
│       ├── test_my_tool.sh
│       └── test_my_tool_job.yml
```

## Multiple Test Configurations

For tools with highly dynamic behavior, write multiple test configurations:

```bash
# Test with default parameters
cwltool my_tool.cwl test_defaults_job.yml

# Test with aggressive parameters
cwltool my_tool.cwl test_aggressive_job.yml

# Test with optional outputs enabled
cwltool my_tool.cwl test_all_outputs_job.yml
```
