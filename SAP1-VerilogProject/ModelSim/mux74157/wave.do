onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label SELECT /SimMux74157/SELECT
add wave -noupdate -label A /SimMux74157/A
add wave -noupdate -label D /SimMux74157/D
add wave -noupdate -label Out /SimMux74157/Out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {36410 ps} 0}
quietly wave cursor active 1
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
WaveRestoreZoom {0 ps} {189398 ps}
