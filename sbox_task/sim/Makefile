SRC_PATH=../rtl

all: synth sim

# Design and testbench synthesis
synth:
	mkdir -p work
	iverilog -g2012 -o work/tb_implication $(SRC_PATH)/implication.sv tb_implication.sv

# Launch simulation
sim:
	./work/tb_implication

# Open waveform
wave:
	gtkwave work/wave.ocd \
		--rcvar 'fontname_signals Monospace 20' \
        --rcvar 'fontname_waves Monospace 20' \
        --rcvar 'scale_to_time_dimension n'

# Delete all artifacts
clean:
	rm -rf work