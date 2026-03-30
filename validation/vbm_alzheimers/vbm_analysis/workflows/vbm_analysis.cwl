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
  applywarp_reference:
    type: File
  applywarp_output:
    type: string
  applywarp_premat:
    type:
      - 'null'
      - File
  applywarp_postmat:
    type:
      - 'null'
      - File
  applywarp_relwarp:
    type:
      - 'null'
      - boolean
  applywarp_abswarp:
    type:
      - 'null'
      - boolean
  applywarp_interp:
    type:
      - 'null'
      - type: enum
        symbols:
          - nn
          - trilinear
          - sinc
          - spline
  applywarp_supersample:
    type:
      - 'null'
      - boolean
  applywarp_superlevel:
    type:
      - 'null'
      - string
  applywarp_mask:
    type:
      - 'null'
      - File
  applywarp_datatype:
    type:
      - 'null'
      - type: enum
        symbols:
          - char
          - short
          - int
          - float
          - double
  applywarp_padding_size:
    type:
      - 'null'
      - int
  applywarp_verbose:
    type:
      - 'null'
      - boolean
  fslmaths_output:
    type: string
  fslmaths_abs:
    type:
      - 'null'
      - boolean
  fslmaths_bin:
    type:
      - 'null'
      - boolean
  fslmaths_binv:
    type:
      - 'null'
      - boolean
  fslmaths_recip:
    type:
      - 'null'
      - boolean
  fslmaths_sqrt:
    type:
      - 'null'
      - boolean
  fslmaths_sqr:
    type:
      - 'null'
      - boolean
  fslmaths_exp:
    type:
      - 'null'
      - boolean
  fslmaths_log:
    type:
      - 'null'
      - boolean
  fslmaths_sin:
    type:
      - 'null'
      - boolean
  fslmaths_cos:
    type:
      - 'null'
      - boolean
  fslmaths_tan:
    type:
      - 'null'
      - boolean
  fslmaths_asin:
    type:
      - 'null'
      - boolean
  fslmaths_acos:
    type:
      - 'null'
      - boolean
  fslmaths_atan:
    type:
      - 'null'
      - boolean
  fslmaths_nan:
    type:
      - 'null'
      - boolean
  fslmaths_nanm:
    type:
      - 'null'
      - boolean
  fslmaths_fillh:
    type:
      - 'null'
      - boolean
  fslmaths_fillh26:
    type:
      - 'null'
      - boolean
  fslmaths_edge:
    type:
      - 'null'
      - boolean
  fslmaths_index:
    type:
      - 'null'
      - boolean
  fslmaths_rand:
    type:
      - 'null'
      - boolean
  fslmaths_randn:
    type:
      - 'null'
      - boolean
  fslmaths_range:
    type:
      - 'null'
      - boolean
  fslmaths_seed:
    type:
      - 'null'
      - int
  fslmaths_add_value:
    type:
      - 'null'
      - double
  fslmaths_sub_value:
    type:
      - 'null'
      - double
  fslmaths_mul_value:
    type:
      - 'null'
      - double
  fslmaths_div_value:
    type:
      - 'null'
      - double
  fslmaths_rem_value:
    type:
      - 'null'
      - double
  fslmaths_thr:
    type:
      - 'null'
      - double
  fslmaths_thrp:
    type:
      - 'null'
      - double
  fslmaths_thrP:
    type:
      - 'null'
      - double
  fslmaths_uthr:
    type:
      - 'null'
      - double
  fslmaths_uthrp:
    type:
      - 'null'
      - double
  fslmaths_uthrP:
    type:
      - 'null'
      - double
  fslmaths_add_file:
    type:
      - 'null'
      - File
  fslmaths_sub_file:
    type:
      - 'null'
      - File
  fslmaths_div_file:
    type:
      - 'null'
      - File
  fslmaths_mas:
    type:
      - 'null'
      - File
  fslmaths_max_file:
    type:
      - 'null'
      - File
  fslmaths_min_file:
    type:
      - 'null'
      - File
  fslmaths_s:
    type:
      - 'null'
      - double
  fslmaths_kernel_type:
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
  fslmaths_kernel_size:
    type:
      - 'null'
      - double
  fslmaths_dilM:
    type:
      - 'null'
      - boolean
  fslmaths_dilD:
    type:
      - 'null'
      - boolean
  fslmaths_dilF:
    type:
      - 'null'
      - boolean
  fslmaths_dilall:
    type:
      - 'null'
      - boolean
  fslmaths_ero:
    type:
      - 'null'
      - boolean
  fslmaths_eroF:
    type:
      - 'null'
      - boolean
  fslmaths_fmedian:
    type:
      - 'null'
      - boolean
  fslmaths_fmean:
    type:
      - 'null'
      - boolean
  fslmaths_fmeanu:
    type:
      - 'null'
      - boolean
  fslmaths_subsamp2:
    type:
      - 'null'
      - boolean
  fslmaths_subsamp2offc:
    type:
      - 'null'
      - boolean
  fslmaths_Tmean:
    type:
      - 'null'
      - boolean
  fslmaths_Tstd:
    type:
      - 'null'
      - boolean
  fslmaths_Tmax:
    type:
      - 'null'
      - boolean
  fslmaths_Tmaxn:
    type:
      - 'null'
      - boolean
  fslmaths_Tmin:
    type:
      - 'null'
      - boolean
  fslmaths_Tmedian:
    type:
      - 'null'
      - boolean
  fslmaths_Tperc:
    type:
      - 'null'
      - double
  fslmaths_Tar1:
    type:
      - 'null'
      - boolean
  fslmaths_bptf:
    type:
      - 'null'
      - string
  fslmaths_inm:
    type:
      - 'null'
      - double
  fslmaths_ing:
    type:
      - 'null'
      - double
  fslmaths_pval:
    type:
      - 'null'
      - boolean
  fslmaths_pval0:
    type:
      - 'null'
      - boolean
  fslmaths_cpval:
    type:
      - 'null'
      - boolean
  fslmaths_ztop:
    type:
      - 'null'
      - boolean
  fslmaths_ptoz:
    type:
      - 'null'
      - boolean
  fslmaths_rank:
    type:
      - 'null'
      - boolean
  fslmaths_ranknorm:
    type:
      - 'null'
      - boolean
  fslmaths_tfce:
    type:
      - 'null'
      - string
  fslmaths_roi:
    type:
      - 'null'
      - string
  fslmaths_tensor_decomp:
    type:
      - 'null'
      - boolean
  fslmaths_odt:
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
  fslmerge_dimension:
    type:
      type: enum
      symbols:
        - t
        - x
        - 'y'
        - z
        - a
  fslmerge_output:
    type: string
  fslmerge_tr:
    type:
      - 'null'
      - double
  randomise_output:
    type: string
  randomise_design_mat:
    type:
      - 'null'
      - File
  randomise_tcon:
    type:
      - 'null'
      - File
  randomise_fcon:
    type:
      - 'null'
      - File
  randomise_mask:
    type:
      - 'null'
      - File
  randomise_num_perm:
    type:
      - 'null'
      - int
  randomise_seed:
    type:
      - 'null'
      - int
  randomise_one_sample_group_mean:
    type:
      - 'null'
      - boolean
  randomise_tfce:
    type:
      - 'null'
      - boolean
  randomise_tfce2D:
    type:
      - 'null'
      - boolean
  randomise_tfce_H:
    type:
      - 'null'
      - double
  randomise_tfce_E:
    type:
      - 'null'
      - double
  randomise_tfce_C:
    type:
      - 'null'
      - double
  randomise_c_thresh:
    type:
      - 'null'
      - double
  randomise_cm_thresh:
    type:
      - 'null'
      - double
  randomise_f_c_thresh:
    type:
      - 'null'
      - double
  randomise_f_cm_thresh:
    type:
      - 'null'
      - double
  randomise_demean:
    type:
      - 'null'
      - boolean
  randomise_vox_p_values:
    type:
      - 'null'
      - boolean
  randomise_f_only:
    type:
      - 'null'
      - boolean
  randomise_raw_stats_imgs:
    type:
      - 'null'
      - boolean
  randomise_p_vec_n_dist_files:
    type:
      - 'null'
      - boolean
  randomise_var_smooth:
    type:
      - 'null'
      - int
  randomise_x_block_labels:
    type:
      - 'null'
      - File
  randomise_show_total_perms:
    type:
      - 'null'
      - boolean
  randomise_show_info_parallel_mode:
    type:
      - 'null'
      - boolean
outputs:
  t_corrp:
    type:
      type: array
      items: File
    outputSource: randomise/t_corrp
  t_p:
    type:
      type: array
      items: File
    outputSource: randomise/t_p
  tstat:
    type:
      type: array
      items: File
    outputSource: randomise/tstat
  f_corrp:
    type:
      - 'null'
      - File[]
    outputSource: randomise/f_corrp
  f_p:
    type:
      - 'null'
      - File[]
    outputSource: randomise/f_p
  fstat:
    type:
      - 'null'
      - File[]
    outputSource: randomise/fstat
  log:
    type: File
    outputSource: randomise/log
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
        dockerPull: brainlife/fsl:latest
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
        dockerPull: brainlife/fsl:latest
  flirt:
    run: ../cwl/fsl/flirt.cwl
    scatter: input
    in:
      input: bet/brain_extraction
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
        dockerPull: brainlife/fsl:latest
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
        dockerPull: brainlife/fsl:latest
  applywarp:
    run: ../cwl/fsl/applywarp.cwl
    scatter:
      - input
      - warp
    scatterMethod: dotproduct
    in:
      input:
        source: fast/segmented_files
        valueFrom: >-
          $(self.filter(function(f) { return f.basename.indexOf('pve_1') !== -1;
          })[0])
      reference: applywarp_reference
      output: applywarp_output
      warp: fnirt/warp_coefficients
      premat: applywarp_premat
      postmat: applywarp_postmat
      relwarp: applywarp_relwarp
      abswarp: applywarp_abswarp
      interp: applywarp_interp
      supersample: applywarp_supersample
      superlevel: applywarp_superlevel
      mask: applywarp_mask
      datatype: applywarp_datatype
      padding_size: applywarp_padding_size
      verbose: applywarp_verbose
    out:
      - warped_image
      - log
    hints:
      DockerRequirement:
        dockerPull: brainlife/fsl:latest
  fslmaths:
    run: ../cwl/fsl/fslmaths.cwl
    scatter:
      - mul_file
      - input
    scatterMethod: dotproduct
    in:
      input: applywarp/warped_image
      output: fslmaths_output
      abs: fslmaths_abs
      bin: fslmaths_bin
      binv: fslmaths_binv
      recip: fslmaths_recip
      sqrt: fslmaths_sqrt
      sqr: fslmaths_sqr
      exp: fslmaths_exp
      log: fslmaths_log
      sin: fslmaths_sin
      cos: fslmaths_cos
      tan: fslmaths_tan
      asin: fslmaths_asin
      acos: fslmaths_acos
      atan: fslmaths_atan
      nan: fslmaths_nan
      nanm: fslmaths_nanm
      fillh: fslmaths_fillh
      fillh26: fslmaths_fillh26
      edge: fslmaths_edge
      index: fslmaths_index
      rand: fslmaths_rand
      randn: fslmaths_randn
      range: fslmaths_range
      seed: fslmaths_seed
      add_value: fslmaths_add_value
      sub_value: fslmaths_sub_value
      mul_value: fslmaths_mul_value
      div_value: fslmaths_div_value
      rem_value: fslmaths_rem_value
      thr: fslmaths_thr
      thrp: fslmaths_thrp
      thrP: fslmaths_thrP
      uthr: fslmaths_uthr
      uthrp: fslmaths_uthrp
      uthrP: fslmaths_uthrP
      add_file: fslmaths_add_file
      sub_file: fslmaths_sub_file
      mul_file: fnirt/jacobian_map
      div_file: fslmaths_div_file
      mas: fslmaths_mas
      max_file: fslmaths_max_file
      min_file: fslmaths_min_file
      s: fslmaths_s
      kernel_type: fslmaths_kernel_type
      kernel_size: fslmaths_kernel_size
      dilM: fslmaths_dilM
      dilD: fslmaths_dilD
      dilF: fslmaths_dilF
      dilall: fslmaths_dilall
      ero: fslmaths_ero
      eroF: fslmaths_eroF
      fmedian: fslmaths_fmedian
      fmean: fslmaths_fmean
      fmeanu: fslmaths_fmeanu
      subsamp2: fslmaths_subsamp2
      subsamp2offc: fslmaths_subsamp2offc
      Tmean: fslmaths_Tmean
      Tstd: fslmaths_Tstd
      Tmax: fslmaths_Tmax
      Tmaxn: fslmaths_Tmaxn
      Tmin: fslmaths_Tmin
      Tmedian: fslmaths_Tmedian
      Tperc: fslmaths_Tperc
      Tar1: fslmaths_Tar1
      bptf: fslmaths_bptf
      inm: fslmaths_inm
      ing: fslmaths_ing
      pval: fslmaths_pval
      pval0: fslmaths_pval0
      cpval: fslmaths_cpval
      ztop: fslmaths_ztop
      ptoz: fslmaths_ptoz
      rank: fslmaths_rank
      ranknorm: fslmaths_ranknorm
      tfce: fslmaths_tfce
      roi: fslmaths_roi
      tensor_decomp: fslmaths_tensor_decomp
      odt: fslmaths_odt
    out:
      - output_image
      - log
    hints:
      DockerRequirement:
        dockerPull: brainlife/fsl:latest
  fslmerge:
    run: ../cwl/fsl/fslmerge.cwl
    in:
      dimension: fslmerge_dimension
      output: fslmerge_output
      input_files: fslmaths/output_image
      tr: fslmerge_tr
    out:
      - merged_image
      - log
    hints:
      DockerRequirement:
        dockerPull: brainlife/fsl:latest
  randomise:
    run: ../cwl/fsl/randomise.cwl
    in:
      input: fslmerge/merged_image
      output: randomise_output
      design_mat: randomise_design_mat
      tcon: randomise_tcon
      fcon: randomise_fcon
      mask: randomise_mask
      num_perm: randomise_num_perm
      seed: randomise_seed
      one_sample_group_mean: randomise_one_sample_group_mean
      tfce: randomise_tfce
      tfce2D: randomise_tfce2D
      tfce_H: randomise_tfce_H
      tfce_E: randomise_tfce_E
      tfce_C: randomise_tfce_C
      c_thresh: randomise_c_thresh
      cm_thresh: randomise_cm_thresh
      f_c_thresh: randomise_f_c_thresh
      f_cm_thresh: randomise_f_cm_thresh
      demean: randomise_demean
      vox_p_values: randomise_vox_p_values
      f_only: randomise_f_only
      raw_stats_imgs: randomise_raw_stats_imgs
      p_vec_n_dist_files: randomise_p_vec_n_dist_files
      var_smooth: randomise_var_smooth
      x_block_labels: randomise_x_block_labels
      show_total_perms: randomise_show_total_perms
      show_info_parallel_mode: randomise_show_info_parallel_mode
    out:
      - t_corrp
      - t_p
      - tstat
      - f_corrp
      - f_p
      - fstat
      - log
    hints:
      DockerRequirement:
        dockerPull: brainlife/fsl:latest
requirements:
  InlineJavascriptRequirement: {}
  ScatterFeatureRequirement: {}
  StepInputExpressionRequirement: {}
