# FIFO v2 生成配置与工具链参考

本文件记录 `fifo_v2` 工程的 Agent 代码生成配置、上下文来源和工具链参数。已有 PSS/SV 的编译、仿真及覆盖率复现入口见 [README.md](README.md) 和 [LINUX_WALKTHROUGH.md](LINUX_WALKTHROUGH.md)。

## 工程边界

代码生成入口 `scripts/run_coverage_smoke.py` 属于外部 PSS Agent 案例工程 `/home/pssprobe/spec2cov_fifo_practice`，本结果仓库不包含该脚本、Agent 核心或其全部历史输入目录。下述 Agent 命令用于说明生成条件；仅克隆本仓库不能运行此入口。

本仓库包含可直接复现 EDA 的 PSS、SV、RTL、依赖及覆盖率脚本。执行已有代码不需要模型 API 或私有密钥。

## 生成参数

| 参数 | 参考值 |
|---|---|
| 模型服务 | `https://api.deepseek.com` |
| 模型 | `deepseek-v4-pro` |
| 推理强度 | `low` |
| 上下文预算 | `128000` |
| 最大输出 token | `131072` |
| 模型请求超时 | `900` 秒 |
| 工具执行超时 | `180` 秒 |
| 代码生成候选预算 | `3` |
| 实际选中候选 | `1` |
| 仿真种子 | `42` |
| DUT 数据宽度 / 地址宽度 / 深度 | `32 / 16 / 65536` |

模型请求使用结构化 JSON 输出。候选预算表示最多允许的生成尝试数，实际生成与工具运行状态由产物记录决定。

## 上下文复用与代码来源

| 阶段 | 输入策略 | 实际模型调用数 |
|---|---|---:|
| 元动作分解 | 复用已有 `atomic_decomposition.json` | 0 |
| 验证计划 | 复用已有 `verification_plan.json` | 0 |
| 动作组合 | 复用已有 `composition.json` | 0 |
| PSS/SV 代码生成 | 传入既有工程和执行反馈，重新生成完整工程 | 1 |

计划与组合的独立模型语义审查状态为 `skipped_by_user_smoke_scope`、`accepted: null`。结构校验、功能报告检查和真实工具链均执行。

PSS 和 SV testbench 由代码生成角色返回，未经过手工代码修补。PSSC 再从 PSS 生成 `generated/zsp_gen_pkg.sv` 和运行库。

可核对的来源记录：

- [artifacts/request.json](artifacts/request.json)：规范、接口、RTL 和目标配置。
- [artifacts/smoke_scope.json](artifacts/smoke_scope.json)：输入 SHA-256、上下文复用、实际角色调用数和执行反馈。
- [artifacts/execution-feedback.json](artifacts/execution-feedback.json)：提供给代码生成角色的执行诊断。
- [artifacts/project.json](artifacts/project.json)：模型返回的完整工程。
- [artifacts/generation_attempts.json](artifacts/generation_attempts.json)：候选工程选择及工具结果位置。
- [results/toolchain.json](results/toolchain.json)：实际命令参数、环境、退出码和日志。
- [TEST_REPORT.md](TEST_REPORT.md)：功能结果与覆盖率范围。

来源路径中的运行标识保留为溯源字段，不作为本仓库的运行依赖。

执行反馈要求显式绑定普通批量读写的 `blocking == 1` 和 `gap_cycles == 0`，保留满写、空读场景的 `blocking == 0`。SV 保留真实 RAM-shadow 数据检查、累计计数、意图计数差值，并设置全局 watchdog 和意图进度输出。反馈不要求提升覆盖率或扩展验证场景。

## 外部 Agent 工程的参考入口

运行位置：Ubuntu bash；工作目录 `/home/pssprobe/spec2cov_fifo_practice`。以下是成功工程的参数记录，需要对应外部工程、来源目录和反馈文件。私有配置文件在用户本地导出 `PSS_AGENT_API_KEY`；密钥不写入命令或仓库。

```bash
cd /home/pssprobe/spec2cov_fifo_practice
source ./environment.sh
set +x
source "$HOME/.config/pss-agent/provider.env"

/home/pssprobe/pss-agent-verification/.venv/bin/python \
  scripts/run_coverage_smoke.py \
  --source-run runs/coverage-smoke-20261010-retry2 \
  --output runs/current-agent-fifo-20261010 \
  --reuse-composition \
  --execution-feedback inputs/current-agent-execution-feedback.json \
  --tool-timeout 180 \
  --base-url https://api.deepseek.com \
  --model deepseek-v4-pro \
  --reasoning-effort low \
  --context-budget 128000 \
  --max-output-tokens 131072 \
  --provider-timeout 900 \
  --generation-attempts 3
```

再次生成必须使用新的 `--output` 目录。上述固定输出目录是参考工程标识，已存在的输出目录不能覆盖。可在新输出路径下添加 `--check-only` 先检查输入来源；该选项不调用模型或 EDA 工具。

## PSS 解析与 SV 再生成

运行位置：Ubuntu bash；工作目录为外部案例工程中的参考运行根目录。以下命令对应记录的工具版本和参数。使用结果仓库中的工程时，目录及工具路径配置见 [README.md](README.md)。

```bash
cd /home/pssprobe/spec2cov_fifo_practice/runs/current-agent-fifo-20261010
export VERILATOR_ROOT=/home/pssprobe/hello-pss-sv/tools/verilator-5.052/usr/local/share/verilator

/home/pssprobe/fw_wb_dma_repro/.venv/bin/python --version
/home/pssprobe/fw_wb_dma_repro/.venv/bin/python -m pip show pssc
/home/pssprobe/hello-pss-sv/tools/verilator-5.052/usr/local/bin/verilator --version

/home/pssprobe/fw_wb_dma_repro/.venv/bin/python -m pssc parse \
  model/fifo.pss \
  --dump-ir results/model.ir.yaml

/home/pssprobe/fw_wb_dma_repro/.venv/bin/python -m pssc compile \
  model/fifo.pss \
  -t sv-native \
  --projection oo_api \
  --export-action main_a \
  -o generated
```

## 编译、仿真与覆盖率参数

同一 Ubuntu bash 终端、同一参考运行根目录：

```bash
/home/pssprobe/hello-pss-sv/tools/verilator-5.052/usr/local/bin/verilator \
  --binary --timing --top-module tb_async_fifo -Wno-fatal \
  --coverage-line --coverage-toggle --coverage-expr --coverage-per-instance \
  -Igenerated \
  generated/zsp_rt_pkg.sv generated/zsp_gen_pkg.sv \
  rtl/async_fifo.sv rtl/fifo_memory.sv \
  rtl/rptr_empty.sv rtl/wptr_full.sv \
  rtl/read_to_write_pointer_sync.sv \
  dependencies/write_to_read_pointer_sync.sv \
  tb/tb_async_fifo.sv tb/coverage_zero.cpp \
  --Mdir obj_dir -j 1 -MAKEFLAGS OBJCACHE=

timeout 180 ./obj_dir/Vtb_async_fifo \
  +verilator+seed+42 \
  +verilator+coverage+file+results/coverage.dat

/home/pssprobe/fw_wb_dma_repro/.venv/bin/python scripts/report_coverage.py \
  --project-root "$PWD" \
  --coverage-tool /home/pssprobe/hello-pss-sv/tools/verilator-5.052/usr/local/bin/verilator_coverage
```

覆盖率脚本筛选 DUT 数据后，调用以下子命令生成摘要、层次报告、源码注解和 LCOV 数据。脚本已执行这些命令，无需另行重复执行：

```bash
/home/pssprobe/hello-pss-sv/tools/verilator-5.052/usr/local/bin/verilator_coverage --version

/home/pssprobe/hello-pss-sv/tools/verilator-5.052/usr/local/bin/verilator_coverage \
  --report summary "$PWD/results/dut.dat"

/home/pssprobe/hello-pss-sv/tools/verilator-5.052/usr/local/bin/verilator_coverage \
  --report hier "$PWD/results/dut.dat"

/home/pssprobe/hello-pss-sv/tools/verilator-5.052/usr/local/bin/verilator_coverage \
  --annotate "$PWD/results/annotated" \
  --annotate-all --annotate-points --annotate-min 1 \
  "$PWD/results/dut.dat"

/home/pssprobe/hello-pss-sv/tools/verilator-5.052/usr/local/bin/verilator_coverage \
  --annotate-min 1 \
  --write-info "$PWD/results/dut.info" \
  "$PWD/results/dut_line_branch.dat"
```

参考工程的 PSS 解析、SV 生成、编译、仿真和覆盖率统计均成功。功能结果为 10/10 意图通过、错误数 0；DUT 翻转覆盖率为 1196/1246（95.987159%）。完整统计范围与逐阶段产物见 [TEST_REPORT.md](TEST_REPORT.md)。
