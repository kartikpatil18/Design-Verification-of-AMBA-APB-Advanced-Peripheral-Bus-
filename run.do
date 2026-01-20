vlog list.svh
vsim -novopt -suppress 12110 top
add wave -r sim:top/*
run -all
