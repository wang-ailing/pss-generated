# FIFO 快速覆盖率指令

更新日期：2026-10-10。运行位置：Ubuntu 虚拟机、bash；工作目录 `/home/pssprobe/spec2cov_fifo_practice`。PSS 指 Accellera Portable Test and Stimulus Standard。

本轮目标是跑通真实 DeepSeek 生成、PSSC、Verilator 并产出覆盖率文件，不要求完备验证。来源运行 `live-20261010T012953Z-59824` 的两个真实专家产物已完成，随后取消、退出 130，未执行工具链。快速运行 `coverage-smoke-20261010` 复用原 11 动作目录，按反馈真实调用一次验证计划 Agent，保持原 10 个 intent ID，再真实调用拼接和代码生成。规划与组合的两个模型语义审查均不调用，状态为 `skipped_by_user_smoke_scope`、`accepted: null`，不伪造接受结果。结构校验、功能报告契约及真实工具链继续执行。

当前实际状态：首次来源检查退出 0，真实计划局部修复成功；之后拼接请求返回通用 provider request failed，报告 error、工具为空，未进入生成或工具执行。服务超时配置为 900 秒，不能仅凭该配置把通用错误称为超时。`coverage-smoke-20261010-retry1` 来源检查已退出 0，复用首次目录和修正版计划，不再调用专家或计划修复；真实拼接请求进行中。Linux 核心 222 项、案例 6 项已通过，工具与覆盖率结果仍待实际产物。

## 1. 当前实际入口记录

下面保存本次启动使用的固定目录。**再次运行时必须同时换用新的 output、日志和 prompt 快照名称**；已有输出目录会被拒绝，不覆盖原件，不删除旧目录。来源目录可以保持不变。

先关闭命令跟踪并加载公开工具环境。来源检查不调用模型或工具，也不创建输出目录：

```bash
cd '/home/pssprobe/spec2cov_fifo_practice'
set +x
set -euo pipefail
source './environment.sh'
/home/pssprobe/pss-agent-verification/.venv/bin/python \
  '/home/pssprobe/spec2cov_fifo_practice/scripts/run_coverage_smoke.py' \
  --source-run '/home/pssprobe/spec2cov_fifo_practice/runs/live-20261010T012953Z-59824' \
  --output '/home/pssprobe/spec2cov_fifo_practice/runs/coverage-smoke-20261010' \
  --plan-feedback '/home/pssprobe/spec2cov_fifo_practice/inputs/smoke-plan-feedback.json' \
  --base-url 'https://api.deepseek.com' \
  --model 'deepseek-v4-pro' \
  --reasoning-effort low \
  --context-budget 128000 \
  --max-output-tokens 131072 \
  --composition-attempts 2 \
  --generation-attempts 3 \
  --provider-timeout 900 \
  --check-only
```

然后在同一 bash 中加载已经保存的私有配置并启动真实运行。私有文件为用户本地 `0600` 配置，导出 `PSS_AGENT_API_KEY`；密钥不写入命令、文档、案例或日志，禁止开启 `set -x`：

```bash
cd '/home/pssprobe/spec2cov_fifo_practice'
set +x
set -euo pipefail
source './environment.sh'
source "$HOME/.config/pss-agent/provider.env"
/home/pssprobe/pss-agent-verification/.venv/bin/python \
  '/home/pssprobe/spec2cov_fifo_practice/scripts/run_coverage_smoke.py' \
  --source-run '/home/pssprobe/spec2cov_fifo_practice/runs/live-20261010T012953Z-59824' \
  --output '/home/pssprobe/spec2cov_fifo_practice/runs/coverage-smoke-20261010' \
  --plan-feedback '/home/pssprobe/spec2cov_fifo_practice/inputs/smoke-plan-feedback.json' \
  --base-url 'https://api.deepseek.com' \
  --model 'deepseek-v4-pro' \
  --reasoning-effort low \
  --context-budget 128000 \
  --max-output-tokens 131072 \
  --composition-attempts 2 \
  --generation-attempts 3 \
  --provider-timeout 900 \
  2>&1 | tee '/home/pssprobe/spec2cov_fifo_practice/logs/coverage-smoke-20261010.log'
```

脚本默认启用 JSON 模型输出，provider timeout 900 秒；适配器本轮工具超时 900 秒、仿真种子 42。生成 3 是总轮数预算，耗尽不会标为通过。DeepSeek 的 medium 映射为 high，本次显式 low，见 [官方说明](https://api-docs.deepseek.com/guides/thinking_mode/)。

### 1.1 当前 retry1 入口记录

来源改为首次快速运行的真实失败目录，复用它已成功完成的计划。**不传 `--plan-feedback`**，因此不再发起计划修复；旧失败报告保留。以下同样是本次固定命名记录，再次运行必须改新 output 和日志名。

```bash
cd '/home/pssprobe/spec2cov_fifo_practice'
set +x
set -euo pipefail
source './environment.sh'
/home/pssprobe/pss-agent-verification/.venv/bin/python \
  '/home/pssprobe/spec2cov_fifo_practice/scripts/run_coverage_smoke.py' \
  --source-run '/home/pssprobe/spec2cov_fifo_practice/runs/coverage-smoke-20261010' \
  --output '/home/pssprobe/spec2cov_fifo_practice/runs/coverage-smoke-20261010-retry1' \
  --base-url 'https://api.deepseek.com' \
  --model 'deepseek-v4-pro' \
  --reasoning-effort low \
  --context-budget 128000 \
  --max-output-tokens 131072 \
  --composition-attempts 2 \
  --generation-attempts 3 \
  --provider-timeout 900 \
  --check-only

source "$HOME/.config/pss-agent/provider.env"
/home/pssprobe/pss-agent-verification/.venv/bin/python \
  '/home/pssprobe/spec2cov_fifo_practice/scripts/run_coverage_smoke.py' \
  --source-run '/home/pssprobe/spec2cov_fifo_practice/runs/coverage-smoke-20261010' \
  --output '/home/pssprobe/spec2cov_fifo_practice/runs/coverage-smoke-20261010-retry1' \
  --base-url 'https://api.deepseek.com' \
  --model 'deepseek-v4-pro' \
  --reasoning-effort low \
  --context-budget 128000 \
  --max-output-tokens 131072 \
  --composition-attempts 2 \
  --generation-attempts 3 \
  --provider-timeout 900 \
  2>&1 | tee '/home/pssprobe/spec2cov_fifo_practice/logs/coverage-smoke-20261010-retry1.log'
```

## 2. Prompt、反馈与来源

- 来源专家的实际六角色提示快照：`logs/live-20261010T012953Z-59824.prompts/`；只有该次实际调用的角色算真实调用。
- 完整导出的快速流程六角色提示文本在 `logs/coverage-smoke-20261010-retry1.prompts/`。原 `logs/coverage-smoke-20261010.prompts/` 导出曾失败、只含 partial 内容，保留原目录，不能当完整快照。即使完整快照保存了 reviewer 文本，这两个角色仍未调用。
- 局部计划修复反馈：`inputs/smoke-plan-feedback.json`，包含 `plan_feedback` 和供生成器使用的 `execution_notes`，不作为全面模型审查。
- 来源请求必须包含相同 Spec、六份 Header、六个明确提供的 RTL/依赖 body 和 target；源码仍按固定来源哈希校验，DUT 默认 32 位、深度 65536 不改。
- `artifacts/smoke_scope.json` 及 request provenance 记录原件 SHA、原计划与新计划 SHA、历史复用和真实调用计数，以及两个审查的 skipped/accepted-null 状态。取消来源不改写。

写域单独复位后的 shadow 地址和可读范围是这次局部修复要解决的执行问题；它不证明整份计划完备，也不构成新增全面审核。

## 3. 工具子命令预览

以下为适配器的第一轮工程命令模板，工作目录是当前输出根目录。它们会由工具链执行并留证，**本节不是已执行或通过的结果，也不需要在活跃运行旁再手工执行**。若发生生成修复，工程工作目录以 `artifacts/generation_attempts.json` 的 `selected_project_directory` 为准；完整实际 argv、环境、退出码和日志哈希以该轮 `toolchain.json` 为准。

```bash
cd '/home/pssprobe/spec2cov_fifo_practice/runs/coverage-smoke-20261010-retry1'
export VERILATOR_ROOT='/home/pssprobe/hello-pss-sv/tools/verilator-5.052/usr/local/share/verilator'

/home/pssprobe/fw_wb_dma_repro/.venv/bin/python --version
/home/pssprobe/fw_wb_dma_repro/.venv/bin/python -m pip show pssc
/home/pssprobe/hello-pss-sv/tools/verilator-5.052/usr/local/bin/verilator --version

/home/pssprobe/fw_wb_dma_repro/.venv/bin/python -m pssc parse \
  'model/fifo.pss' --dump-ir 'results/model.ir.yaml'

/home/pssprobe/fw_wb_dma_repro/.venv/bin/python -m pssc compile \
  'model/fifo.pss' -t sv-native --projection oo_api \
  --export-action main_a -o 'generated'

/home/pssprobe/hello-pss-sv/tools/verilator-5.052/usr/local/bin/verilator \
  --binary --timing --top-module tb_async_fifo -Wno-fatal \
  --coverage-line --coverage-toggle --coverage-expr --coverage-per-instance \
  -Igenerated \
  'generated/zsp_rt_pkg.sv' 'generated/zsp_gen_pkg.sv' \
  'rtl/async_fifo.sv' 'rtl/fifo_memory.sv' \
  'rtl/rptr_empty.sv' 'rtl/wptr_full.sv' \
  'rtl/read_to_write_pointer_sync.sv' \
  'dependencies/write_to_read_pointer_sync.sv' \
  'tb/tb_async_fifo.sv' 'tb/coverage_zero.cpp' \
  --Mdir 'obj_dir' -j 1 -MAKEFLAGS 'OBJCACHE='

/home/pssprobe/spec2cov_fifo_practice/runs/coverage-smoke-20261010-retry1/obj_dir/Vtb_async_fifo \
  '+verilator+seed+42' '+verilator+coverage+file+results/coverage.dat'

/home/pssprobe/fw_wb_dma_repro/.venv/bin/python 'scripts/report_coverage.py' \
  --project-root '/home/pssprobe/spec2cov_fifo_practice/runs/coverage-smoke-20261010-retry1' \
  --coverage-tool '/home/pssprobe/hello-pss-sv/tools/verilator-5.052/usr/local/bin/verilator_coverage'
```

## 4. 查看当前真实结果

只读查看状态、选中工程和实际工具命令：

```bash
cd '/home/pssprobe/spec2cov_fifo_practice'
bash './commands.sh' show \
  '/home/pssprobe/spec2cov_fifo_practice/runs/coverage-smoke-20261010-retry1'
```

最终关注选中工程的 `results/coverage.dat`、`results/dut.dat`、`results/coverage.json` 和 `results/dut.info`，以及该轮实际工具报告。第一轮根目录的结果不能替代后续轮次。覆盖率范围、计划限制和实际通过/失败结论完成后更新 TEST_REPORT；不引用历史运行 13 的覆盖率冒称本次结果。

## retry2：只重跑代码生成（已停止，未验收）
Ubuntu Bash，工作目录 `/home/pssprobe/spec2cov_fifo_practice`。使用既有本地私有配置，不把密钥写进 prompt 或报告：

```bash
cd /home/pssprobe/spec2cov_fifo_practice
source ./environment.sh
set +x
source "$HOME/.config/pss-agent/provider.env"
/home/pssprobe/pss-agent-verification/.venv/bin/python scripts/run_coverage_smoke.py --source-run runs/coverage-smoke-20261010-retry1 --output runs/coverage-smoke-20261010-retry2 --reuse-composition --base-url https://api.deepseek.com --model deepseek-v4-pro --reasoning-effort low --context-budget 128000 --max-output-tokens 131072 --provider-timeout 900 --generation-attempts 3
```

这是本次实际参数记录；已存在的 output 不能重用，若再次执行须换新目录。真实结果为 codegen success、toolchain cancelled，第二候选编译通过后仿真超过 5 分钟未完成，主动停止。报告/日志及 source hash 在同名 run 与最终证据清单中。要立即复现已验收覆盖率，请用 REPLAY_COMMANDS.md。


## current-agent：当前代码生成 Agent 的真实修复与成功执行

Ubuntu Bash，工作目录 `/home/pssprobe/spec2cov_fifo_practice`。以下为本次实际命令；再次生成须换新 output 目录。

```bash
cd /home/pssprobe/spec2cov_fifo_practice
source ./environment.sh
set +x
source "$HOME/.config/pss-agent/provider.env"
/home/pssprobe/pss-agent-verification/.venv/bin/python scripts/run_coverage_smoke.py --source-run runs/coverage-smoke-20261010-retry2 --output runs/current-agent-fifo-20261010 --reuse-composition --execution-feedback inputs/current-agent-execution-feedback.json --tool-timeout 180 --base-url https://api.deepseek.com --model deepseek-v4-pro --reasoning-effort low --context-budget 128000 --max-output-tokens 131072 --provider-timeout 900 --generation-attempts 3
```

实际 outcome=success，代码生成角色真实调用1次，其余三个阶段沿用已有产物；8个EDA步骤全0，10意图通过、错误0。模型收到专用执行反馈与previous_project；源码未手工改写。直接仿真与取覆盖率无需再次调用模型，见 CURRENT_AGENT_LINUX_WALKTHROUGH.md。
