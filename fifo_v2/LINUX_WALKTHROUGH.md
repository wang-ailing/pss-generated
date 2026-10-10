# 当前 Agent 新生成 FIFO：Linux 仿真与覆盖率操作

日期：2026-10-10。PSS 指 Accellera Portable Test and Stimulus Standard；本练习使用 PSS 3.0 的 PSSC 工具支持子集和 Verilator 5.052。

本次当前 Agent 已经完成真实模型调用与 EDA 验证：8 个工具链步骤均返回 0，功能检查 `pass=true`、`errors=0`，10 个意图全部通过。DUT 覆盖率为 line `8/8`、branch `16/16`、expr `15/15`（均为 100%），toggle `1196/1246`（95.987159%）；仿真耗时 2.086 秒，DUT 源码运行前后哈希一致。下面新练习的状态和数值仍以该次命令实际输出为准。

下面使用本次当前 Agent 新生成的 `model/fifo.pss` 与 `tb/tb_async_fifo.sv`。PSSC 再由 PSS 生成 `generated/zsp_gen_pkg.sv`、`generated/zsp_rt_pkg.sv`。前两份是 Agent 的源码产物，后两份是 PSSC 的生成产物。

所有命令均在 **Ubuntu 虚拟机 Bash** 执行。工具已安装，无需安装软件、配置 API 密钥或重新调用模型。请在同一个终端按顺序执行 1～8 步；以下是操作说明，成功状态和覆盖率数值以实际输出为准。

## 1. 复制本次生成源码到新的练习目录

运行位置：Ubuntu 虚拟机；终端：Bash；起始工作目录：`/home/pssprobe`。

`SOURCE_RUN` 指向仓库中的 fifo_v2 源码。工具绝对路径对应已验证的 Ubuntu 环境；其他机器请替换为实际安装路径。首次克隆后如目录已存在，可跳过 git clone。

```bash
set -euo pipefail
cd /home/pssprobe
git clone https://github.com/wang-ailing/pss-generated.git /home/pssprobe/pss-generated-fifo-v2-demo
SOURCE_RUN=/home/pssprobe/pss-generated-fifo-v2-demo/fifo_v2
RUN="$SOURCE_RUN/runs/manual-current-agent-$(date -u +%Y%m%dT%H%M%SZ)"
mkdir -p -- "$SOURCE_RUN/runs"
test ! -e "$RUN"
mkdir -- "$RUN"
cp -R -- "$SOURCE_RUN/model" "$SOURCE_RUN/tb" "$SOURCE_RUN/rtl" "$SOURCE_RUN/dependencies" "$SOURCE_RUN/scripts" "$SOURCE_RUN/SOURCE.json" "$RUN/"
cd "$RUN"
mkdir generated results
export VERILATOR_ROOT=/home/pssprobe/hello-pss-sv/tools/verilator-5.052/usr/local/share/verilator
printf '本次练习目录：%s\n' "$PWD"
```

后续工作目录均为打印出的新 `$RUN`。此处只复制源码与报告脚本，新建的 `generated/`、`results/` 将接收本次运行产物。

## 2. 确认本次 Agent 生成的 PSS 与 SV

运行位置：Ubuntu 虚拟机；终端：Bash；工作目录：`$RUN`。

```bash
printf 'PSS 源码：%s/model/fifo.pss\nSV testbench：%s/tb/tb_async_fifo.sv\n' "$PWD" "$PWD"
ls -l -- model/fifo.pss tb/tb_async_fifo.sv tb/coverage_zero.cpp
cat model/fifo.pss
```

`model/fifo.pss` 描述测试意图；`tb/tb_async_fifo.sv` 将生成的 PSS 动作与 FIFO DUT 的时钟、接口、检查及功能结果连接起来。

## 3. 解析 PSS，输出中间表示

运行位置：Ubuntu 虚拟机；终端：Bash；工作目录：`$RUN`。

```bash
/home/pssprobe/fw_wb_dma_repro/.venv/bin/python -m pssc parse model/fifo.pss --dump-ir results/model.ir.yaml 2>&1 | tee results/manual_parse.log
test -s results/model.ir.yaml
```

解析成功后，应有非空 `results/model.ir.yaml`；如命令报错，先检查 `results/manual_parse.log`，不要跳到编译仿真。

## 4. 由 PSSC 生成 SystemVerilog

运行位置：Ubuntu 虚拟机；终端：Bash；工作目录：`$RUN`。

```bash
/home/pssprobe/fw_wb_dma_repro/.venv/bin/python -m pssc compile model/fifo.pss -t sv-native --projection oo_api --export-action main_a -o generated 2>&1 | tee results/manual_generate.log
test -s generated/zsp_gen_pkg.sv
test -s generated/zsp_rt_pkg.sv
ls -l -- generated/zsp_gen_pkg.sv generated/zsp_rt_pkg.sv
```

`main_a` 是本次导出的顶层动作；此步骤使用已有 PSS 源码进行工具生成。

## 5. 用 Verilator 编译仿真程序

运行位置：Ubuntu 虚拟机；终端：Bash；工作目录：`$RUN`。编译约需 1 分钟，具体随虚拟机负载变化。

```bash
/home/pssprobe/hello-pss-sv/tools/verilator-5.052/usr/local/bin/verilator \
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

此命令包含 6 份 DUT/依赖 SV、testbench、PSSC 生成包以及覆盖率辅助代码。成功后得到 `obj_dir/Vtb_async_fifo`。

## 6. 仿真，并检查 10 个功能意图

运行位置：Ubuntu 虚拟机；终端：Bash；工作目录：`$RUN`。

```bash
set -o pipefail
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

只有断言全部通过才会打印上述通过消息；这是一条预期验收条件，不是预先声明的运行结果。超时返回码通常为 `124`，其他错误查看 `results/manual_simulate.log`。

## 7. 统计 DUT 覆盖率并生成可查看报告

运行位置：Ubuntu 虚拟机；终端：Bash；工作目录：`$RUN`。

```bash
python3 scripts/report_coverage.py \
  --project-root "$PWD" \
  --coverage-tool /home/pssprobe/hello-pss-sv/tools/verilator-5.052/usr/local/bin/verilator_coverage \
  2>&1 | tee results/manual_coverage.log
```

脚本先从原始 `coverage.dat` 筛选 6 份 DUT/依赖文件的覆盖点，写入 `dut.dat`；再提取 line/branch 点写入 `dut_line_branch.dat`。生成包和 testbench 不计入 DUT 覆盖率。

脚本实际按顺序执行以下子命令，便于检查和复现；调用上面的脚本后无需再次手动执行：

```bash
/home/pssprobe/hello-pss-sv/tools/verilator-5.052/usr/local/bin/verilator_coverage --version
/home/pssprobe/hello-pss-sv/tools/verilator-5.052/usr/local/bin/verilator_coverage --report summary "$PWD/results/dut.dat"
/home/pssprobe/hello-pss-sv/tools/verilator-5.052/usr/local/bin/verilator_coverage --report hier "$PWD/results/dut.dat"
/home/pssprobe/hello-pss-sv/tools/verilator-5.052/usr/local/bin/verilator_coverage --annotate "$PWD/results/annotated" --annotate-all --annotate-points --annotate-min 1 "$PWD/results/dut.dat"
/home/pssprobe/hello-pss-sv/tools/verilator-5.052/usr/local/bin/verilator_coverage --annotate-min 1 --write-info "$PWD/results/dut.info" "$PWD/results/dut_line_branch.dat"
```

## 8. 查看本次覆盖率与结果文件

运行位置：Ubuntu 虚拟机；终端：Bash；工作目录：`$RUN`。

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
ls -lh -- results/functional.json results/coverage.json results/coverage.dat results/dut.dat results/dut.info
ls -l -- results/annotated
cat results/coverage_summary.txt
```

常用产物：

| 文件 | 用途 |
| --- | --- |
| `results/functional.json` | 功能通过状态、错误数和 10 个意图的结果 |
| `results/coverage.json` | DUT 覆盖率指标、统计范围与文件信息 |
| `results/coverage.dat` | 仿真输出的原始覆盖数据 |
| `results/dut.dat` | 筛选后的 DUT 覆盖数据 |
| `results/dut.info` | line/branch 的 LCOV 数据 |
| `results/annotated/` | 带命中信息的源码 |
| `results/manual_*.log` | 本次解析、生成、编译、仿真和统计日志 |

覆盖率的分母是 Verilator 实际插桩的点；某类型无插桩点时显示 `N/A`。本教程演示执行与获取覆盖率，不执行全面测试或覆盖率提升，也不承诺 100% 覆盖。
