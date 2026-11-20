DESIGN_NAME=name_mealy_fsm
SRC_PATH=../rtl
WAVE_CONFIG=../wave.gtkw
TEST ?= sequence_full_path.tv

.PHONY: all synth sim wave clean

all: clean synth sim wave

synth:
	mkdir -p work
	iverilog -g2012 -o work/tb_$(DESIGN_NAME) $(SRC_PATH)/$(DESIGN_NAME).sv tb_$(DESIGN_NAME).sv

sim: synth
	./work/tb_$(DESIGN_NAME) +TEST=$(TEST)

wave: synth sim
	gtkwave work/wave.ocd $(if $(wildcard $(WAVE_CONFIG)),$(WAVE_CONFIG)) \
		--rcvar 'fontname_signals Monospace 20' \
		--rcvar 'fontname_waves Monospace 20' \
		--rcvar 'scale_to_time_dimension n'

clean:
	rm -rf work
