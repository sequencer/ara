report_timing > ${rptPath}/${compile_design_name}_timing.rpt
report_timing -delay_type max -max_paths 5 > ${rptPath}/${compile_design_name}timing_critical_5.rpt
report_area > ${rptPath}/${compile_design_name}_area.rpt
report_area -hierarchy > ${rptPath}/${compile_design_name}_hierarchy_area.rpt
report_area -designware > ${rptPath}/${compile_design_name}_dw_area.rpt
