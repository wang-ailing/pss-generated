# 异步 FIFO Linux 仿真与覆盖率指南

本指南使用仓库中已有的 PSS 与 SV 文件，在 Ubuntu Bash 中复现编译、仿真、功能检查和覆盖率统计。PSS 指 Accellera Portable Test and Stimulus Standard；案例使用 PSS 3.0 的 PSSC 支持子集和 Verilator 5.052。

`model/fifo.pss` 与 `tb/tb_async_fifo.sv` 是 Agent 生成的源码，`generated/zsp_gen_pkg.sv` 与 `generated/zsp_rt_pkg.sv` 是 PSSC 的生成产物。所有操作均无需模型 API 或密钥。

## Makefile 入口

运行位置：Ubuntu；终端：Bash；工作目录：`/home/pssprobe`。以下路径对应已验证的工具安装环境：

```bash
set -euo pipefail
cd /home/pssprobe
REPO=/home/pssprobe/pss-generated-fifo-v2-demo
if test ! -d "$REPO/.git"; then
  git clone https://github.com/wang-ailing/pss-generated.git "$REPO"
else
  git -C "$REPO" pull --ff-only origin main
fi
make -C "$REPO/fifo_v2" all
```

该入口直接使用已提交的生成 SV，不运行 PSSC。输出位于 `$REPO/fifo_v2/runs/make/results/`。Make 目标与可覆盖变量见 [README](README.md)。

以下手动步骤展示从 PSS 解析、重新生成 SV 到覆盖率导出的完整命令。请在同一个 Bash 终端按顺序执行。

## 1. 准备源码与运行目录

运行位置：Ubuntu；终端：Bash；起始工作目录：`/home/pssprobe`。

工具变量默认指向已验证的安装位置；其他环境可替换为实际路径。`VERILATOR_ROOT` 应与所用 Verilator 版本一致。

```bash
set -euo pipefail
cd /home/pssprobe
REPO=/home/pssprobe/pss-generated-fifo-v2-demo
if test ! -d "$REPO/.git"; then
  git clone https://github.com/wang-ailing/pss-generated.git "$REPO"
else
  git -C "$REPO" pull --ff-only origin main
fi

PSSC_PYTHON=/home/pssprobe/fw_wb_dma_repro/.venv/bin/python
VERILATOR=/home/pssprobe/hello-pss-sv/tools/verilator-5.052/usr/local/bin/verilator
VERILATOR_COVERAGE=/home/pssprobe/hello-pss-sv/tools/verilator-5.052/usr/local/bin/verilator_coverage
export VERILATOR_ROOT=/home/pssprobe/hello-pss-sv/tools/verilator-5.052/usr/local/share/verilator

SOURCE_DIR="$REPO/fifo_v2"
RUN="$SOURCE_DIR/runs/manual-$(date -u +%Y%m%dT%H%M%SZ)"
mkdir -p -- "$SOURCE_DIR/runs"
test ! -e "$RUN"
mkdir -- "$RUN"
cp -R -- \
  "$SOURCE_DIR/model" \
  "$SOURCE_DIR/tb" \
  "$SOURCE_DIR/rtl" \
  "$SOURCE_DIR/dependencies" \
  "$SOURCE_DIR/scripts" \
  "$SOURCE_DIR/SOURCE.json" \
  "$RUN/"
cd "$RUN"
mkdir generated results
printf '运行目录：%s\n' "$PWD"
```

后续工作目录均为 `$RUN`。源码与报告脚本复制到独立目录，`generated/` 和 `results/` 接收重新生成的文件及执行结果。

## 2. 检查 PSS 与 testbench

运行位置：Ubuntu；终端：Bash；工作目录：`$RUN`。

```bash
printf 'PSS：%s/model/fifo.pss\nSV testbench：%s/tb/tb_async_fifo.sv\n' "$PWD" "$PWD"
ls -l -- model/fifo.pss tb/tb_async_fifo.sv tb/coverage_zero.cpp
cat model/fifo.pss
```

PSS 描述动作及场景组合。testbench 连接 PSSC 动作实现、FIFO DUT 的时钟与接口，并执行数据和状态检查。

## 3. 解析 PSS

运行位置：Ubuntu；终端：Bash；工作目录：`$RUN`。

```bash
"$PSSC_PYTHON" -m pssc parse model/fifo.pss \
  --dump-ir results/model.ir.yaml \
  2>&1 | tee results/manual_parse.log
test -s results/model.ir.yaml
```

验收条件：命令返回 0，且 `results/model.ir.yaml` 非空。解析错误见 `results/manual_parse.log`。

## 4. 生成 SystemVerilog

运行位置：Ubuntu；终端：Bash；工作目录：`$RUN`。

```bash
"$PSSC_PYTHON" -m pssc compile model/fifo.pss \
  -t sv-native \
  --projection oo_api \
  --export-action main_a \
  -o generated \
  2>&1 | tee results/manual_generate.log
test -s generated/zsp_gen_pkg.sv
test -s generated/zsp_rt_pkg.sv
ls -l -- generated/zsp_gen_pkg.sv generated/zsp_rt_pkg.sv
```

`main_a` 为导出的顶层动作。验收条件：命令返回 0，且两个生成包非空。

## 5. 编译仿真程序

运行位置：Ubuntu；终端：Bash；工作目录：`$RUN`。

```bash
"$VERILATOR" \
  --binary --timing --top-module tb_async_fifo -Wno-fatal \
  --coverage-line --coverage-toggle --coverage-expr --coverage-per-instance \
  -Igenerated \
  generated/zsp_rt_pkg.sv \
  generated/zsp_gen_pkg.sv \
  rtl/async_fifo.sv \
  rtl/fifo_memory.sv \
  rtl/rptr_empty.sv \
  rtl/wptr_full.sv \
  rtl/read_to_write_pointer_sync.sv \
  dependencies/write_to_read_pointer_sync.sv \
  tb/tb_async_fifo.sv \
  tb/coverage_zero.cpp \
  --Mdir obj_dir -j 1 -MAKEFLAGS OBJCACHE= \
  2>&1 | tee results/manual_compile.log
test -x obj_dir/Vtb_async_fifo
```

命令包含六份 DUT/依赖 SV、testbench、PSSC 生成包及覆盖率辅助 C++。验收条件：生成可执行文件 `obj_dir/Vtb_async_fifo`。

## 6. 仿真与功能检查

运行位置：Ubuntu；终端：Bash；工作目录：`$RUN`。

```bash
timeout 180 ./obj_dir/Vtb_async_fifo \
  +verilator+seed+42 \
  +verilator+coverage+file+results/coverage.dat \
  2>&1 | tee results/manual_simulate.log
test -s results/coverage.dat

python3 - <<'PY'
import json
from pathlib import Path

result = json.loads(Path("results/functional.json").read_text(encoding="utf-8"))
assert result["pass"] is True, result
assert result["errors"] == 0, result
assert len(result["intents"]) == 10, result
assert all(intent["pass"] is True for intent in result["intents"]), result
print("功能检查通过：pass=true，errors=0，10/10 intents 通过")
PY
```

只有所有断言通过才打印功能通过消息。超时返回码通常为 `124`，仿真错误与执行进度见 `results/manual_simulate.log`。

## 7. 导出 DUT 覆盖率

运行位置：Ubuntu；终端：Bash；工作目录：`$RUN`。

```bash
python3 scripts/report_coverage.py \
  --project-root "$PWD" \
  --coverage-tool "$VERILATOR_COVERAGE" \
  2>&1 | tee results/manual_coverage.log
```

脚本从 `coverage.dat` 筛选六份 DUT/依赖文件，写入 `dut.dat`；再提取 line/branch 点写入 `dut_line_branch.dat`。testbench 与 PSS 运行时不纳入 DUT 指标。

脚本按顺序执行以下子命令。完成上面的脚本调用后，无需重复执行：

```bash
"$VERILATOR_COVERAGE" --version
"$VERILATOR_COVERAGE" --report summary "$PWD/results/dut.dat"
"$VERILATOR_COVERAGE" --report hier "$PWD/results/dut.dat"
"$VERILATOR_COVERAGE" \
  --annotate "$PWD/results/annotated" \
  --annotate-all --annotate-points --annotate-min 1 \
  "$PWD/results/dut.dat"
"$VERILATOR_COVERAGE" \
  --annotate-min 1 \
  --write-info "$PWD/results/dut.info" \
  "$PWD/results/dut_line_branch.dat"
```

## 8. 查看结果

运行位置：Ubuntu；终端：Bash；工作目录：`$RUN`。

```bash
python3 - <<'PY'
import json
from pathlib import Path

report = json.loads(Path("results/coverage.json").read_text(encoding="utf-8"))
print("覆盖范围：", report["scope"])
for kind, metric in report["metrics"].items():
    percent = metric["percent"]
    label = "N/A" if percent is None else f"{percent:.2f}%"
    print(f'{kind}: {label} ({metric["covered"]}/{metric["total"]})')
print("结果目录：", Path("results").resolve())
PY
ls -lh -- \
  results/functional.json \
  results/coverage.json \
  results/coverage.dat \
  results/dut.dat \
  results/dut.info
ls -l -- results/annotated
cat results/coverage_summary.txt
```

已保存的验证结果为 10/10 意图通过、`errors=0`；line 为 8/8、branch 为 16/16、expr 为 15/15，均为 100%；toggle 为 1196/1246（95.99%）。复现结果以实际命令输出为准。

| 产物 | 用途 |
| --- | --- |
| `results/functional.json` | 功能通过状态、错误数和意图结果 |
| `results/coverage.json` | DUT 覆盖率指标、统计范围与文件信息 |
| `results/coverage.dat` | 原始覆盖数据 |
| `results/dut.dat` | 筛选后的 DUT 覆盖数据 |
| `results/dut.info` | line/branch 的 LCOV 数据 |
| `results/annotated/` | 带覆盖命中信息的源码 |
| `results/manual_*.log` | 解析、生成、编译、仿真与覆盖率日志 |

覆盖率分母为 Verilator 实际插桩点；无插桩点的类型显示 `N/A`。默认 `max-width=256` 时，RAM 数组翻转不计入 toggle 分母。验证场景、生成来源和证据索引见 [测试报告](TEST_REPORT.md)。
