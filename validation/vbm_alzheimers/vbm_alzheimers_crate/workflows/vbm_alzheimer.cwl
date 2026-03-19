#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow
inputs:
  bet_input:
    type:
      type: array
      items: File
  bet_output:
    type: string
  bet_overlay:
    type:
      - 'null'
      - boolean
  bet_mask:
    type:
      - 'null'
      - boolean
  bet_skull:
    type:
      - 'null'
      - boolean
  bet_ngenerate:
    type:
      - 'null'
      - boolean
  bet_frac:
    type:
      - 'null'
      - double
  bet_vert_frac:
    type:
      - 'null'
      - double
  bet_radius:
    type:
      - 'null'
      - double
  bet_cog:
    type:
      - 'null'
      - string
  bet_threshold:
    type:
      - 'null'
      - boolean
  bet_mesh:
    type:
      - 'null'
      - boolean
  bet_exclusive:
    type:
      - 'null'
      - Any
  fast_output:
    type: string
  fast_nclass:
    type:
      - 'null'
      - int
  fast_iterations:
    type:
      - 'null'
      - int
  fast_lowpass:
    type:
      - 'null'
      - double
  fast_image_type:
    type:
      - 'null'
      - int
  fast_fhard:
    type:
      - 'null'
      - double
  fast_segments:
    type:
      - 'null'
      - boolean
  fast_bias_field:
    type:
      - 'null'
      - boolean
  fast_bias_corrected_image:
    type:
      - 'null'
      - boolean
  fast_nobias:
    type:
      - 'null'
      - boolean
  fast_channels:
    type:
      - 'null'
      - int
  fast_initialization_iterations:
    type:
      - 'null'
      - int
  fast_mixel:
    type:
      - 'null'
      - double
  fast_fixed:
    type:
      - 'null'
      - int
  fast_hyper:
    type:
      - 'null'
      - double
  fast_manualseg:
    type:
      - 'null'
      - File
  fast_probability_maps:
    type:
      - 'null'
      - boolean
  fast_priors:
    type:
      - 'null'
      - Any
  flirt_reference:
    type: File
  flirt_output:
    type: string
  flirt_output_matrix:
    type:
      - 'null'
      - string
  flirt_dof:
    type:
      - 'null'
      - int
  flirt_init_matrix:
    type:
      - 'null'
      - File
  flirt_apply_xfm:
    type:
      - 'null'
      - boolean
  flirt_apply_isoxfm:
    type:
      - 'null'
      - double
  flirt_uses_qform:
    type:
      - 'null'
      - boolean
  flirt_rigid2D:
    type:
      - 'null'
      - boolean
  flirt_cost:
    type:
      - 'null'
      - type: enum
        symbols:
          - mutualinfo
          - corratio
          - normcorr
          - normmi
          - leastsq
          - labeldiff
          - bbr
  flirt_search_cost:
    type:
      - 'null'
      - type: enum
        symbols:
          - mutualinfo
          - corratio
          - normcorr
          - normmi
          - leastsq
          - labeldiff
          - bbr
  flirt_searchr_x:
    type:
      - 'null'
      - string
  flirt_searchr_y:
    type:
      - 'null'
      - string
  flirt_searchr_z:
    type:
      - 'null'
      - string
  flirt_no_search:
    type:
      - 'null'
      - boolean
  flirt_coarse_search:
    type:
      - 'null'
      - int
  flirt_fine_search:
    type:
      - 'null'
      - int
  flirt_interp:
    type:
      - 'null'
      - type: enum
        symbols:
          - trilinear
          - nearestneighbour
          - sinc
          - spline
  flirt_sinc_width:
    type:
      - 'null'
      - int
  flirt_sinc_window:
    type:
      - 'null'
      - type: enum
        symbols:
          - rectangular
          - hanning
          - blackman
  flirt_in_weight:
    type:
      - 'null'
      - File
  flirt_ref_weight:
    type:
      - 'null'
      - File
  flirt_bins:
    type:
      - 'null'
      - int
  flirt_min_sampling:
    type:
      - 'null'
      - double
  flirt_no_clamp:
    type:
      - 'null'
      - boolean
  flirt_no_resample:
    type:
      - 'null'
      - boolean
  flirt_padding_size:
    type:
      - 'null'
      - int
  flirt_datatype:
    type:
      - 'null'
      - type: enum
        symbols:
          - char
          - short
          - int
          - float
          - double
  flirt_verbose:
    type:
      - 'null'
      - int
  flirt_wm_seg:
    type:
      - 'null'
      - File
  flirt_bbrslope:
    type:
      - 'null'
      - double
  flirt_bbrtype:
    type:
      - 'null'
      - type: enum
        symbols:
          - signed
          - global_abs
          - local_abs
  flirt_fieldmap:
    type:
      - 'null'
      - File
  flirt_fieldmapmask:
    type:
      - 'null'
      - File
  flirt_echospacing:
    type:
      - 'null'
      - double
  flirt_pedir:
    type:
      - 'null'
      - int
  flirt_schedule:
    type:
      - 'null'
      - File
  fnirt_reference:
    type: File
  fnirt_inwarp:
    type:
      - 'null'
      - File
  fnirt_intin:
    type:
      - 'null'
      - File
  fnirt_config:
    type:
      - 'null'
      - File
  fnirt_refmask:
    type:
      - 'null'
      - File
  fnirt_inmask:
    type:
      - 'null'
      - File
  fnirt_cout:
    type:
      - 'null'
      - string
  fnirt_iout:
    type:
      - 'null'
      - string
  fnirt_fout:
    type:
      - 'null'
      - string
  fnirt_jout:
    type:
      - 'null'
      - string
  fnirt_refout:
    type:
      - 'null'
      - string
  fnirt_intout:
    type:
      - 'null'
      - string
  fnirt_logout:
    type:
      - 'null'
      - string
  fnirt_warpres:
    type:
      - 'null'
      - string
  fnirt_splineorder:
    type:
      - 'null'
      - int
  fnirt_regmod:
    type:
      - 'null'
      - type: enum
        symbols:
          - membrane_energy
          - bending_energy
  fnirt_intmod:
    type:
      - 'null'
      - type: enum
        symbols:
          - none
          - global_linear
          - global_non_linear
          - local_linear
          - global_non_linear_with_bias
          - local_non_linear
  fnirt_intorder:
    type:
      - 'null'
      - int
  fnirt_subsamp:
    type:
      - 'null'
      - string
  fnirt_miter:
    type:
      - 'null'
      - string
  fnirt_infwhm:
    type:
      - 'null'
      - string
  fnirt_reffwhm:
    type:
      - 'null'
      - string
  fnirt_lambda_:
    type:
      - 'null'
      - string
  fnirt_ssqlambda:
    type:
      - 'null'
      - int
  fnirt_jacrange:
    type:
      - 'null'
      - string
  fnirt_biasres:
    type:
      - 'null'
      - string
  fnirt_biaslambda:
    type:
      - 'null'
      - double
  fnirt_numprec:
    type:
      - 'null'
      - type: enum
        symbols:
          - float
          - double
  fnirt_verbose:
    type:
      - 'null'
      - boolean
  fslmaths_1_output:
    type: string
  fslmaths_1_abs:
    type:
      - 'null'
      - boolean
  fslmaths_1_bin:
    type:
      - 'null'
      - boolean
  fslmaths_1_binv:
    type:
      - 'null'
      - boolean
  fslmaths_1_recip:
    type:
      - 'null'
      - boolean
  fslmaths_1_sqrt:
    type:
      - 'null'
      - boolean
  fslmaths_1_sqr:
    type:
      - 'null'
      - boolean
  fslmaths_1_exp:
    type:
      - 'null'
      - boolean
  fslmaths_1_log:
    type:
      - 'null'
      - boolean
  fslmaths_1_nan:
    type:
      - 'null'
      - boolean
  fslmaths_1_nanm:
    type:
      - 'null'
      - boolean
  fslmaths_1_fillh:
    type:
      - 'null'
      - boolean
  fslmaths_1_fillh26:
    type:
      - 'null'
      - boolean
  fslmaths_1_edge:
    type:
      - 'null'
      - boolean
  fslmaths_1_add_value:
    type:
      - 'null'
      - double
  fslmaths_1_sub_value:
    type:
      - 'null'
      - double
  fslmaths_1_mul_value:
    type:
      - 'null'
      - double
  fslmaths_1_div_value:
    type:
      - 'null'
      - double
  fslmaths_1_rem_value:
    type:
      - 'null'
      - double
  fslmaths_1_thr:
    type:
      - 'null'
      - double
  fslmaths_1_thrp:
    type:
      - 'null'
      - double
  fslmaths_1_thrP:
    type:
      - 'null'
      - double
  fslmaths_1_uthr:
    type:
      - 'null'
      - double
  fslmaths_1_uthrp:
    type:
      - 'null'
      - double
  fslmaths_1_uthrP:
    type:
      - 'null'
      - double
  fslmaths_1_add_file:
    type:
      - 'null'
      - File
  fslmaths_1_sub_file:
    type:
      - 'null'
      - File
  fslmaths_1_div_file:
    type:
      - 'null'
      - File
  fslmaths_1_mas:
    type:
      - 'null'
      - File
  fslmaths_1_max_file:
    type:
      - 'null'
      - File
  fslmaths_1_min_file:
    type:
      - 'null'
      - File
  fslmaths_1_s:
    type:
      - 'null'
      - double
  fslmaths_1_kernel_type:
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
  fslmaths_1_kernel_size:
    type:
      - 'null'
      - double
  fslmaths_1_dilM:
    type:
      - 'null'
      - boolean
  fslmaths_1_dilD:
    type:
      - 'null'
      - boolean
  fslmaths_1_dilF:
    type:
      - 'null'
      - boolean
  fslmaths_1_dilall:
    type:
      - 'null'
      - boolean
  fslmaths_1_ero:
    type:
      - 'null'
      - boolean
  fslmaths_1_eroF:
    type:
      - 'null'
      - boolean
  fslmaths_1_fmedian:
    type:
      - 'null'
      - boolean
  fslmaths_1_fmean:
    type:
      - 'null'
      - boolean
  fslmaths_1_fmeanu:
    type:
      - 'null'
      - boolean
  fslmaths_1_Tmean:
    type:
      - 'null'
      - boolean
  fslmaths_1_Tstd:
    type:
      - 'null'
      - boolean
  fslmaths_1_Tmax:
    type:
      - 'null'
      - boolean
  fslmaths_1_Tmaxn:
    type:
      - 'null'
      - boolean
  fslmaths_1_Tmin:
    type:
      - 'null'
      - boolean
  fslmaths_1_Tmedian:
    type:
      - 'null'
      - boolean
  fslmaths_1_Tar1:
    type:
      - 'null'
      - boolean
  fslmaths_1_bptf:
    type:
      - 'null'
      - string
  fslmaths_1_odt:
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
  fslmaths_2_output:
    type: string
  fslmaths_2_abs:
    type:
      - 'null'
      - boolean
  fslmaths_2_bin:
    type:
      - 'null'
      - boolean
  fslmaths_2_binv:
    type:
      - 'null'
      - boolean
  fslmaths_2_recip:
    type:
      - 'null'
      - boolean
  fslmaths_2_sqrt:
    type:
      - 'null'
      - boolean
  fslmaths_2_sqr:
    type:
      - 'null'
      - boolean
  fslmaths_2_exp:
    type:
      - 'null'
      - boolean
  fslmaths_2_log:
    type:
      - 'null'
      - boolean
  fslmaths_2_nan:
    type:
      - 'null'
      - boolean
  fslmaths_2_nanm:
    type:
      - 'null'
      - boolean
  fslmaths_2_fillh:
    type:
      - 'null'
      - boolean
  fslmaths_2_fillh26:
    type:
      - 'null'
      - boolean
  fslmaths_2_edge:
    type:
      - 'null'
      - boolean
  fslmaths_2_add_value:
    type:
      - 'null'
      - double
  fslmaths_2_sub_value:
    type:
      - 'null'
      - double
  fslmaths_2_mul_value:
    type:
      - 'null'
      - double
  fslmaths_2_div_value:
    type:
      - 'null'
      - double
  fslmaths_2_rem_value:
    type:
      - 'null'
      - double
  fslmaths_2_thr:
    type:
      - 'null'
      - double
  fslmaths_2_thrp:
    type:
      - 'null'
      - double
  fslmaths_2_thrP:
    type:
      - 'null'
      - double
  fslmaths_2_uthr:
    type:
      - 'null'
      - double
  fslmaths_2_uthrp:
    type:
      - 'null'
      - double
  fslmaths_2_uthrP:
    type:
      - 'null'
      - double
  fslmaths_2_add_file:
    type:
      - 'null'
      - File
  fslmaths_2_sub_file:
    type:
      - 'null'
      - File
  fslmaths_2_mul_file:
    type:
      - 'null'
      - File
  fslmaths_2_div_file:
    type:
      - 'null'
      - File
  fslmaths_2_mas:
    type:
      - 'null'
      - File
  fslmaths_2_max_file:
    type:
      - 'null'
      - File
  fslmaths_2_min_file:
    type:
      - 'null'
      - File
  fslmaths_2_s:
    type:
      - 'null'
      - double
  fslmaths_2_kernel_type:
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
  fslmaths_2_kernel_size:
    type:
      - 'null'
      - double
  fslmaths_2_dilM:
    type:
      - 'null'
      - boolean
  fslmaths_2_dilD:
    type:
      - 'null'
      - boolean
  fslmaths_2_dilF:
    type:
      - 'null'
      - boolean
  fslmaths_2_dilall:
    type:
      - 'null'
      - boolean
  fslmaths_2_ero:
    type:
      - 'null'
      - boolean
  fslmaths_2_eroF:
    type:
      - 'null'
      - boolean
  fslmaths_2_fmedian:
    type:
      - 'null'
      - boolean
  fslmaths_2_fmean:
    type:
      - 'null'
      - boolean
  fslmaths_2_fmeanu:
    type:
      - 'null'
      - boolean
  fslmaths_2_Tmean:
    type:
      - 'null'
      - boolean
  fslmaths_2_Tstd:
    type:
      - 'null'
      - boolean
  fslmaths_2_Tmax:
    type:
      - 'null'
      - boolean
  fslmaths_2_Tmaxn:
    type:
      - 'null'
      - boolean
  fslmaths_2_Tmin:
    type:
      - 'null'
      - boolean
  fslmaths_2_Tmedian:
    type:
      - 'null'
      - boolean
  fslmaths_2_Tar1:
    type:
      - 'null'
      - boolean
  fslmaths_2_bptf:
    type:
      - 'null'
      - string
  fslmaths_2_odt:
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
outputs:
  output_image:
    type:
      type: array
      items: File
    outputSource: fslmaths_2/output_image
  log:
    type:
      type: array
      items: File
    outputSource: fslmaths_2/log
steps:
  bet:
    run: ../cwl/fsl/bet.cwl
    scatter: input
    in:
      input: bet_input
      output: bet_output
      overlay: bet_overlay
      mask: bet_mask
      skull: bet_skull
      ngenerate: bet_ngenerate
      frac: bet_frac
      vert_frac: bet_vert_frac
      radius: bet_radius
      cog: bet_cog
      threshold: bet_threshold
      mesh: bet_mesh
      exclusive: bet_exclusive
    out:
      - brain_extraction
      - brain_mask
      - brain_skull
      - brain_mesh
      - brain_registration
      - log
    hints:
      DockerRequirement:
        dockerPull: brainlife/fsl:6.0.4-patched2
  fast:
    run: ../cwl/fsl/fast.cwl
    scatter: input
    in:
      input: bet/brain_extraction
      output: fast_output
      nclass: fast_nclass
      iterations: fast_iterations
      lowpass: fast_lowpass
      image_type: fast_image_type
      fhard: fast_fhard
      segments: fast_segments
      bias_field: fast_bias_field
      bias_corrected_image: fast_bias_corrected_image
      nobias: fast_nobias
      channels: fast_channels
      initialization_iterations: fast_initialization_iterations
      mixel: fast_mixel
      fixed: fast_fixed
      hyper: fast_hyper
      manualseg: fast_manualseg
      probability_maps: fast_probability_maps
      priors: fast_priors
    out:
      - segmented_files
      - output_bias_field
      - output_bias_corrected_image
      - output_probability_maps
      - output_segments
      - log
    hints:
      DockerRequirement:
        dockerPull: brainlife/fsl:6.0.4-patched2
  flirt:
    run: ../cwl/fsl/flirt.cwl
    scatter: input
    in:
      input:
        source: fast/segmented_files
        valueFrom: >-
          $(self.filter(function(f) { return f.basename.indexOf('pve_1') !== -1;
          })[0])
      reference: flirt_reference
      output: flirt_output
      output_matrix: flirt_output_matrix
      dof: flirt_dof
      init_matrix: flirt_init_matrix
      apply_xfm: flirt_apply_xfm
      apply_isoxfm: flirt_apply_isoxfm
      uses_qform: flirt_uses_qform
      rigid2D: flirt_rigid2D
      cost: flirt_cost
      search_cost: flirt_search_cost
      searchr_x: flirt_searchr_x
      searchr_y: flirt_searchr_y
      searchr_z: flirt_searchr_z
      no_search: flirt_no_search
      coarse_search: flirt_coarse_search
      fine_search: flirt_fine_search
      interp: flirt_interp
      sinc_width: flirt_sinc_width
      sinc_window: flirt_sinc_window
      in_weight: flirt_in_weight
      ref_weight: flirt_ref_weight
      bins: flirt_bins
      min_sampling: flirt_min_sampling
      no_clamp: flirt_no_clamp
      no_resample: flirt_no_resample
      padding_size: flirt_padding_size
      datatype: flirt_datatype
      verbose: flirt_verbose
      wm_seg: flirt_wm_seg
      bbrslope: flirt_bbrslope
      bbrtype: flirt_bbrtype
      fieldmap: flirt_fieldmap
      fieldmapmask: flirt_fieldmapmask
      echospacing: flirt_echospacing
      pedir: flirt_pedir
      schedule: flirt_schedule
    out:
      - registered_image
      - transformation_matrix
      - log
    hints:
      DockerRequirement:
        dockerPull: brainlife/fsl:6.0.4-patched2
  fnirt:
    run: ../cwl/fsl/fnirt.cwl
    scatter:
      - affine
      - input
    scatterMethod: dotproduct
    in:
      input: bet/brain_extraction
      reference: fnirt_reference
      affine: flirt/transformation_matrix
      inwarp: fnirt_inwarp
      intin: fnirt_intin
      config: fnirt_config
      refmask: fnirt_refmask
      inmask: fnirt_inmask
      cout: fnirt_cout
      iout: fnirt_iout
      fout: fnirt_fout
      jout: fnirt_jout
      refout: fnirt_refout
      intout: fnirt_intout
      logout: fnirt_logout
      warpres: fnirt_warpres
      splineorder: fnirt_splineorder
      regmod: fnirt_regmod
      intmod: fnirt_intmod
      intorder: fnirt_intorder
      subsamp: fnirt_subsamp
      miter: fnirt_miter
      infwhm: fnirt_infwhm
      reffwhm: fnirt_reffwhm
      lambda_: fnirt_lambda_
      ssqlambda: fnirt_ssqlambda
      jacrange: fnirt_jacrange
      biasres: fnirt_biasres
      biaslambda: fnirt_biaslambda
      numprec: fnirt_numprec
      verbose: fnirt_verbose
    out:
      - warp_coefficients
      - warped_image
      - displacement_field
      - jacobian_map
      - intensity_modulated_ref
      - log
    hints:
      DockerRequirement:
        dockerPull: brainlife/fsl:6.0.4-patched2
  fslmaths_1:
    run: ../cwl/fsl/fslmaths.cwl
    scatter:
      - input
      - mul_file
    scatterMethod: dotproduct
    in:
      input: flirt/registered_image
      output: fslmaths_1_output
      abs: fslmaths_1_abs
      bin: fslmaths_1_bin
      binv: fslmaths_1_binv
      recip: fslmaths_1_recip
      sqrt: fslmaths_1_sqrt
      sqr: fslmaths_1_sqr
      exp: fslmaths_1_exp
      log: fslmaths_1_log
      nan: fslmaths_1_nan
      nanm: fslmaths_1_nanm
      fillh: fslmaths_1_fillh
      fillh26: fslmaths_1_fillh26
      edge: fslmaths_1_edge
      add_value: fslmaths_1_add_value
      sub_value: fslmaths_1_sub_value
      mul_value: fslmaths_1_mul_value
      div_value: fslmaths_1_div_value
      rem_value: fslmaths_1_rem_value
      thr: fslmaths_1_thr
      thrp: fslmaths_1_thrp
      thrP: fslmaths_1_thrP
      uthr: fslmaths_1_uthr
      uthrp: fslmaths_1_uthrp
      uthrP: fslmaths_1_uthrP
      add_file: fslmaths_1_add_file
      sub_file: fslmaths_1_sub_file
      mul_file: fnirt/jacobian_map
      div_file: fslmaths_1_div_file
      mas: fslmaths_1_mas
      max_file: fslmaths_1_max_file
      min_file: fslmaths_1_min_file
      s: fslmaths_1_s
      kernel_type: fslmaths_1_kernel_type
      kernel_size: fslmaths_1_kernel_size
      dilM: fslmaths_1_dilM
      dilD: fslmaths_1_dilD
      dilF: fslmaths_1_dilF
      dilall: fslmaths_1_dilall
      ero: fslmaths_1_ero
      eroF: fslmaths_1_eroF
      fmedian: fslmaths_1_fmedian
      fmean: fslmaths_1_fmean
      fmeanu: fslmaths_1_fmeanu
      Tmean: fslmaths_1_Tmean
      Tstd: fslmaths_1_Tstd
      Tmax: fslmaths_1_Tmax
      Tmaxn: fslmaths_1_Tmaxn
      Tmin: fslmaths_1_Tmin
      Tmedian: fslmaths_1_Tmedian
      Tar1: fslmaths_1_Tar1
      bptf: fslmaths_1_bptf
      odt: fslmaths_1_odt
    out:
      - output_image
      - log
    hints:
      DockerRequirement:
        dockerPull: brainlife/fsl:6.0.4-patched2
  fslmaths_2:
    run: ../cwl/fsl/fslmaths.cwl
    scatter: input
    in:
      input: fslmaths_1/output_image
      output: fslmaths_2_output
      abs: fslmaths_2_abs
      bin: fslmaths_2_bin
      binv: fslmaths_2_binv
      recip: fslmaths_2_recip
      sqrt: fslmaths_2_sqrt
      sqr: fslmaths_2_sqr
      exp: fslmaths_2_exp
      log: fslmaths_2_log
      nan: fslmaths_2_nan
      nanm: fslmaths_2_nanm
      fillh: fslmaths_2_fillh
      fillh26: fslmaths_2_fillh26
      edge: fslmaths_2_edge
      add_value: fslmaths_2_add_value
      sub_value: fslmaths_2_sub_value
      mul_value: fslmaths_2_mul_value
      div_value: fslmaths_2_div_value
      rem_value: fslmaths_2_rem_value
      thr: fslmaths_2_thr
      thrp: fslmaths_2_thrp
      thrP: fslmaths_2_thrP
      uthr: fslmaths_2_uthr
      uthrp: fslmaths_2_uthrp
      uthrP: fslmaths_2_uthrP
      add_file: fslmaths_2_add_file
      sub_file: fslmaths_2_sub_file
      mul_file: fslmaths_2_mul_file
      div_file: fslmaths_2_div_file
      mas: fslmaths_2_mas
      max_file: fslmaths_2_max_file
      min_file: fslmaths_2_min_file
      s: fslmaths_2_s
      kernel_type: fslmaths_2_kernel_type
      kernel_size: fslmaths_2_kernel_size
      dilM: fslmaths_2_dilM
      dilD: fslmaths_2_dilD
      dilF: fslmaths_2_dilF
      dilall: fslmaths_2_dilall
      ero: fslmaths_2_ero
      eroF: fslmaths_2_eroF
      fmedian: fslmaths_2_fmedian
      fmean: fslmaths_2_fmean
      fmeanu: fslmaths_2_fmeanu
      Tmean: fslmaths_2_Tmean
      Tstd: fslmaths_2_Tstd
      Tmax: fslmaths_2_Tmax
      Tmaxn: fslmaths_2_Tmaxn
      Tmin: fslmaths_2_Tmin
      Tmedian: fslmaths_2_Tmedian
      Tar1: fslmaths_2_Tar1
      bptf: fslmaths_2_bptf
      odt: fslmaths_2_odt
    out:
      - output_image
      - log
    hints:
      DockerRequirement:
        dockerPull: brainlife/fsl:6.0.4-patched2
requirements:
  InlineJavascriptRequirement: {}
  ScatterFeatureRequirement: {}
  StepInputExpressionRequirement: {}
