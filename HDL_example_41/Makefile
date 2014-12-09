all:
	iverilog -o sillyfunction sillyfunction.v sillyfunction-test.v
	vvp sillyfunction
	gtkwave sillyfunction-dump.vcd &

compile:
	iverilog -o sillyfunction sillyfunction.v sillyfunction-test.v

vcd:
	vvp sillyfunction

view:
	gtkwave sillyfunction-dump.vcd &
