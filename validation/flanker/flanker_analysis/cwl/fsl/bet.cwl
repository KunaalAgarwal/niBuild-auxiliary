#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool
baseCommand: bet
hints:
  DockerRequirement:
    dockerPull: brainlife/fsl:6.0.4
stdout: $(inputs.output).log
stderr: $(inputs.output).log
inputs:
  input:
    type: File
    label: Input T1-weighted image
    inputBinding:
      position: 1
  output:
    type: string
    label: Output filename
    inputBinding:
      position: 2
  overlay:
    type:
      - 'null'
      - boolean
    label: Generate brain outline image
    inputBinding:
      prefix: '-o'
      position: 3
  mask:
    type:
      - 'null'
      - boolean
    label: Generate binary brain mask image
    inputBinding:
      prefix: '-m'
      position: 4
  skull:
    type:
      - 'null'
      - boolean
    label: Generate skull-stripped image
    inputBinding:
      prefix: '-s'
      position: 5
  ngenerate:
    type:
      - 'null'
      - boolean
    label: Do not generate the default output
    inputBinding:
      prefix: '-n'
      position: 6
  frac:
    type:
      - 'null'
      - double
    label: Fractional intensity threshold
    inputBinding:
      prefix: '-f'
      position: 7
  vert_frac:
    type:
      - 'null'
      - double
    label: Vertical gradient in fractional intensity
    inputBinding:
      prefix: '-g'
      position: 8
  radius:
    type:
      - 'null'
      - double
    label: Radius of the brain centre in mm
    inputBinding:
      prefix: '-r'
      position: 9
  cog:
    type:
      - 'null'
      - string
    label: Center of gravity vox coordinates
    inputBinding:
      prefix: '-c'
      position: 10
  threshold:
    type:
      - 'null'
      - boolean
    label: Use thresholding to estimate the brain centre
    inputBinding:
      prefix: '-t'
      position: 11
  mesh:
    type:
      - 'null'
      - boolean
    label: Generate a mesh of the brain surface
    inputBinding:
      prefix: '-e'
      position: 12
  exclusive:
    type:
      - 'null'
      - type: record
        name: robust
        fields:
          robust:
            type: boolean
            label: Use robust fitting
            inputBinding:
              prefix: '-R'
              position: 13
      - type: record
        name: eye
        fields:
          eye:
            type: boolean
            label: Use eye mask
            inputBinding:
              prefix: '-S'
              position: 13
      - type: record
        name: bias
        fields:
          bias:
            type: boolean
            label: Use bias field correction
            inputBinding:
              prefix: '-B'
              position: 13
      - type: record
        name: fov
        fields:
          fov:
            type: boolean
            label: Use field of view
            inputBinding:
              prefix: '-Z'
              position: 13
      - type: record
        name: fmri
        fields:
          fmri:
            type: boolean
            label: Use fMRI mode
            inputBinding:
              prefix: '-F'
              position: 13
      - type: record
        name: betsurf
        fields:
          betsurf:
            type: boolean
            label: Use BET surface mode
            inputBinding:
              prefix: '-A'
              position: 13
      - type: record
        name: betsurfT2
        fields:
          betsurfT2:
            type: File
            label: Use BET surface mode for T2-weighted images
            inputBinding:
              prefix: '-A2'
              position: 13
outputs:
  brain_extraction:
    type:
      - 'null'
      - File
    outputBinding:
      glob:
        - $(inputs.output).nii
        - $(inputs.output).nii.gz
  brain_mask:
    type:
      - 'null'
      - File
    outputBinding:
      glob:
        - $(inputs.output)_mask.nii.gz
        - $(inputs.output)_mask.nii
  brain_skull:
    type:
      - 'null'
      - File
    outputBinding:
      glob:
        - $(inputs.output)_skull.nii.gz
        - $(inputs.output)_skull.nii
  brain_mesh:
    type:
      - 'null'
      - File
    outputBinding:
      glob:
        - $(inputs.output)_mesh.vtk
  brain_registration:
    type: File[]
    outputBinding:
      glob:
        - $(inputs.output)_inskull_*.*
        - $(inputs.output)_outskin_*.*
        - $(inputs.output)_outskull_*.*
        - $(inputs.output)_skull_mask.*
  log:
    type: File
    outputBinding:
      glob: $(inputs.output).log
