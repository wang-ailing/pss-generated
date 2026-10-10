# GNU Make 4.3+; run in Ubuntu Bash. Reuse the committed generated SV.
SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail -c
.ONESHELL:
.DELETE_ON_ERROR:
.DEFAULT_GOAL := all

CASE_DIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
RUN_DIR ?= runs/make
RUN_PATH := $(abspath $(if $(filter /%,$(RUN_DIR)),$(RUN_DIR),$(CASE_DIR)/$(RUN_DIR)))
PYTHON ?= python3
VERILATOR ?= /home/pssprobe/hello-pss-sv/tools/verilator-5.052/usr/local/bin/verilator
VERILATOR_COVERAGE ?= /home/pssprobe/hello-pss-sv/tools/verilator-5.052/usr/local/bin/verilator_coverage
VERILATOR_ROOT ?= /home/pssprobe/hello-pss-sv/tools/verilator-5.052/usr/local/share/verilator
SEED ?= 42
SIM_TIMEOUT ?= 180
JOBS ?= 1
export VERILATOR_ROOT

INPUT_DIRS := model generated tb rtl dependencies scripts
INPUT_FILES := $(foreach d,$(INPUT_DIRS),$(wildcard $(CASE_DIR)/$(d)/*)) $(CASE_DIR)/SOURCE.json $(CASE_DIR)/Makefile
PREPARED := $(RUN_PATH)/.prepared
BINARY := $(RUN_PATH)/obj_dir/Vtb_async_fifo
SIM_OUTPUTS := $(RUN_PATH)/results/.simulation.ok $(RUN_PATH)/results/coverage.dat $(RUN_PATH)/results/functional.json
COVERAGE_JSON := $(RUN_PATH)/results/coverage.json

.PHONY: all help check-tools check-run-dir compile sim coverage report clean FORCE
all: report
compile: $(BINARY)
sim: $(RUN_PATH)/results/.simulation.ok
coverage: $(COVERAGE_JSON)
FORCE:

help:
	@printf '%s\n' \
	  'make all          Compile, simulate, check 10 intents and report coverage.' \
	  'make compile      Compile the committed SV and DUT.' \
	  'make sim          Run simulation again and check the functional result.' \
	  'make coverage     Generate coverage; simulate only when needed.' \
	  'make report       Print coverage and result paths.' \
	  'make check-tools  Check Python, timeout and the Verilator installation.' \
	  'make clean        Delete only the selected directory below fifo_v2/runs/.' \
	  'Defaults: RUN_DIR=runs/make SEED=42 SIM_TIMEOUT=180 JOBS=1' \
	  'Override PYTHON, VERILATOR, VERILATOR_COVERAGE and VERILATOR_ROOT as needed.'

check-run-dir:
	@$(PYTHON) -c 'from pathlib import Path; import sys; case=Path(sys.argv[1]).resolve(); base=case/"runs"; path=Path(sys.argv[2]); actual=path.resolve(); assert not base.is_symlink(), "runs must not be a symlink"; actual.relative_to(base.resolve()); assert actual != base.resolve(), "RUN_DIR must be below runs"; assert not any(p.is_symlink() for p in [path, *path.parents] if p == base or base in p.parents), "RUN_DIR must not contain symlinks"' "$(CASE_DIR)" "$(RUN_PATH)"

check-tools:
	$(PYTHON) --version
	command -v timeout
	command -v "$(VERILATOR)"
	command -v "$(VERILATOR_COVERAGE)"
	test -d "$(VERILATOR_ROOT)/include"
	"$(VERILATOR)" --version
	"$(VERILATOR_COVERAGE)" --version

$(PREPARED): $(INPUT_FILES) | check-run-dir check-tools
	mkdir -p -- "$(RUN_PATH)/results"
	cp -R -- $(foreach d,$(INPUT_DIRS),"$(CASE_DIR)/$(d)") "$(CASE_DIR)/SOURCE.json" "$(RUN_PATH)/"
	test -s "$(RUN_PATH)/generated/zsp_rt_pkg.sv"
	test -s "$(RUN_PATH)/generated/zsp_gen_pkg.sv"
	test -s "$(RUN_PATH)/tb/tb_async_fifo.sv"
	touch "$@"

# Preserve the timestamp when settings are unchanged, so later steps reuse work.
$(RUN_PATH)/.build-settings: FORCE | check-run-dir
	@mkdir -p -- "$(RUN_PATH)"
	printf '%s\n' "VERILATOR=$(VERILATOR)" "VERILATOR_ROOT=$(VERILATOR_ROOT)" "JOBS=$(JOBS)" > "$@.tmp"
	if cmp -s "$@.tmp" "$@"; then rm -f -- "$@.tmp"; else mv -- "$@.tmp" "$@"; fi

$(RUN_PATH)/.sim-settings: FORCE | check-run-dir
	@mkdir -p -- "$(RUN_PATH)"
	printf '%s\n' "SEED=$(SEED)" "SIM_TIMEOUT=$(SIM_TIMEOUT)" > "$@.tmp"
	if cmp -s "$@.tmp" "$@"; then rm -f -- "$@.tmp"; else mv -- "$@.tmp" "$@"; fi

$(RUN_PATH)/.coverage-settings: FORCE | check-run-dir
	@mkdir -p -- "$(RUN_PATH)"
	printf '%s\n' "PYTHON=$(PYTHON)" "VERILATOR_COVERAGE=$(VERILATOR_COVERAGE)" > "$@.tmp"
	if cmp -s "$@.tmp" "$@"; then rm -f -- "$@.tmp"; else mv -- "$@.tmp" "$@"; fi

$(BINARY): $(PREPARED) $(RUN_PATH)/.build-settings | check-tools
	cd "$(RUN_PATH)"
	rm -f -- obj_dir/Vtb_async_fifo results/.simulation.ok results/coverage.json
	"$(VERILATOR)" \
	  --binary --timing --top-module tb_async_fifo -Wno-fatal \
	  --coverage-line --coverage-toggle --coverage-expr --coverage-per-instance \
	  -Igenerated \
	  generated/zsp_rt_pkg.sv generated/zsp_gen_pkg.sv \
	  rtl/async_fifo.sv rtl/fifo_memory.sv rtl/rptr_empty.sv rtl/wptr_full.sv \
	  rtl/read_to_write_pointer_sync.sv dependencies/write_to_read_pointer_sync.sv \
	  tb/tb_async_fifo.sv tb/coverage_zero.cpp \
	  --Mdir obj_dir -j "$(JOBS)" -MAKEFLAGS OBJCACHE= \
	  2>&1 | tee results/build.log
	test -x obj_dir/Vtb_async_fifo

# Explicit make sim reruns once. Other targets reuse valid simulation outputs.
ifneq ($(filter sim,$(MAKECMDGOALS)),)
$(SIM_OUTPUTS): FORCE
endif
$(SIM_OUTPUTS) &: $(BINARY) $(RUN_PATH)/.sim-settings | check-tools
	cd "$(RUN_PATH)"
	rm -f -- results/.simulation.ok results/functional.json results/coverage.dat results/coverage.json
	timeout "$(SIM_TIMEOUT)" ./obj_dir/Vtb_async_fifo \
	  +verilator+seed+$(SEED) \
	  +verilator+coverage+file+results/coverage.dat \
	  2>&1 | tee results/simulate.log
	test -s results/coverage.dat
	$(PYTHON) -c 'import json; from pathlib import Path; r=json.loads(Path("results/functional.json").read_text()); assert r["pass"] is True, r; assert r["errors"] == 0, r; assert len(r["intents"]) == 10, r; assert all(x["pass"] is True for x in r["intents"]), r; print("10/10 intents PASS, errors=0")'
	touch results/.simulation.ok

$(COVERAGE_JSON): $(SIM_OUTPUTS) $(CASE_DIR)/scripts/report_coverage.py $(RUN_PATH)/.coverage-settings | check-tools
	cd "$(RUN_PATH)"
	rm -f -- results/coverage.json
	$(PYTHON) scripts/report_coverage.py \
	  --project-root "$$PWD" \
	  --coverage-tool "$(VERILATOR_COVERAGE)" \
	  2>&1 | tee results/coverage.log
	test -s results/coverage.json
	test -s results/dut.info

report: coverage
	cd "$(RUN_PATH)"
	$(PYTHON) -c 'import json; from pathlib import Path; r=json.loads(Path("results/coverage.json").read_text()); [print("{}: {} ({}/{})".format(k, "N/A" if m["percent"] is None else "{:.2f}%".format(m["percent"]), m["covered"], m["total"])) for k,m in r["metrics"].items()]; print("Results: "+str(Path("results").resolve()))'
	ls -lh results/functional.json results/coverage.json results/coverage.dat results/dut.info

clean: check-run-dir
	$(PYTHON) -c 'from pathlib import Path; import shutil, sys; p=Path(sys.argv[1]); shutil.rmtree(p) if p.exists() else None; print("Removed: "+str(p))' "$(RUN_PATH)"
