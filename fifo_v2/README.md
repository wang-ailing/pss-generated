# FIFO v2：当前 Agent 新生成结果

2026-10-10，当前 Agent 通过 DeepSeek 新生成 PSS、SV testbench 和覆盖率辅助 C++，随后 PSSC 解析与生成、Verilator 编译与仿真、覆盖率统计均成功。三个前序阶段复用上一轮产物，代码生成角色本次真实调用 1 次。模型语义评审跳过，不表示评审通过。

功能检查：**10/10 意图通过，errors=0**。DUT 覆盖率：line 8/8、branch 16/16、expr 15/15（100%），toggle 1196/1246（95.99%）。本例目标是跑通生成至覆盖率的流程。

## 使用 Makefile

以下命令在 **Ubuntu Bash** 执行，需要 GNU Make 4.3 或更新版本；当前 Linux 已安装 Make 4.3 和 Verilator 5.052。使用仓库中已有的 PSS/SV。

```bash
cd /home/pssprobe
fifo_repo=/home/pssprobe/pss-generated-fifo-v2-demo
if [ -d "$fifo_repo/.git" ]; then
  git -C "$fifo_repo" pull --ff-only origin main
else
  git clone https://github.com/wang-ailing/pss-generated.git "$fifo_repo"
fi

cd "$fifo_repo/fifo_v2"
make all
```

`make all` 按依赖顺序完成编译、仿真、功能检查和覆盖率统计。新运行产物放在 **`runs/make/`**，结果是 `runs/make/results/functional.json`、`coverage.json`、`coverage.dat`、`dut.info` 和 `annotated/`。

`make all` 复用已经完成且参数未变的步骤；显式 `make sim` 会重新仿真，随后 `make coverage` 使用该次数据。工具、种子或超时参数变化时会更新对应阶段。

也可以分步执行：

```bash
make compile
make sim
make coverage
make report
```

| 指令 | 用途 |
| --- | --- |
| `make help` | 查看目标、可配置变量和输出位置 |
| `make check-tools` | 检查 Python、Verilator 和覆盖率工具 |
| `make compile` | 编译已有 SV、DUT 和 testbench |
| `make sim` | 仿真并检查十个意图是否全部通过 |
| `make coverage` | 生成 DUT 覆盖率报告，按需完成前置步骤 |
| `make report` | 打印覆盖率和结果目录 |
| `make all` | 完整流程 |
| `make clean` | 删除当前 `RUN_DIR` 的运行产物 |

可指定运行目录、随机种子、超时和编译并行度：

```bash
make all RUN_DIR=runs/my-fifo-run SEED=42 SIM_TIMEOUT=180 JOBS=1
```

`RUN_DIR` 必须位于本示例的 `runs/` 下。其他机器可通过 `PYTHON`、`VERILATOR`、`VERILATOR_COVERAGE` 和 `VERILATOR_ROOT` 指定实际工具路径；默认值对应当前 Ubuntu 环境。完整 Make 配方见 [Makefile](Makefile)，原始分步命令如下。

## 从已生成的 PSS 和 SV 复现

以下命令在你的 **Ubuntu Bash，同一个终端**按顺序执行。使用仓库内已有的 `model/fifo.pss`、`tb/tb_async_fifo.sv` 和 `generated/` 下的两个 SV 包，直接编译仿真。工具路径对应当前已经安装的 Linux 环境。

### 1. 获取源码，创建新的运行目录

起始工作目录：`/home/pssprobe`。已有这个仓库目录时更新，否则克隆。

```bash
set -euo pipefail
cd /home/pssprobe

fifo_repo=/home/pssprobe/pss-generated-fifo-v2-demo
if [ -d "$fifo_repo/.git" ]; then
  git -C "$fifo_repo" pull --ff-only origin main
else
  git clone https://github.com/wang-ailing/pss-generated.git "$fifo_repo"
fi

SOURCE_RUN="$fifo_repo/fifo_v2"
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
printf '本次运行目录：%s\n' "$PWD"
```

此处复制已有的生成代码。后续所有命令都在新 `$RUN` 目录执行；本次 `results/` 初始为空。

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

上述消息只在检查全部通过后打印。日志是 `results/simulate.log`；仿真产生本次新的 `coverage.dat` 和 `functional.json`。

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
print("本次结果目录：", Path("results").resolve())
PY

ls -lh results/functional.json results/coverage.json results/coverage.dat results/dut.info
cat results/coverage_summary.txt
```

此前已完成运行的结果为 line `8/8`、branch `16/16`、expr `15/15`（100%），toggle `1196/1246`（95.99%）。你本次运行以终端实际输出为准。

- `$RUN/results/functional.json`：功能检查结果。
- `$RUN/results/coverage.json`：DUT 覆盖率。
- `$RUN/results/coverage.dat`：本次仿真的原始覆盖数据。
- `$RUN/results/dut.info`：LCOV 数据。
- `$RUN/results/annotated/`：带覆盖命中信息的源码。
- `$RUN/results/build.log`、`simulate.log`、`coverage.log`：本次各步骤日志。

如果之后想从已有 `model/fifo.pss` 重新执行 PSSC 解析与 SV 生成，完整命令见 [LINUX_WALKTHROUGH.md](LINUX_WALKTHROUGH.md) 第 3～4 步。

## 产物位置

| 产物 | 位置 |
| --- | --- |
| Spec | [docs/fifo.md](docs/fifo.md) |
| Agent 生成的 PSS | [model/fifo.pss](model/fifo.pss) |
| Agent 生成的 SV | [tb/tb_async_fifo.sv](tb/tb_async_fifo.sv) |
| PSSC 生成的 SV | [generated/zsp_gen_pkg.sv](generated/zsp_gen_pkg.sv) |
| DUT 和补充依赖 | [rtl](rtl/)、[dependencies](dependencies/) |
| 元动作、计划、组合及模型返回工程 | [artifacts](artifacts/) |
| 本次调用与复用记录 | [artifacts/smoke_scope.json](artifacts/smoke_scope.json) |
| 功能结果 | [results/functional.json](results/functional.json) |
| 覆盖率 | [results/coverage.json](results/coverage.json)、[原始数据](results/coverage.dat) |
| Linux 操作步骤 | [LINUX_WALKTHROUGH.md](LINUX_WALKTHROUGH.md) |
| 完整测试报告 | [TEST_REPORT.md](TEST_REPORT.md) |
| 用户目标和模型运行命令 | [prompt.md](prompt.md)、[SMOKE_COMMANDS.md](SMOKE_COMMANDS.md) |
| 原始证据和传输哈希 | [evidence](evidence/)、[TRANSFER_MANIFEST.json](TRANSFER_MANIFEST.json) |

本页复现使用仓库中已有的 SV 和 Verilator 5.052。已有 SV 来自 PSSC 0.1.0（commit c44287ec3493b62ccbcbbe4505f9dbfb35604e4e）。原始执行日志中的绝对路径保留用于审计。

统计包含已实例化 DUT 及补充依赖，排除 testbench、PSS runtime、未实例化模块；RAM 数组翻转未计入默认插桩范围。完整范围见覆盖率 JSON 和测试报告。

Spec/RTL 来自固定的 Spec2Cov 提交 98ddc836668c81d116e0bb9a7faf8f56b2c58cdb，出处记录在 [SOURCE.json](SOURCE.json)。该来源未发现根目录或本设计的 LICENSE，不对其另行声明许可。补充 CVDP 同步模块的原始 [LICENSE](dependencies/CVDP_LICENSE) 和 [NOTICE](dependencies/CVDP_NOTICE) 一并保留。
