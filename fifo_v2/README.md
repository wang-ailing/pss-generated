# 异步 FIFO 验证示例（v2）

使用 PSS 元动作构建验证意图和复合场景，通过 SystemVerilog 测试平台执行 DUT 激励、参考模型检查及代码覆盖率采集。DUT 参数为 32 bit 数据、16 bit 地址和 65536 深度。

## 环境依赖

- Linux Bash、GNU Make 4.3 或更新版本。
- Python 3；覆盖率脚本使用标准库。
- Verilator 与 verilator_coverage；参考版本为 5.052。
- C++ 编译器及 Verilator 构建依赖。
- PSSC 0.1.0 仅用于重新解析 PSS 或生成 SV，参考提交为 `c44287ec3493b62ccbcbbe4505f9dbfb35604e4e`。

## 构建与运行

在本目录执行：

```bash
make all
```

分步执行：

```bash
make compile
make sim
make coverage
make report
```

| 目标 | 说明 |
| --- | --- |
| `all` | 编译、仿真、功能检查和覆盖率统计 |
| `check-tools` | 检查 Python、Verilator 和覆盖率工具 |
| `compile` | 编译已有 SV、DUT 和测试平台 |
| `sim` | 重新仿真，检查十个验证意图 |
| `coverage` | 生成覆盖率报告，按需执行前置步骤 |
| `report` | 打印覆盖率和结果目录 |
| `help` | 显示目标和配置项 |
| `clean` | 清理选定运行目录 |

`make all` 复用有效的编译与仿真产物。`make sim` 显式重跑仿真，后续 `make coverage` 使用该次数据。工具和运行参数变化时，依赖的阶段会更新。

## 配置

| 变量 | 默认值 |
| --- | --- |
| `RUN_DIR` | `runs/make` |
| `PYTHON` | `python3` |
| `SEED` | `42` |
| `SIM_TIMEOUT` | `180` 秒 |
| `JOBS` | `1` |
| `VERILATOR` | `/home/pssprobe/hello-pss-sv/tools/verilator-5.052/usr/local/bin/verilator` |
| `VERILATOR_COVERAGE` | `/home/pssprobe/hello-pss-sv/tools/verilator-5.052/usr/local/bin/verilator_coverage` |
| `VERILATOR_ROOT` | `/home/pssprobe/hello-pss-sv/tools/verilator-5.052/usr/local/share/verilator` |

覆盖运行参数：

```bash
make all RUN_DIR=runs/custom SEED=42 SIM_TIMEOUT=180 JOBS=1
```

`RUN_DIR` 必须位于本示例的 `runs/` 内。工具安装位置不同，可通过命令行变量覆盖默认值，例如：

```bash
make all \
  PYTHON=python3 \
  VERILATOR=/usr/local/bin/verilator \
  VERILATOR_COVERAGE=/usr/local/bin/verilator_coverage \
  VERILATOR_ROOT=/usr/local/share/verilator
```

上述工具路径是安装位置示例，应与实际环境一致。完整配方见 [Makefile](Makefile)。

## 输出与验证结果

新运行输出位于 `RUN_DIR/results/`：

| 文件 | 内容 |
| --- | --- |
| `functional.json` | 功能检查状态、错误数及各意图结果 |
| `coverage.json` | DUT 覆盖率指标与统计范围 |
| `coverage.dat` | 原始覆盖数据 |
| `dut.info` | LCOV 行与分支数据 |
| `annotated/` | 带覆盖命中信息的源码 |
| `build.log`、`simulate.log`、`coverage.log` | 工具日志 |

参考验证结果为 10/10 意图通过、错误数 0；line、branch、expr 覆盖率为 100%，toggle 为 95.99%。验证场景和覆盖率统计范围见 [TEST_REPORT.md](TEST_REPORT.md)。

## 手动执行工具链

以下命令在本示例目录 `fifo_v2/` 的同一个 Linux Bash 终端按顺序执行。输入为 `model/fifo.pss`、`tb/tb_async_fifo.sv` 和 `generated/` 下的 SV 包；工具路径对应参考环境。

### 1. 获取源码，创建新的运行目录

起始工作目录：仓库中的 `fifo_v2/`。创建独立运行目录存放编译与仿真产物。

```bash
set -euo pipefail
SOURCE_RUN="$PWD"
test -s "$SOURCE_RUN/Makefile"
mkdir -p -- "$SOURCE_RUN/runs"
RUN="$(mktemp -d "$SOURCE_RUN/runs/replay-XXXXXXXX")"

cp -R -- \
  "$SOURCE_RUN/model" \
  "$SOURCE_RUN/generated" \
  "$SOURCE_RUN/tb" \
  "$SOURCE_RUN/rtl" \
  "$SOURCE_RUN/dependencies" \
  "$SOURCE_RUN/scripts" \
  "$SOURCE_RUN/SOURCE.json" \
  "$RUN/"

cd "$RUN"
mkdir results
printf '运行目录：%s\n' "$PWD"
```

此处复制已有的生成代码。后续所有命令都在新 `$RUN` 目录执行；`results/` 初始为空。

### 2. 设置并检查工具路径

```bash
fifo_verilator=/home/pssprobe/hello-pss-sv/tools/verilator-5.052/usr/local/bin/verilator
fifo_cov=/home/pssprobe/hello-pss-sv/tools/verilator-5.052/usr/local/bin/verilator_coverage
export VERILATOR_ROOT=/home/pssprobe/hello-pss-sv/tools/verilator-5.052/usr/local/share/verilator

test -x "$fifo_verilator"
test -x "$fifo_cov"
"$fifo_verilator" --version
"$fifo_cov" --version
python3 --version

test -s model/fifo.pss
test -s generated/zsp_rt_pkg.sv
test -s generated/zsp_gen_pkg.sv
test -s tb/tb_async_fifo.sv
```

已验证工具为 Verilator 5.052；覆盖率脚本只使用 Python 标准库。其他机器请替换工具安装路径。

### 3. 编译 SV 和 DUT

```bash
"$fifo_verilator" \
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
  2>&1 | tee results/build.log

test -x obj_dir/Vtb_async_fifo
```

编译成功后得到 `obj_dir/Vtb_async_fifo`。编译输入包含仓库已有的 PSSC 生成包、6 份 DUT/依赖 SV、testbench 和覆盖计数初始化代码。

### 4. 仿真并检查功能结果

```bash
timeout 180 ./obj_dir/Vtb_async_fifo \
  +verilator+seed+42 \
  +verilator+coverage+file+results/coverage.dat \
  2>&1 | tee results/simulate.log

test -s results/coverage.dat
python3 - <<'PY'
import json
from pathlib import Path

result = json.loads(Path("results/functional.json").read_text())
assert result["pass"] is True, result
assert result["errors"] == 0, result
assert len(result["intents"]) == 10, result
assert all(item["pass"] is True for item in result["intents"]), result
print("10/10 intents PASS，errors=0")
PY
```

上述消息只在检查全部通过后打印。日志是 `results/simulate.log`；仿真产生新的 `coverage.dat` 和 `functional.json`。

### 5. 统计 DUT 覆盖率

```bash
python3 scripts/report_coverage.py \
  --project-root "$PWD" \
  --coverage-tool "$fifo_cov" \
  2>&1 | tee results/coverage.log
```

脚本筛选 DUT 覆盖点并生成 JSON、LCOV 和带命中信息的源码。它内部执行以下命令，便于核对；执行脚本后无需再手动重复：

```bash
"$fifo_cov" --version
"$fifo_cov" --report summary "$PWD/results/dut.dat"
"$fifo_cov" --report hier "$PWD/results/dut.dat"
"$fifo_cov" \
  --annotate "$PWD/results/annotated" \
  --annotate-all --annotate-points --annotate-min 1 \
  "$PWD/results/dut.dat"
"$fifo_cov" \
  --annotate-min 1 \
  --write-info "$PWD/results/dut.info" \
  "$PWD/results/dut_line_branch.dat"
```

### 6. 查看覆盖率和文件位置

```bash
python3 - <<'PY'
import json
from pathlib import Path

report = json.loads(Path("results/coverage.json").read_text())
for name, metric in report["metrics"].items():
    percent = metric["percent"]
    label = "N/A" if percent is None else f"{percent:.2f}%"
    print(f'{name}: {label} ({metric["covered"]}/{metric["total"]})')
print("结果目录：", Path("results").resolve())
PY

ls -lh results/functional.json results/coverage.json results/coverage.dat results/dut.info
cat results/coverage_summary.txt
```

参考指标为 line `8/8`、branch `16/16`、expr `15/15`（100%），toggle `1196/1246`（95.99%）。运行结果以生成的 `coverage.json` 为准，统计范围见 [验证报告](TEST_REPORT.md)。

- `$RUN/results/functional.json`：功能检查结果。
- `$RUN/results/coverage.json`：DUT 覆盖率。
- `$RUN/results/coverage.dat`：仿真的原始覆盖数据。
- `$RUN/results/dut.info`：LCOV 数据。
- `$RUN/results/annotated/`：带覆盖命中信息的源码。
- `$RUN/results/build.log`、`simulate.log`、`coverage.log`：各步骤日志。

从 `model/fifo.pss` 重新执行 PSSC 解析与 SV 生成的命令见 [LINUX_WALKTHROUGH.md](LINUX_WALKTHROUGH.md) 第 3～4 步。

## 产物位置

| 产物 | 位置 |
| --- | --- |
| Spec | [docs/fifo.md](docs/fifo.md) |
| Agent 生成的 PSS | [model/fifo.pss](model/fifo.pss) |
| Agent 生成的 SV | [tb/tb_async_fifo.sv](tb/tb_async_fifo.sv) |
| PSSC 生成的 SV | [generated/zsp_gen_pkg.sv](generated/zsp_gen_pkg.sv) |
| DUT 和补充依赖 | [rtl](rtl/)、[dependencies](dependencies/) |
| 元动作、计划、组合及模型返回工程 | [artifacts](artifacts/) |
| 生成与上下文复用配置 | [artifacts/smoke_scope.json](artifacts/smoke_scope.json) |
| 功能结果 | [results/functional.json](results/functional.json) |
| 覆盖率 | [results/coverage.json](results/coverage.json)、[原始数据](results/coverage.dat) |
| Linux 操作步骤 | [LINUX_WALKTHROUGH.md](LINUX_WALKTHROUGH.md) |
| 完整测试报告 | [TEST_REPORT.md](TEST_REPORT.md) |
| 生成任务定义与参考命令 | [prompt.md](prompt.md)、[SMOKE_COMMANDS.md](SMOKE_COMMANDS.md) |
| 原始证据和传输哈希 | [evidence](evidence/)、[TRANSFER_MANIFEST.json](TRANSFER_MANIFEST.json) |

本页复现使用仓库中已有的 SV 和 Verilator 5.052。已有 SV 来自 PSSC 0.1.0（commit c44287ec3493b62ccbcbbe4505f9dbfb35604e4e）。原始执行日志中的绝对路径保留用于审计。

统计包含已实例化 DUT 及补充依赖，排除 testbench、PSS runtime、未实例化模块；RAM 数组翻转未计入默认插桩范围。完整范围见覆盖率 JSON 和测试报告。

Spec/RTL 来自固定的 Spec2Cov 提交 98ddc836668c81d116e0bb9a7faf8f56b2c58cdb，出处记录在 [SOURCE.json](SOURCE.json)。该来源未发现根目录或本设计的 LICENSE，不对其另行声明许可。补充 CVDP 同步模块的原始 [LICENSE](dependencies/CVDP_LICENSE) 和 [NOTICE](dependencies/CVDP_NOTICE) 一并保留。
