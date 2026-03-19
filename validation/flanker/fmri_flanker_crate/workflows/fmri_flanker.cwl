#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow
inputs:
  t1w:
    type:
      type: array
      items: File
  bold:
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
  mcflirt_output:
    type: string
  mcflirt_ref_vol:
    type:
      - 'null'
      - int
  mcflirt_ref_file:
    type:
      - 'null'
      - File
  mcflirt_mean_vol:
    type:
      - 'null'
      - boolean
  mcflirt_cost:
    type:
      - 'null'
      - type: enum
        symbols:
          - mutualinfo
          - woods
          - corratio
          - normcorr
          - normmi
          - leastsquares
  mcflirt_dof:
    type:
      - 'null'
      - int
  mcflirt_init:
    type:
      - 'null'
      - File
  mcflirt_interpolation:
    type:
      - 'null'
      - type: enum
        symbols:
          - spline
          - nn
          - sinc
  mcflirt_save_mats:
    type:
      - 'null'
      - boolean
  mcflirt_save_plots:
    type:
      - 'null'
      - boolean
  mcflirt_save_rms:
    type:
      - 'null'
      - boolean
  mcflirt_stats:
    type:
      - 'null'
      - boolean
  mcflirt_stages:
    type:
      - 'null'
      - int
  mcflirt_bins:
    type:
      - 'null'
      - int
  mcflirt_smooth:
    type:
      - 'null'
      - double
  mcflirt_scaling:
    type:
      - 'null'
      - double
  mcflirt_rotation:
    type:
      - 'null'
      - int
  mcflirt_edge:
    type:
      - 'null'
      - boolean
  mcflirt_gdt:
    type:
      - 'null'
      - boolean
  flirt_1_reference:
    type: File
  flirt_1_output:
    type: string
  flirt_1_output_matrix:
    type:
      - 'null'
      - string
  flirt_1_dof:
    type:
      - 'null'
      - int
  flirt_1_init_matrix:
    type:
      - 'null'
      - File
  flirt_1_apply_xfm:
    type:
      - 'null'
      - boolean
  flirt_1_apply_isoxfm:
    type:
      - 'null'
      - double
  flirt_1_uses_qform:
    type:
      - 'null'
      - boolean
  flirt_1_rigid2D:
    type:
      - 'null'
      - boolean
  flirt_1_cost:
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
  flirt_1_search_cost:
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
  flirt_1_searchr_x:
    type:
      - 'null'
      - string
  flirt_1_searchr_y:
    type:
      - 'null'
      - string
  flirt_1_searchr_z:
    type:
      - 'null'
      - string
  flirt_1_no_search:
    type:
      - 'null'
      - boolean
  flirt_1_coarse_search:
    type:
      - 'null'
      - int
  flirt_1_fine_search:
    type:
      - 'null'
      - int
  flirt_1_interp:
    type:
      - 'null'
      - type: enum
        symbols:
          - trilinear
          - nearestneighbour
          - sinc
          - spline
  flirt_1_sinc_width:
    type:
      - 'null'
      - int
  flirt_1_sinc_window:
    type:
      - 'null'
      - type: enum
        symbols:
          - rectangular
          - hanning
          - blackman
  flirt_1_in_weight:
    type:
      - 'null'
      - File
  flirt_1_ref_weight:
    type:
      - 'null'
      - File
  flirt_1_bins:
    type:
      - 'null'
      - int
  flirt_1_min_sampling:
    type:
      - 'null'
      - double
  flirt_1_no_clamp:
    type:
      - 'null'
      - boolean
  flirt_1_no_resample:
    type:
      - 'null'
      - boolean
  flirt_1_padding_size:
    type:
      - 'null'
      - int
  flirt_1_datatype:
    type:
      - 'null'
      - type: enum
        symbols:
          - char
          - short
          - int
          - float
          - double
  flirt_1_verbose:
    type:
      - 'null'
      - int
  flirt_1_wm_seg:
    type:
      - 'null'
      - File
  flirt_1_bbrslope:
    type:
      - 'null'
      - double
  flirt_1_bbrtype:
    type:
      - 'null'
      - type: enum
        symbols:
          - signed
          - global_abs
          - local_abs
  flirt_1_fieldmap:
    type:
      - 'null'
      - File
  flirt_1_fieldmapmask:
    type:
      - 'null'
      - File
  flirt_1_echospacing:
    type:
      - 'null'
      - double
  flirt_1_pedir:
    type:
      - 'null'
      - int
  flirt_1_schedule:
    type:
      - 'null'
      - File
  slicetimer_output:
    type: string
  slicetimer_tr:
    type:
      - 'null'
      - double
  slicetimer_global_shift:
    type:
      - 'null'
      - double
  slicetimer_slice_order:
    type:
      - 'null'
      - Any
    default:
      interleaved: true
  slicetimer_direction:
    type:
      - 'null'
      - int
  slicetimer_verbose:
    type:
      - 'null'
      - boolean
  flirt_2_output:
    type: string
  flirt_2_output_matrix:
    type:
      - 'null'
      - string
  flirt_2_dof:
    type:
      - 'null'
      - int
  flirt_2_init_matrix:
    type:
      - 'null'
      - File
  flirt_2_apply_xfm:
    type:
      - 'null'
      - boolean
  flirt_2_apply_isoxfm:
    type:
      - 'null'
      - double
  flirt_2_uses_qform:
    type:
      - 'null'
      - boolean
  flirt_2_rigid2D:
    type:
      - 'null'
      - boolean
  flirt_2_cost:
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
  flirt_2_search_cost:
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
  flirt_2_searchr_x:
    type:
      - 'null'
      - string
  flirt_2_searchr_y:
    type:
      - 'null'
      - string
  flirt_2_searchr_z:
    type:
      - 'null'
      - string
  flirt_2_no_search:
    type:
      - 'null'
      - boolean
  flirt_2_coarse_search:
    type:
      - 'null'
      - int
  flirt_2_fine_search:
    type:
      - 'null'
      - int
  flirt_2_interp:
    type:
      - 'null'
      - type: enum
        symbols:
          - trilinear
          - nearestneighbour
          - sinc
          - spline
  flirt_2_sinc_width:
    type:
      - 'null'
      - int
  flirt_2_sinc_window:
    type:
      - 'null'
      - type: enum
        symbols:
          - rectangular
          - hanning
          - blackman
  flirt_2_in_weight:
    type:
      - 'null'
      - File
  flirt_2_ref_weight:
    type:
      - 'null'
      - File
  flirt_2_bins:
    type:
      - 'null'
      - int
  flirt_2_min_sampling:
    type:
      - 'null'
      - double
  flirt_2_no_clamp:
    type:
      - 'null'
      - boolean
  flirt_2_no_resample:
    type:
      - 'null'
      - boolean
  flirt_2_padding_size:
    type:
      - 'null'
      - int
  flirt_2_datatype:
    type:
      - 'null'
      - type: enum
        symbols:
          - char
          - short
          - int
          - float
          - double
  flirt_2_verbose:
    type:
      - 'null'
      - int
  flirt_2_wm_seg:
    type:
      - 'null'
      - File
  flirt_2_bbrslope:
    type:
      - 'null'
      - double
  flirt_2_bbrtype:
    type:
      - 'null'
      - type: enum
        symbols:
          - signed
          - global_abs
          - local_abs
  flirt_2_fieldmap:
    type:
      - 'null'
      - File
  flirt_2_fieldmapmask:
    type:
      - 'null'
      - File
  flirt_2_echospacing:
    type:
      - 'null'
      - double
  flirt_2_pedir:
    type:
      - 'null'
      - int
  flirt_2_schedule:
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
  susan_brightness_threshold:
    type: double
  susan_fwhm:
    type: double
  susan_output:
    type: string
  susan_dimension:
    type:
      - 'null'
      - int
  susan_use_median:
    type:
      - 'null'
      - int
  susan_n_usans:
    type:
      - 'null'
      - int
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
  fslmaths_1_mul_file:
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
  fslmaths_3_output:
    type: string
  fslmaths_3_abs:
    type:
      - 'null'
      - boolean
  fslmaths_3_bin:
    type:
      - 'null'
      - boolean
  fslmaths_3_binv:
    type:
      - 'null'
      - boolean
  fslmaths_3_recip:
    type:
      - 'null'
      - boolean
  fslmaths_3_sqrt:
    type:
      - 'null'
      - boolean
  fslmaths_3_sqr:
    type:
      - 'null'
      - boolean
  fslmaths_3_exp:
    type:
      - 'null'
      - boolean
  fslmaths_3_log:
    type:
      - 'null'
      - boolean
  fslmaths_3_nan:
    type:
      - 'null'
      - boolean
  fslmaths_3_nanm:
    type:
      - 'null'
      - boolean
  fslmaths_3_fillh:
    type:
      - 'null'
      - boolean
  fslmaths_3_fillh26:
    type:
      - 'null'
      - boolean
  fslmaths_3_edge:
    type:
      - 'null'
      - boolean
  fslmaths_3_add_value:
    type:
      - 'null'
      - double
  fslmaths_3_sub_value:
    type:
      - 'null'
      - double
  fslmaths_3_mul_value:
    type:
      - 'null'
      - double
  fslmaths_3_div_value:
    type:
      - 'null'
      - double
  fslmaths_3_rem_value:
    type:
      - 'null'
      - double
  fslmaths_3_thr:
    type:
      - 'null'
      - double
  fslmaths_3_thrp:
    type:
      - 'null'
      - double
  fslmaths_3_thrP:
    type:
      - 'null'
      - double
  fslmaths_3_uthr:
    type:
      - 'null'
      - double
  fslmaths_3_uthrp:
    type:
      - 'null'
      - double
  fslmaths_3_uthrP:
    type:
      - 'null'
      - double
  fslmaths_3_sub_file:
    type:
      - 'null'
      - File
  fslmaths_3_mul_file:
    type:
      - 'null'
      - File
  fslmaths_3_div_file:
    type:
      - 'null'
      - File
  fslmaths_3_mas:
    type:
      - 'null'
      - File
  fslmaths_3_max_file:
    type:
      - 'null'
      - File
  fslmaths_3_min_file:
    type:
      - 'null'
      - File
  fslmaths_3_s:
    type:
      - 'null'
      - double
  fslmaths_3_kernel_type:
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
  fslmaths_3_kernel_size:
    type:
      - 'null'
      - double
  fslmaths_3_dilM:
    type:
      - 'null'
      - boolean
  fslmaths_3_dilD:
    type:
      - 'null'
      - boolean
  fslmaths_3_dilF:
    type:
      - 'null'
      - boolean
  fslmaths_3_dilall:
    type:
      - 'null'
      - boolean
  fslmaths_3_ero:
    type:
      - 'null'
      - boolean
  fslmaths_3_eroF:
    type:
      - 'null'
      - boolean
  fslmaths_3_fmedian:
    type:
      - 'null'
      - boolean
  fslmaths_3_fmean:
    type:
      - 'null'
      - boolean
  fslmaths_3_fmeanu:
    type:
      - 'null'
      - boolean
  fslmaths_3_Tmean:
    type:
      - 'null'
      - boolean
  fslmaths_3_Tstd:
    type:
      - 'null'
      - boolean
  fslmaths_3_Tmax:
    type:
      - 'null'
      - boolean
  fslmaths_3_Tmaxn:
    type:
      - 'null'
      - boolean
  fslmaths_3_Tmin:
    type:
      - 'null'
      - boolean
  fslmaths_3_Tmedian:
    type:
      - 'null'
      - boolean
  fslmaths_3_Tar1:
    type:
      - 'null'
      - boolean
  fslmaths_3_bptf:
    type:
      - 'null'
      - string
  fslmaths_3_odt:
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
  applywarp_reference:
    type: File
  applywarp_output:
    type: string
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
outputs:
  warped_image:
    type:
      type: array
      items: File
    outputSource: applywarp/warped_image
  log:
    type:
      type: array
      items: File
    outputSource: applywarp/log
steps:
  bet:
    run: ../cwl/fsl/bet.cwl
    scatter: input
    in:
      input: t1w
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
  mcflirt:
    run: ../cwl/fsl/mcflirt.cwl
    scatter: input
    in:
      input: bold
      output: mcflirt_output
      ref_vol: mcflirt_ref_vol
      ref_file: mcflirt_ref_file
      mean_vol: mcflirt_mean_vol
      cost: mcflirt_cost
      dof: mcflirt_dof
      init: mcflirt_init
      interpolation: mcflirt_interpolation
      save_mats: mcflirt_save_mats
      save_plots: mcflirt_save_plots
      save_rms: mcflirt_save_rms
      stats: mcflirt_stats
      stages: mcflirt_stages
      bins: mcflirt_bins
      smooth: mcflirt_smooth
      scaling: mcflirt_scaling
      rotation: mcflirt_rotation
      edge: mcflirt_edge
      gdt: mcflirt_gdt
    out:
      - motion_corrected
      - motion_parameters
      - mean_image
      - variance_image
      - std_image
      - transformation_matrices
      - rms_files
      - log
    hints:
      DockerRequirement:
        dockerPull: brainlife/fsl:6.0.4-patched2
  flirt_1:
    run: ../cwl/fsl/flirt.cwl
    scatter: input
    in:
      input: bet/brain_extraction
      reference: flirt_1_reference
      output: flirt_1_output
      output_matrix: flirt_1_output_matrix
      dof: flirt_1_dof
      init_matrix: flirt_1_init_matrix
      apply_xfm: flirt_1_apply_xfm
      apply_isoxfm: flirt_1_apply_isoxfm
      uses_qform: flirt_1_uses_qform
      rigid2D: flirt_1_rigid2D
      cost: flirt_1_cost
      search_cost: flirt_1_search_cost
      searchr_x: flirt_1_searchr_x
      searchr_y: flirt_1_searchr_y
      searchr_z: flirt_1_searchr_z
      no_search: flirt_1_no_search
      coarse_search: flirt_1_coarse_search
      fine_search: flirt_1_fine_search
      interp: flirt_1_interp
      sinc_width: flirt_1_sinc_width
      sinc_window: flirt_1_sinc_window
      in_weight: flirt_1_in_weight
      ref_weight: flirt_1_ref_weight
      bins: flirt_1_bins
      min_sampling: flirt_1_min_sampling
      no_clamp: flirt_1_no_clamp
      no_resample: flirt_1_no_resample
      padding_size: flirt_1_padding_size
      datatype: flirt_1_datatype
      verbose: flirt_1_verbose
      wm_seg: flirt_1_wm_seg
      bbrslope: flirt_1_bbrslope
      bbrtype: flirt_1_bbrtype
      fieldmap: flirt_1_fieldmap
      fieldmapmask: flirt_1_fieldmapmask
      echospacing: flirt_1_echospacing
      pedir: flirt_1_pedir
      schedule: flirt_1_schedule
    out:
      - registered_image
      - transformation_matrix
      - log
    hints:
      DockerRequirement:
        dockerPull: brainlife/fsl:6.0.4-patched2
  slicetimer:
    run: ../cwl/fsl/slicetimer.cwl
    scatter: input
    in:
      input: mcflirt/motion_corrected
      output: slicetimer_output
      tr: slicetimer_tr
      global_shift: slicetimer_global_shift
      slice_order: slicetimer_slice_order
      direction: slicetimer_direction
      verbose: slicetimer_verbose
    out:
      - slice_time_corrected
      - log
    hints:
      DockerRequirement:
        dockerPull: brainlife/fsl:6.0.4-patched2
  flirt_2:
    run: ../cwl/fsl/flirt.cwl
    scatter:
      - input
      - reference
    scatterMethod: dotproduct
    in:
      input: mcflirt/mean_image
      reference: bet/brain_extraction
      output: flirt_2_output
      output_matrix: flirt_2_output_matrix
      dof: flirt_2_dof
      init_matrix: flirt_2_init_matrix
      apply_xfm: flirt_2_apply_xfm
      apply_isoxfm: flirt_2_apply_isoxfm
      uses_qform: flirt_2_uses_qform
      rigid2D: flirt_2_rigid2D
      cost: flirt_2_cost
      search_cost: flirt_2_search_cost
      searchr_x: flirt_2_searchr_x
      searchr_y: flirt_2_searchr_y
      searchr_z: flirt_2_searchr_z
      no_search: flirt_2_no_search
      coarse_search: flirt_2_coarse_search
      fine_search: flirt_2_fine_search
      interp: flirt_2_interp
      sinc_width: flirt_2_sinc_width
      sinc_window: flirt_2_sinc_window
      in_weight: flirt_2_in_weight
      ref_weight: flirt_2_ref_weight
      bins: flirt_2_bins
      min_sampling: flirt_2_min_sampling
      no_clamp: flirt_2_no_clamp
      no_resample: flirt_2_no_resample
      padding_size: flirt_2_padding_size
      datatype: flirt_2_datatype
      verbose: flirt_2_verbose
      wm_seg: flirt_2_wm_seg
      bbrslope: flirt_2_bbrslope
      bbrtype: flirt_2_bbrtype
      fieldmap: flirt_2_fieldmap
      fieldmapmask: flirt_2_fieldmapmask
      echospacing: flirt_2_echospacing
      pedir: flirt_2_pedir
      schedule: flirt_2_schedule
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
      - input
      - affine
    scatterMethod: dotproduct
    in:
      input: bet/brain_extraction
      reference: fnirt_reference
      affine: flirt_1/transformation_matrix
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
  susan:
    run: ../cwl/fsl/susan.cwl
    scatter: input
    in:
      input: slicetimer/slice_time_corrected
      brightness_threshold: susan_brightness_threshold
      fwhm: susan_fwhm
      output: susan_output
      dimension: susan_dimension
      use_median: susan_use_median
      n_usans: susan_n_usans
    out:
      - smoothed_image
      - log
    hints:
      DockerRequirement:
        dockerPull: brainlife/fsl:6.0.4-patched2
  fslmaths_1:
    run: ../cwl/fsl/fslmaths.cwl
    scatter: input
    in:
      input: susan/smoothed_image
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
      mul_file: fslmaths_1_mul_file
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
      input: susan/smoothed_image
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
        dockerPull: brainlife/fsl:latest
  fslmaths_3:
    run: ../cwl/fsl/fslmaths.cwl
    scatter:
      - input
      - add_file
    scatterMethod: dotproduct
    in:
      input: fslmaths_1/output_image
      output: fslmaths_3_output
      abs: fslmaths_3_abs
      bin: fslmaths_3_bin
      binv: fslmaths_3_binv
      recip: fslmaths_3_recip
      sqrt: fslmaths_3_sqrt
      sqr: fslmaths_3_sqr
      exp: fslmaths_3_exp
      log: fslmaths_3_log
      nan: fslmaths_3_nan
      nanm: fslmaths_3_nanm
      fillh: fslmaths_3_fillh
      fillh26: fslmaths_3_fillh26
      edge: fslmaths_3_edge
      add_value: fslmaths_3_add_value
      sub_value: fslmaths_3_sub_value
      mul_value: fslmaths_3_mul_value
      div_value: fslmaths_3_div_value
      rem_value: fslmaths_3_rem_value
      thr: fslmaths_3_thr
      thrp: fslmaths_3_thrp
      thrP: fslmaths_3_thrP
      uthr: fslmaths_3_uthr
      uthrp: fslmaths_3_uthrp
      uthrP: fslmaths_3_uthrP
      add_file: fslmaths_2/output_image
      sub_file: fslmaths_3_sub_file
      mul_file: fslmaths_3_mul_file
      div_file: fslmaths_3_div_file
      mas: fslmaths_3_mas
      max_file: fslmaths_3_max_file
      min_file: fslmaths_3_min_file
      s: fslmaths_3_s
      kernel_type: fslmaths_3_kernel_type
      kernel_size: fslmaths_3_kernel_size
      dilM: fslmaths_3_dilM
      dilD: fslmaths_3_dilD
      dilF: fslmaths_3_dilF
      dilall: fslmaths_3_dilall
      ero: fslmaths_3_ero
      eroF: fslmaths_3_eroF
      fmedian: fslmaths_3_fmedian
      fmean: fslmaths_3_fmean
      fmeanu: fslmaths_3_fmeanu
      Tmean: fslmaths_3_Tmean
      Tstd: fslmaths_3_Tstd
      Tmax: fslmaths_3_Tmax
      Tmaxn: fslmaths_3_Tmaxn
      Tmin: fslmaths_3_Tmin
      Tmedian: fslmaths_3_Tmedian
      Tar1: fslmaths_3_Tar1
      bptf: fslmaths_3_bptf
      odt: fslmaths_3_odt
    out:
      - output_image
      - log
    hints:
      DockerRequirement:
        dockerPull: brainlife/fsl:latest
  applywarp:
    run: ../cwl/fsl/applywarp.cwl
    scatter:
      - input
      - warp
      - premat
    scatterMethod: dotproduct
    in:
      input: fslmaths_3/output_image
      reference: applywarp_reference
      output: applywarp_output
      warp: fnirt/warp_coefficients
      premat: flirt_2/transformation_matrix
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
        dockerPull: brainlife/fsl:6.0.4-patched2
requirements:
  ScatterFeatureRequirement: {}
