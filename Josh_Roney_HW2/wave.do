onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Literal :Test_adder:a:A
add wave -noupdate -format Literal :Test_adder:a:B
add wave -noupdate -format Literal :Test_adder:a:CODE
add wave -noupdate -format Logic :Test_adder:a:cin
add wave -noupdate -format Logic :Test_adder:a:coe
add wave -noupdate -format Literal :Test_adder:a:C
add wave -noupdate -format Logic :Test_adder:a:vout
add wave -noupdate -format Logic :Test_adder:a:cout
add wave -noupdate -format Literal :Test_adder:a:a
add wave -noupdate -format Literal :Test_adder:a:b
add wave -noupdate -format Literal :Test_adder:a:c
add wave -noupdate -format Literal :Test_adder:a:code
add wave -noupdate -format Logic :Test_adder:a:sig
add wave -noupdate -format Logic :Test_adder:a:vo
add wave -noupdate -format Logic :Test_adder:a:co
add wave -noupdate -format Literal :Test_adder:a:carry
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 fs} 0}
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
configure wave -timelineunits fs
update
WaveRestoreZoom {0 fs} {1 ps}
