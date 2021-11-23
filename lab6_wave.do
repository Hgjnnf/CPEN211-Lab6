onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /cpu_tb/SIM_clk
add wave -noupdate /cpu_tb/SIM_reset
add wave -noupdate /cpu_tb/SIM_s
add wave -noupdate /cpu_tb/SIM_load
add wave -noupdate /cpu_tb/SIM_in
add wave -noupdate /cpu_tb/SIM_out
add wave -noupdate /cpu_tb/SIM_N
add wave -noupdate /cpu_tb/SIM_V
add wave -noupdate /cpu_tb/SIM_Z
add wave -noupdate /cpu_tb/SIM_w
add wave -noupdate /cpu_tb/err
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {951 ps} {2071 ps}
