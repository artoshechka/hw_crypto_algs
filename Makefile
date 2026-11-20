VERILATOR ?= verilator
VERIBLE_FORMAT ?= verible-verilog-format
MODULE ?=
MODULE_DIR ?=

.PHONY: lint lint-all format

lint:
	@if [ -n "$(MODULE)" ]; then \
		search_dir="$(MODULE)"; \
	elif [ -n "$(MODULE_DIR)" ]; then \
		search_dir="$(MODULE_DIR)"; \
	else \
		search_dir=. ; \
	fi; \
	files=$$(find "$$search_dir" -type d \( -name .git -o -name work -o -name obj_dir -o -name impl \) -prune -o -type f -path "*/rtl/*" \( -name "*.v" -o -name "*.sv" \) -print); \
	"$(VERILATOR)" --lint-only --Wall --language 1800-2012 $$files

lint-all:
	@if [ -n "$(MODULE)" ]; then \
		search_dir="$(MODULE)"; \
	elif [ -n "$(MODULE_DIR)" ]; then \
		search_dir="$(MODULE_DIR)"; \
	else \
		search_dir=. ; \
	fi; \
	files=$$(find "$$search_dir" -type d \( -name .git -o -name work -o -name obj_dir -o -name impl \) -prune -o -type f \( -path "*/rtl/*" -o -path "*/sim/*" \) \( -name "*.v" -o -name "*.sv" \) -print); \
	"$(VERILATOR)" --lint-only --Wall --language 1800-2012 $$files

format:
	@if [ -n "$(MODULE)" ]; then \
		search_dir="$(MODULE)"; \
	elif [ -n "$(MODULE_DIR)" ]; then \
		search_dir="$(MODULE_DIR)"; \
	else \
		search_dir=. ; \
	fi; \
	find "$$search_dir" -type d \( -name .git -o -name work -o -name obj_dir -o -name impl \) -prune -o -type f \( -path "*/rtl/*" -o -path "*/sim/*" \) \( -name '*.v' -o -name '*.sv' \) -exec "$(VERIBLE_FORMAT)" --inplace {} +
