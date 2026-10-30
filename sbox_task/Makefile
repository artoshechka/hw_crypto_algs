VERILOG_RUNNER ?= $(HOME)/coding/docker_images_src/Verilog/run_gtk.sh
WORKSPACE ?= $(CURDIR)
VERIBLE_FORMAT ?= verible-verilog-format

.PHONY: lint lint-all format

lint:
	printf '%s\n' 'cd /home/verilog/workspace && verilator --lint-only --Wall --language 1800-2012 $$(find rtl -type d \( -name work -o -name obj_dir \) -prune -o -type f \( -name "*.v" -o -name "*.sv" \) -print)' 'exit' | \
		script -q /dev/null "$(VERILOG_RUNNER)" "$(WORKSPACE)"

lint-all:
	printf '%s\n' 'cd /home/verilog/workspace && verilator --lint-only --Wall --language 1800-2012 --top-module tb_implication $$(find rtl sim -maxdepth 1 -type f \( -name "*.v" -o -name "*.sv" \) -print)' 'exit' | \
		script -q /dev/null "$(VERILOG_RUNNER)" "$(WORKSPACE)"

format:
	find rtl sim -type f \( -name '*.v' -o -name '*.sv' \) -exec "$(VERIBLE_FORMAT)" --inplace {} +
