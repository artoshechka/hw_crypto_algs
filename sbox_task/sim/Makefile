SRC_PATH=../rtl

simulate: clean synth sim
all: clean synth sim wave

# Design and testbench synthesis
synth:
	mkdir -p work
	iverilog -g2012 -o work/test_bench $(SRC_PATH)/XPSComposition.sv test_bench.sv

sim:
	./work/test_bench

# Open waveform
wave:
	gtkwave work/wave.ocd \
		--rcvar 'fontname_signals Monospace 20' \
        --rcvar 'fontname_waves Monospace 20' \
        --rcvar 'scale_to_time_dimension n'

# Delete all artifacts
clean:
	rm -rf work