# 异步 FIFO 验证工程任务定义

## 目标

基于 FIFO 规范、接口及 RTL，生成使用 Accellera Portable Test and Stimulus Standard（PSS）建模、SystemVerilog（SV）实现目标执行函数的验证工程。通过 PSSC 解析和生成 SV，接入原始 DUT，再以 Verilator 编译、仿真并产出功能结果和代码覆盖率。

验收范围为可执行代码生成及工具链贯通，不要求覆盖率提升或完整验证闭合。

## 输入与目标配置

- 规范：[docs/fifo.md](docs/fifo.md)。
- 原始 RTL：[rtl/](rtl/)；补充模块及许可：[dependencies/](dependencies/)。
- 来源和完整性：[SOURCE.json](SOURCE.json)。
- 实际结构化请求：[artifacts/request.json](artifacts/request.json)，包含规范、接口、提供的 RTL body 和目标配置。
- PSS 采用 3.0 建模语义，具体语法限定为目标 PSSC 支持的子集。
- DUT 保持默认配置：数据宽度 32、地址宽度 16、深度 65536。
- PSS 文件为 `model/fifo.pss`，顶层动作为 `pss_top::main_a`，SV testbench 为 `tb/tb_async_fifo.sv`。

## Agent 编排

1. 元动作分解子 Agent：提取可复用元动作、参数、前后条件、SV 绑定及读写时钟域、复位和握手契约。
2. 验证计划子 Agent：独立定义验证意图、刺激策略、通过判据和覆盖目标。
3. 主 Agent：检查元动作目录与验证计划的一致性，将元动作拼接为每条意图对应的一个复合动作。
4. 代码生成角色：生成 PSS 元动作、复合动作和组合全部意图的顶层动作，并以 SV 实现 target 函数，落实 `exec body` 绑定。
5. 工具链：执行真实 PSSC 解析和 SV 生成、DUT 集成、Verilator 编译、仿真及覆盖率报告。
6. 执行反馈：根据实际错误修复生成工程，保留原计划、检查器和 DUT，重新执行相关工具步骤。

以上定义逻辑阶段，不表示参考工程重新执行了每个角色。`fifo_v2` 复用了元动作分解、验证计划和动作组合产物，代码生成角色实际调用 1 次。计划与组合的独立模型语义审查被跳过，`accepted` 为 `null`；具体来源和调用统计见 [artifacts/smoke_scope.json](artifacts/smoke_scope.json)。

## 模型与检查约束

- 每条验证意图明确 setup、刺激、采样、oracle 和 cleanup，使用计数快照后的 delta 进行判定。
- 检查实际接受的读写次数、FIFO 数据顺序、复位丢弃、满/空合法阻止及并发行为；具体场景以已保存的验证计划为准。
- 每条意图的通过判据必须落实为可执行检查，报告记录真实状态和统计范围。
- 对规范没有规定的严格 CDC 延迟、阻止访问时输出稳定性，不额外设定为 DUT 必须满足的要求。
- 单域复位从已知地址和数据状态起步，分别维护 DUT 指针模型、shadow 有效性和统计计数。检查器开启新 epoch 不代表 DUT RAM 清零。
- 普通批量读写显式约束 `blocking == 1`、`gap_cycles == 0`；满写和空读的非法尝试保留 `blocking == 0`，不依赖未被生成器保留的 soft 默认约束。
- SV 变量声明位于其词法块的语句之前。使用意图进度输出及独立全局 watchdog 定位无法结束的场景。
- 保持原始 RTL、DUT 连接和真实数据检查。不能通过修改 DUT、删除判据或硬编码 PASS 使运行通过。
- 执行反馈仅修复可执行性，不新增覆盖率优化场景。

## 产物与验收

| 产物 | 位置 | 验收内容 |
|---|---|---|
| 元动作目录 | `artifacts/atomic_decomposition.json` | 参数、契约和 target 绑定可追溯 |
| 验证计划 | `artifacts/verification_plan.json` | 每条意图包含刺激和通过判据 |
| 动作组合 | `artifacts/composition.json` | 每条意图对应一个组合场景 |
| 返回工程 | `artifacts/project.json` | 包含完整 PSS 和 SV 源码 |
| PSS/SV | `model/`、`tb/`、`generated/` | 解析和编译成功，绑定可执行 |
| 工具结果 | `results/toolchain.json` | 真实命令、退出码和日志可核对 |
| 功能结果 | `results/functional.json` | 各意图真实通过，错误数为 0 |
| 覆盖率结果 | `results/coverage.json`、`results/coverage.dat` | 真实插桩数据及明确的统计范围 |
| 技术报告 | `TEST_REPORT.md` | 测试范围、结果和各阶段产物位置 |

阶段复用、实时模型调用、跳过审查和工具成功必须分别记录。已有代码的 EDA 重跑不能计为新的代码生成；跳过审查不能计为审查通过。

## 提示文件的用途

本文件是供开发和复现使用的技术任务定义，Agent CLI 不直接加载它。实际结构化输入见 `artifacts/request.json`，模型工程返回见 `artifacts/project.json`；代码生成参数及外部入口见 [SMOKE_COMMANDS.md](SMOKE_COMMANDS.md)。
