set REFLIBS /var/workspace/singularity/REFLIBS
set DESIGN_REF_PATH ${REFLIBS}/SAED14nm_EDK
set MEM_COMPILER_GEN_PATH ${REFLIBS}/saed_mc
set ADDITIONAL_SEARCH_PATH      " \
      ${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm \
      ${DESIGN_REF_PATH}/lib/stdcell_hvt/db_nldm \
      ${DESIGN_REF_PATH}/lib/stdcell_lvt/db_nldm \
      ${DESIGN_REF_PATH}/lib/sram_lp/logic_synth/singlelp \
      ${DESIGN_REF_PATH}/lib/sram_lp/logic_synth/duallp \
      ${DESIGN_REF_PATH}/lib/sram/logic_synth/single \
      ${DESIGN_REF_PATH}/lib/sram/logic_synth/dual \
      ${MEM_COMPILER_GEN_PATH}/mc_sram_ip_64_64/db_nldm \
      ${DESIGN_REF_PATH}/lib/io_std/db_nldm "
set NDM_REFERENCE_LIB_DIRS  " \
      ${DESIGN_REF_PATH}/lib/stdcell_rvt/ndm/saed14rvt_frame_only.ndm \
      ${DESIGN_REF_PATH}/lib/stdcell_hvt/ndm/saed14hvt_frame_only.ndm \
      ${DESIGN_REF_PATH}/lib/stdcell_lvt/ndm/saed14lvt_frame_only.ndm \
      ${DESIGN_REF_PATH}/lib/sram/ndm/saed14_sram_1rw_frame_only.ndm \
      ${DESIGN_REF_PATH}/lib/sram/ndm/saed14_sram_2rw_frame_only.ndm \
      ${DESIGN_REF_PATH}/lib/sram_lp/ndm/saed14_sram_lp_1rw_frame_only.ndm \
      ${DESIGN_REF_PATH}/lib/sram_lp/ndm/saed14_sram_lp_2rw_frame_only.ndm \
      ${DESIGN_REF_PATH}/lib/io_std/ndm/saed14io_wb_frame_only.ndm \
      "
set DESIGN_REF_TECH_PATH  "${DESIGN_REF_PATH}/tech"
set_app_var search_path   "$search_path $ADDITIONAL_SEARCH_PATH"
set TECH_FILE         "${DESIGN_REF_TECH_PATH}/milkyway/saed14nm_1p9m_mw.tf"  ;#  Milkyway technology file
set TLUPLUS_MAX_FILE  "${DESIGN_REF_TECH_PATH}/star_rc/max/saed14nm_1p9m_Cmax.tluplus"  ;#  Max TLUplus file
set TLUPLUS_MIN_FILE  "${DESIGN_REF_TECH_PATH}/star_rc/min/saed14nm_1p9m_Cmin.tluplus"  ;#  Min TLUplus file
set MAP_FILE          "${DESIGN_REF_TECH_PATH}/star_rc/saed14nm_tf_itf_tluplus.map"     ;#  Mapping file for TLUplus
set std_cell_lib     "saed14rvt_tt0p8v25c.db \
    saed14rvt_ss0p72v125c.db \
    saed14rvt_ff0p88v25c.db "
set sram_cell_lib "saed14sram_tt0p8v25c.db \
    saed14sram_ss0p72v25c.db \
    saed14sram_ff0p88v25c.db "

set_app_var link_library  "$std_cell_lib $sram_cell_lib"
set_app_var target_library "$std_cell_lib $sram_cell_lib"