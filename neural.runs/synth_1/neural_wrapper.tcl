# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7z020clg484-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir /nfs/home/sasl/eleves/ei-se/3701019/Bureau/TP_CODESIGN/Neuron/neural/neural.cache/wt [current_project]
set_property parent.project_path /nfs/home/sasl/eleves/ei-se/3701019/Bureau/TP_CODESIGN/Neuron/neural/neural.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property board_part em.avnet.com:zed:part0:1.3 [current_project]
set_property vhdl_version vhdl_2k [current_fileset]
add_files /nfs/home/sasl/eleves/ei-se/3701019/Bureau/TP_CODESIGN/Neuron/neural/neural.srcs/sources_1/bd/neural/neural.bd
set_property used_in_implementation false [get_files -all /nfs/home/sasl/eleves/ei-se/3701019/Bureau/TP_CODESIGN/Neuron/neural/neural.srcs/sources_1/bd/neural/ip/neural_processing_system7_0_0_1/neural_processing_system7_0_0.xdc]
set_property used_in_implementation false [get_files -all /nfs/home/sasl/eleves/ei-se/3701019/Bureau/TP_CODESIGN/Neuron/neural/neural.srcs/sources_1/bd/neural/ip/neural_axi_gpio_0_0/neural_axi_gpio_0_0_board.xdc]
set_property used_in_implementation false [get_files -all /nfs/home/sasl/eleves/ei-se/3701019/Bureau/TP_CODESIGN/Neuron/neural/neural.srcs/sources_1/bd/neural/ip/neural_axi_gpio_0_0/neural_axi_gpio_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /nfs/home/sasl/eleves/ei-se/3701019/Bureau/TP_CODESIGN/Neuron/neural/neural.srcs/sources_1/bd/neural/ip/neural_axi_gpio_0_0/neural_axi_gpio_0_0.xdc]
set_property used_in_implementation false [get_files -all /nfs/home/sasl/eleves/ei-se/3701019/Bureau/TP_CODESIGN/Neuron/neural/neural.srcs/sources_1/bd/neural/ip/neural_rst_processing_system7_0_100M_0/neural_rst_processing_system7_0_100M_0_board.xdc]
set_property used_in_implementation false [get_files -all /nfs/home/sasl/eleves/ei-se/3701019/Bureau/TP_CODESIGN/Neuron/neural/neural.srcs/sources_1/bd/neural/ip/neural_rst_processing_system7_0_100M_0/neural_rst_processing_system7_0_100M_0.xdc]
set_property used_in_implementation false [get_files -all /nfs/home/sasl/eleves/ei-se/3701019/Bureau/TP_CODESIGN/Neuron/neural/neural.srcs/sources_1/bd/neural/ip/neural_rst_processing_system7_0_100M_0/neural_rst_processing_system7_0_100M_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /nfs/home/sasl/eleves/ei-se/3701019/Bureau/TP_CODESIGN/Neuron/neural/neural.srcs/sources_1/bd/neural/ip/neural_auto_pc_0/neural_auto_pc_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /nfs/home/sasl/eleves/ei-se/3701019/Bureau/TP_CODESIGN/Neuron/neural/neural.srcs/sources_1/bd/neural/neural_ooc.xdc]
set_property is_locked true [get_files /nfs/home/sasl/eleves/ei-se/3701019/Bureau/TP_CODESIGN/Neuron/neural/neural.srcs/sources_1/bd/neural/neural.bd]

read_vhdl -library xil_defaultlib /nfs/home/sasl/eleves/ei-se/3701019/Bureau/TP_CODESIGN/Neuron/neural/neural.srcs/sources_1/bd/neural/hdl/neural_wrapper.vhd
read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
synth_design -top neural_wrapper -part xc7z020clg484-1
write_checkpoint -noxdef neural_wrapper.dcp
catch { report_utilization -file neural_wrapper_utilization_synth.rpt -pb neural_wrapper_utilization_synth.pb }