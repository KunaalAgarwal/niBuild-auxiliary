#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool
baseCommand: fslmaths
requirements:
  ShellCommandRequirement: {}
hints:
  DockerRequirement:
    dockerPull: brainlife/fsl:6.0.4
stdout: fslmaths.log
stderr: fslmaths.log
inputs:
  input:
    type: File
    label: Input image
    inputBinding:
      position: 1
  abs:
    type:
      - 'null'
      - boolean
    label: Absolute value
    inputBinding:
      prefix: '-abs'
      position: 4
  bin:
    type:
      - 'null'
      - boolean
    label: Binarize (non-zero -> 1)
    inputBinding:
      prefix: '-bin'
      position: 5
  binv:
    type:
      - 'null'
      - boolean
    label: Binarize and invert (zero -> 1, non-zero -> 0)
    inputBinding:
      prefix: '-binv'
      position: 6
  recip:
    type:
      - 'null'
      - boolean
    label: Reciprocal (1/x)
    inputBinding:
      prefix: '-recip'
      position: 7
  sqrt:
    type:
      - 'null'
      - boolean
    label: Square root
    inputBinding:
      prefix: '-sqrt'
      position: 8
  sqr:
    type:
      - 'null'
      - boolean
    label: Square
    inputBinding:
      prefix: '-sqr'
      position: 9
  exp:
    type:
      - 'null'
      - boolean
    label: Exponential
    inputBinding:
      prefix: '-exp'
      position: 10
  log:
    type:
      - 'null'
      - boolean
    label: Natural logarithm
    inputBinding:
      prefix: '-log'
      position: 11
  nan:
    type:
      - 'null'
      - boolean
    label: Replace NaN with 0
    inputBinding:
      prefix: '-nan'
      position: 12
  nanm:
    type:
      - 'null'
      - boolean
    label: Make NaN mask (1 where NaN)
    inputBinding:
      prefix: '-nanm'
      position: 13
  fillh:
    type:
      - 'null'
      - boolean
    label: Fill holes in binary mask
    inputBinding:
      prefix: '-fillh'
      position: 14
  fillh26:
    type:
      - 'null'
      - boolean
    label: Fill holes using 26-connectivity
    inputBinding:
      prefix: '-fillh26'
      position: 15
  edge:
    type:
      - 'null'
      - boolean
    label: Edge detection
    inputBinding:
      prefix: '-edge'
      position: 16
  add_value:
    type:
      - 'null'
      - double
    label: Add value to all voxels
    inputBinding:
      prefix: '-add'
      position: 17
  sub_value:
    type:
      - 'null'
      - double
    label: Subtract value from all voxels
    inputBinding:
      prefix: '-sub'
      position: 18
  mul_value:
    type:
      - 'null'
      - double
    label: Multiply all voxels by value
    inputBinding:
      prefix: '-mul'
      position: 19
  div_value:
    type:
      - 'null'
      - double
    label: Divide all voxels by value
    inputBinding:
      prefix: '-div'
      position: 20
  rem_value:
    type:
      - 'null'
      - double
    label: Remainder after dividing by value
    inputBinding:
      prefix: '-rem'
      position: 21
  thr:
    type:
      - 'null'
      - double
    label: Threshold below (set to 0)
    inputBinding:
      prefix: '-thr'
      position: 22
  thrp:
    type:
      - 'null'
      - double
    label: Threshold below percentage of robust range
    inputBinding:
      prefix: '-thrp'
      position: 23
  thrP:
    type:
      - 'null'
      - double
    label: Threshold below percentage of non-zero voxels
    inputBinding:
      prefix: '-thrP'
      position: 24
  uthr:
    type:
      - 'null'
      - double
    label: Upper threshold (set to 0 if above)
    inputBinding:
      prefix: '-uthr'
      position: 25
  uthrp:
    type:
      - 'null'
      - double
    label: Upper threshold percentage of robust range
    inputBinding:
      prefix: '-uthrp'
      position: 26
  uthrP:
    type:
      - 'null'
      - double
    label: Upper threshold percentage of non-zero voxels
    inputBinding:
      prefix: '-uthrP'
      position: 27
  add_file:
    type:
      - 'null'
      - File
    label: Add image
    inputBinding:
      prefix: '-add'
      position: 3
  sub_file:
    type:
      - 'null'
      - File
    label: Subtract image
    inputBinding:
      prefix: '-sub'
      position: 28
  mul_file:
    type:
      - 'null'
      - File
    label: Multiply by image
    inputBinding:
      prefix: '-mul'
      position: 29
  div_file:
    type:
      - 'null'
      - File
    label: Divide by image
    inputBinding:
      prefix: '-div'
      position: 30
  mas:
    type:
      - 'null'
      - File
    label: Apply mask (zero outside mask)
    inputBinding:
      prefix: '-mas'
      position: 31
  max_file:
    type:
      - 'null'
      - File
    label: Take maximum with image
    inputBinding:
      prefix: '-max'
      position: 32
  min_file:
    type:
      - 'null'
      - File
    label: Take minimum with image
    inputBinding:
      prefix: '-min'
      position: 33
  s:
    type:
      - 'null'
      - double
    label: Gaussian smoothing (sigma in mm)
    inputBinding:
      prefix: '-s'
      position: 34
  kernel_type:
    type:
      - 'null'
      - type: enum
        symbols:
          - 3D
          - 2D
          - box
          - boxv
          - boxv3
          - gauss
          - sphere
          - file
    label: Kernel type for morphological operations
    inputBinding:
      prefix: '-kernel'
      position: 35
  kernel_size:
    type:
      - 'null'
      - double
    label: Kernel size parameter
    inputBinding:
      position: 6
  dilM:
    type:
      - 'null'
      - boolean
    label: Mean dilation
    inputBinding:
      prefix: '-dilM'
      position: 36
  dilD:
    type:
      - 'null'
      - boolean
    label: Modal dilation
    inputBinding:
      prefix: '-dilD'
      position: 37
  dilF:
    type:
      - 'null'
      - boolean
    label: Full dilation (non-zero -> max)
    inputBinding:
      prefix: '-dilF'
      position: 38
  dilall:
    type:
      - 'null'
      - boolean
    label: Dilate all voxels
    inputBinding:
      prefix: '-dilall'
      position: 39
  ero:
    type:
      - 'null'
      - boolean
    label: Erosion (min)
    inputBinding:
      prefix: '-ero'
      position: 40
  eroF:
    type:
      - 'null'
      - boolean
    label: Erosion with filter
    inputBinding:
      prefix: '-eroF'
      position: 41
  fmedian:
    type:
      - 'null'
      - boolean
    label: Median filter
    inputBinding:
      prefix: '-fmedian'
      position: 42
  fmean:
    type:
      - 'null'
      - boolean
    label: Mean filter
    inputBinding:
      prefix: '-fmean'
      position: 43
  fmeanu:
    type:
      - 'null'
      - boolean
    label: Mean filter using non-zero neighbors only
    inputBinding:
      prefix: '-fmeanu'
      position: 44
  Tmean:
    type:
      - 'null'
      - boolean
    label: Mean across time
    inputBinding:
      prefix: '-Tmean'
      position: 45
  Tstd:
    type:
      - 'null'
      - boolean
    label: Standard deviation across time
    inputBinding:
      prefix: '-Tstd'
      position: 46
  Tmax:
    type:
      - 'null'
      - boolean
    label: Maximum across time
    inputBinding:
      prefix: '-Tmax'
      position: 47
  Tmaxn:
    type:
      - 'null'
      - boolean
    label: Time index of maximum
    inputBinding:
      prefix: '-Tmaxn'
      position: 48
  Tmin:
    type:
      - 'null'
      - boolean
    label: Minimum across time
    inputBinding:
      prefix: '-Tmin'
      position: 49
  Tmedian:
    type:
      - 'null'
      - boolean
    label: Median across time
    inputBinding:
      prefix: '-Tmedian'
      position: 50
  Tar1:
    type:
      - 'null'
      - boolean
    label: AR(1) coefficient across time
    inputBinding:
      prefix: '-Tar1'
      position: 51
  bptf:
    type:
      - 'null'
      - string
    label: Bandpass temporal filter (hp_sigma lp_sigma in volumes)
    inputBinding:
      prefix: '-bptf'
      position: 2
      shellQuote: false
  odt:
    type:
      - 'null'
      - type: enum
        symbols:
          - char
          - short
          - int
          - float
          - double
          - input
    label: Output data type
    inputBinding:
      prefix: '-odt'
      position: 98
  output:
    type: string
    label: Output filename
    inputBinding:
      position: 99
outputs:
  output_image:
    type: File
    outputBinding:
      glob:
        - $(inputs.output).nii.gz
        - $(inputs.output).nii
        - $(inputs.output)
  log:
    type: File
    outputBinding:
      glob: fslmaths.log
