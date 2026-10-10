# 基础异步 FIFO 验证示例

本示例使用 Accellera Portable Test and Stimulus Standard（PSS）描述验证场景，通过 PSSC 生成 SystemVerilog（SV）场景代码，接入异步 FIFO DUT，并使用 Verilator 完成功能仿真和代码覆盖率统计。

`model/fifo.pss` 和 `tb/tb_async_fifo.sv` 来自已有 DeepSeek 生成工程；本目录保存其可执行模型及独立工具链运行结果。PSSC 生成文件位于 `generated/`，编译与仿真不需要调用模型服务。

## 模型与接口

DUT 顶层为 `async_fifo`，默认 `p_data_width=32`、`p_addr_width=16`，容量为 65536 个数据字。

| 接口 | 信号 | 语义 |
|---|---|---|
| 写时钟域 | `i_wr_clk`、`i_wr_rst_n` | 写时钟及低有效复位 |
| 写请求 | `i_wr_en`、`i_wr_data`、`o_fifo_full` | 写使能、写入数据和满标志 |
| 读时钟域 | `i_rd_clk`、`i_rd_rst_n` | 读时钟及低有效复位 |
| 读请求 | `i_rd_en`、`o_rd_data`、`o_fifo_empty` | 读使能、读取数据和空标志 |

PSS 模型在 `pss_top` 中定义复位、读写、批量传输、随机数据与间隔、等待和标志采样等元动作。复合动作组合这些元动作表达验证意图，顶层入口为 `pss_top::main_a`。`exec body` 调用 `platform_pkg` 的 target 函数，由 SV testbench 实现 DUT 驱动、参考模型和结果检查。

## 目录结构

| 文件 | 用途 |
|---|---|
| [docs/fifo.md](docs/fifo.md) | FIFO 规范 |
| [model/fifo.pss](model/fifo.pss) | PSS 元动作、复合动作和顶层入口 |
| [tb/tb_async_fifo.sv](tb/tb_async_fifo.sv) | DUT 连接、激励、参考模型和功能检查 |
| [tb/coverage_zero.cpp](tb/coverage_zero.cpp) | 覆盖计数初始化辅助代码 |
| [generated/zsp_gen_pkg.sv](generated/zsp_gen_pkg.sv) | PSSC 生成的 SV 场景代码 |
| [generated/zsp_rt_pkg.sv](generated/zsp_rt_pkg.sv) | PSSC SV 运行库 |
| [rtl](rtl/) | Spec2Cov 原始 DUT 及关联 RAM 应用模块 |
| [dependencies](dependencies/) | 补充指针同步模块和原始许可文件 |
| [scripts/report_coverage.py](scripts/report_coverage.py) | DUT 覆盖数据筛选和报告生成 |
| [reference_results](reference_results/) | 参考运行的功能检查和覆盖率结果 |

## 环境与复现

以下命令全部在 Ubuntu bash 中执行。已有工具版本为 Python 3.12.3、PSSC 0.1.0、Verilator 5.052。PSSC 使用与 `wang-ailing/pssc` 的提交 `c44287ec3493b62ccbcbbe4505f9dbfb35604e4e` 一致的源码。

### 1. 克隆仓库并建立新运行目录

起始目录为 `/home/pssprobe`，新运行目录放在克隆仓库的 `fifo/runs/` 下。

```bash
cd /home/pssprobe
git clone https://github.com/wang-ailing/pss-generated.git /home/pssprobe/pss-generated-fifo-demo

fifo_repo_dir=/home/pssprobe/pss-generated-fifo-demo/fifo
mkdir -p "$fifo_repo_dir/runs"
fifo_run_dir="$(mktemp -d "$fifo_repo_dir/runs/manual-XXXXXXXX")"

cp -R \
  "$fifo_repo_dir/model" \
  "$fifo_repo_dir/tb" \
  "$fifo_repo_dir/rtl" \
  "$fifo_repo_dir/dependencies" \
  "$fifo_repo_dir/scripts" \
  "$fifo_repo_dir/SOURCE.json" \
  "$fifo_run_dir/"

mkdir -p "$fifo_run_dir/generated" "$fifo_run_dir/results"
cd "$fifo_run_dir"
printf '运行目录：%s\n' "$fifo_run_dir"
```

### 2. 设置工具

工作目录为上一步的 `$fifo_run_dir`。以下工具路径对应已有 Ubuntu 环境；在其他机器上需替换为实际安装路径。

```bash
set -o pipefail
fifo_python=/home/pssprobe/fw_wb_dma_repro/.venv/bin/python
fifo_verilator=/home/pssprobe/hello-pss-sv/tools/verilator-5.052/usr/local/bin/verilator
fifo_cov=/home/pssprobe/hello-pss-sv/tools/verilator-5.052/usr/local/bin/verilator_coverage
export VERILATOR_ROOT=/home/pssprobe/hello-pss-sv/tools/verilator-5.052/usr/local/share/verilator

"$fifo_python" --version
"$fifo_python" -m pip show pssc
"$fifo_verilator" --version
```

下面各步骤继续在同一个 bash 终端、同一个 `$fifo_run_dir` 中执行。每一步退出码为 0 后再执行下一步。

### 3. 解析 PSS

```bash
"$fifo_python" -m pssc parse \
  model/fifo.pss \
  --dump-ir results/model.ir.yaml \
  2>&1 | tee results/parse.log
printf 'PSS 解析退出码：%s\n' "$?"
```

### 4. 生成 SV

```bash
"$fifo_python" -m pssc compile \
  model/fifo.pss \
  -t sv-native \
  --projection oo_api \
  --export-action main_a \
  -o generated \
  2>&1 | tee results/generate.log
printf 'SV 生成退出码：%s\n' "$?"
```

### 5. 编译仿真程序

```bash
"$fifo_verilator" \
  --binary \
  --timing \
  --top-module tb_async_fifo \
  -Wno-fatal \
  --coverage-line \
  --coverage-toggle \
  --coverage-expr \
  --coverage-per-instance \
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
  --Mdir obj_dir \
  -j 1 \
  -MAKEFLAGS OBJCACHE= \
  2>&1 | tee results/build.log
printf 'Verilator 编译退出码：%s\n' "$?"
```

### 6. 执行仿真

```bash
./obj_dir/Vtb_async_fifo \
  +verilator+seed+42 \
  +verilator+coverage+file+results/coverage.dat \
  2>&1 | tee results/simulate.log
printf '仿真退出码：%s\n' "$?"

"$fifo_python" - <<'PY'
import json
from pathlib import Path
report = json.loads(Path("results/functional.json").read_text())
print("总体通过：", report["pass"])
print("错误数：", report["errors"])
for intent in report["intents"]:
    print(intent["id"], "PASS" if intent["pass"] else "FAIL")
PY
```

### 7. 生成覆盖率报告

```bash
"$fifo_python" scripts/report_coverage.py \
  --project-root "$fifo_run_dir" \
  --coverage-tool "$fifo_cov" \
  2>&1 | tee results/coverage.log
printf '覆盖率报告退出码：%s\n' "$?"
```

覆盖率脚本筛选 DUT 数据后会实际调用以下子命令。脚本已执行这些命令，无需另行重复执行：

```bash
"$fifo_cov" --version
"$fifo_cov" --report summary "$fifo_run_dir/results/dut.dat"
"$fifo_cov" --report hier "$fifo_run_dir/results/dut.dat"
"$fifo_cov" \
  --annotate "$fifo_run_dir/results/annotated" \
  --annotate-all \
  --annotate-points \
  --annotate-min 1 \
  "$fifo_run_dir/results/dut.dat"
"$fifo_cov" \
  --annotate-min 1 \
  --write-info "$fifo_run_dir/results/dut.info" \
  "$fifo_run_dir/results/dut_line_branch.dat"
```

### 8. 查看覆盖率

```bash
"$fifo_python" - <<'PY'
import json
from pathlib import Path
report = json.loads(Path("results/coverage.json").read_text())
for key in ("line", "branch", "expr", "toggle"):
    metric = report["metrics"][key]
    print(f"{key}: {metric['covered']}/{metric['total']} = {metric['percent']}%")
print("结果目录：", Path("results").resolve())
PY
```

运行结果保存在 `$fifo_run_dir/results/`，其中 `functional.json` 是功能检查，`coverage.json` 是覆盖率统计，`coverage.dat` 是原始数据，`dut.info` 是 LCOV 报告，`annotated/` 是带覆盖信息的 RTL。

## 参考结果

参考结果来自使用本目录 PSS/SV 的真实工具链运行。PSS 解析、SV 生成、Verilator 编译、仿真和覆盖率统计均成功；工具链运行未调用模型服务。

10 条验证意图全部通过，错误数为 0。检查范围包括复位、单次读写、写满与阻止溢出、读空、数据顺序、并发读写、指针同步与标志变化、运行中协调复位、指针回绕和随机激励。

| 覆盖类型 | 已覆盖 / 总插桩点 | 覆盖率 |
|---|---:|---:|
| 行 | 8 / 8 | 100% |
| 分支 | 16 / 16 | 100% |
| 表达式 | 15 / 15 | 100% |
| 翻转 | 1228 / 1246 | 98.555377% |

统计范围为 `async_fifo` 及实际实例化的五个子模块，包含补充的 `write_to_read_pointer_sync`。测试平台、PSSC 生成的 SV 和运行库，以及未实例化的 `rtl/load_memory.sv` 不计入 DUT 汇总。Verilator 默认 `--coverage-max-width 256`，整个 RAM 存储数组未计入翻转覆盖率。百分比按工具插桩点统计。

仅计算原始仓库 RTL 时，行覆盖为 7/7，分支为 14/14，表达式为 13/13，翻转为 1122/1140（98.421053%）。统计范围和各文件指标见 [reference_results/coverage.json](reference_results/coverage.json)；功能状态见 [reference_results/functional.json](reference_results/functional.json)。

## 来源与完整性

- 规范和原始 RTL：[Spec2Cov 固定提交](https://github.com/advent-lab/Spec2Cov/tree/98ddc836668c81d116e0bb9a7faf8f56b2c58cdb/data/cvdp_agentic_async_fifo_compute_ram_application)。
- 原仓库引用但缺少的 `write_to_read_pointer_sync` 来自 NVIDIA CVDP 数据集的同一 FIFO 示例；原文、许可和 NOTICE 保存在 `dependencies/`。
- [SOURCE.json](SOURCE.json) 保存源码来源和各 RTL 文件 SHA-256。
- [TRANSFER_MANIFEST.json](TRANSFER_MANIFEST.json) 记录 Linux 导出文件的字节数和 SHA-256。PSS 的 action 中文说明注释属于文档补充，未改变模型行为；当前仓库文件哈希以根目录 [SHA256SUMS](../SHA256SUMS) 为准。
