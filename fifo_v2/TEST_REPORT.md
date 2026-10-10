# 异步 FIFO 验证报告

## 验证环境

案例使用 Accellera Portable Test and Stimulus Standard（PSS）描述测试场景，通过 PSSC 生成 SystemVerilog，并由 Verilator 执行 DUT 仿真与覆盖率采集。

| 配置项 | 值 |
| --- | --- |
| DUT | 异步 FIFO，含双时钟域指针同步与存储模块 |
| 数据宽度 | 32 bit |
| 地址宽度 | 16 bit |
| FIFO 深度 | 65536 |
| 随机种子 | 42 |
| PSS 语法 | PSS 3.0 的 PSSC 支持子集 |
| PSSC | 0.1.0，commit `c44287ec3493b62ccbcbbe4505f9dbfb35604e4e` |
| Verilator | 5.052 |
| 代码生成模型 | DeepSeek `deepseek-v4-pro` |
| 功能判定 | `pass=true`、`errors=0`、10/10 意图通过 |

DUT 来自 Spec2Cov 的异步 FIFO 案例。补齐的 `write_to_read_pointer_sync.sv` 依赖、来源和许可证记录在 [SOURCE.json](SOURCE.json) 与 [dependencies/](dependencies/) 中。参与仿真的六份 DUT/依赖源码在执行前后 SHA-256 一致。

## 功能场景

[functional.json](results/functional.json) 记录各验证意图的结果：

| 验证意图 | 检查内容 | 结果 |
| --- | --- | --- |
| `basic_ordered_write_read` | 基本写入、读取与数据顺序 | PASS |
| `full_detection_and_extra_write_blocking` | 满标志与额外写入阻止 | PASS |
| `empty_detection_and_read_blocking` | 空标志与空队列读取阻止 | PASS |
| `concurrent_producer_consumer` | 并发生产与消费 | PASS |
| `write_domain_reset_with_nonzero_read_pointer` | 读指针非零时的写域复位 | PASS |
| `read_domain_reset_with_nonzero_read_pointer` | 读指针非零时的读域复位与数据重放 | PASS |
| `coordinated_reset_flush` | 双域协同复位与清空 | PASS |
| `near_full_boundary_transition` | 接近满状态的边界转换 | PASS |
| `pointer_synchronization_empty_full_flags` | 指针同步与空满标志更新 | PASS |
| `back_to_back_continuous_enable` | 连续使能读写 | PASS |

仿真日志记录的运行耗时为 2.086 秒。该值来自已保存的执行记录，实际耗时随运行环境变化。

## 覆盖率指标与范围

[coverage.json](results/coverage.json) 保存指标、统计范围与文件信息：

| 类型 | 命中/插桩点 | 覆盖率 |
| --- | --- | --- |
| line | 8/8 | 100.00% |
| branch | 16/16 | 100.00% |
| toggle | 1196/1246 | 95.99% |
| expr | 15/15 | 100.00% |

统计对象为 `async_fifo` 及其已实例化子模块，包括补齐的 `write_to_read_pointer_sync` 依赖。分母是 Verilator 实际插桩点；testbench、PSS 运行时与未实例化的 `load_memory` 不纳入 DUT 指标。

Verilator 默认 `max-width=256` 时，RAM 数组翻转点不计入分母。仅统计原仓库 RTL 时，toggle 为 1090/1140（95.61%），line、branch、expr 均为 100%。完整 DUT 与原仓库 RTL 两种统计范围不可混用。

功能结果与代码覆盖率共同描述所列场景的执行情况；覆盖率指标不代表完整功能验证。

## 产物索引

以下路径相对于 `fifo_v2/`：

| 阶段 | 产物 | 用途 |
| --- | --- | --- |
| 输入 | [request.json](artifacts/request.json)、[SOURCE.json](SOURCE.json) | Spec、完整 DUT/依赖 RTL、工具配置与来源 |
| 元动作分解 | [atomic_decomposition.json](artifacts/atomic_decomposition.json) | 元动作目录 |
| 验证规划 | [verification_plan.json](artifacts/verification_plan.json) | 验证意图与检查目标 |
| 动作组合 | [composition.json](artifacts/composition.json) | 意图到复合动作及顶层组合的映射 |
| Agent 生成 PSS | [fifo.pss](model/fifo.pss) | 测试场景模型 |
| Agent 生成 SV | [tb_async_fifo.sv](tb/tb_async_fifo.sv) | DUT 接口、动作执行、检查与功能结果 |
| 模型工程输出 | [project.json](artifacts/project.json) | 模型返回的完整工程文件 |
| PSSC 中间表示 | [model.ir.yaml](results/model.ir.yaml) | PSS 解析结果 |
| PSSC 生成 SV | [zsp_gen_pkg.sv](generated/zsp_gen_pkg.sv)、[zsp_rt_pkg.sv](generated/zsp_rt_pkg.sv) | 动作实现与运行时包 |
| 功能检查 | [functional.json](results/functional.json) | 通过状态、错误数与各意图结果 |
| 覆盖率 | [coverage.json](results/coverage.json)、[coverage.dat](results/coverage.dat)、[dut.info](results/dut.info) | 指标、原始数据与 LCOV 数据 |
| 工具执行 | [toolchain.json](results/toolchain.json)、[simulate.log](results/simulate.log) | 命令、退出码、时间与日志 |
| 工作流状态 | [report.json](artifacts/report.json)、[smoke_scope.json](artifacts/smoke_scope.json) | 阶段结果、模型调用与复用记录 |
| 执行反馈 | [execution-feedback.json](artifacts/execution-feedback.json) | 代码生成的诊断输入 |

## 生成来源与执行策略

代码生成角色执行了 1 次实时模型调用。元动作分解、验证规划和动作组合三个阶段各复用 1 份已有产物。PSS、SV testbench 和覆盖率辅助 C++ 来自模型返回工程，与落盘文件逐字节核对，未手工改写。

模型语义评审被跳过，`accepted=null`；该状态不属于评审通过。工作流状态为 `outcome=success`，工具执行结果为 `success=true`、`functional_pass=true`。阶段状态与调用范围以 [report.json](artifacts/report.json) 和 [smoke_scope.json](artifacts/smoke_scope.json) 为准。

模型采用显式执行约束：普通读写绑定 `blocking=1`，burst 绑定 `gap_cycles=0`，两个边界非法尝试保留 `blocking=0`。这些绑定避免依赖工具未落实的 soft 默认约束。testbench 提供意图与 burst 参数进度输出，并设有独立 20 ms 仿真 watchdog；[simulate.log](results/simulate.log) 记录实际参数与全部场景的完成状态。

外部 Agent 生成入口支持 `--execution-feedback` 与 `--tool-timeout`。仓库保存其配置与产物，Agent 实现及生成入口脚本不在本仓库中。反馈、输入工程及其他来源保存 SHA-256，自动修复使用最新候选工程。入口输入检查和模型/EDA 执行已验证；此结果不包含全面回归。

## 工具执行检查

| 步骤 | 返回码 | 日志 |
| --- | --- | --- |
| versions_python | 0 | [versions_python.log](results/versions_python.log) |
| versions_pssc | 0 | [versions_pssc.log](results/versions_pssc.log) |
| versions_verilator | 0 | [versions_verilator.log](results/versions_verilator.log) |
| parse | 0 | [parse.log](results/parse.log) |
| generate | 0 | [generate.log](results/generate.log) |
| build | 0 | [build.log](results/build.log) |
| simulate | 0 | [simulate.log](results/simulate.log) |
| coverage | 0 | [coverage.log](results/coverage.log) |

## Makefile 验收

[Makefile](Makefile) 使用仓库内已生成的 SV，完成编译、仿真、功能检查和覆盖率统计。验收结果为 10/10 意图通过、`errors=0`；line、branch、expr 为 100%，toggle 为 1196/1246（95.99%）。该流程不调用模型或重新生成 PSS。

| 验收项 | 结果 |
| --- | --- |
| `make all` | 编译、仿真、功能检查与覆盖率统计成功 |
| 缓存状态下的 `make all` | 复用编译与仿真结果 |
| 显式 `make sim` | 重跑仿真，不重复编译 |
| 随后的 `make coverage` | 使用最新仿真数据 |
| `make clean RUN_DIR=outside-runs` | 拒绝删除 `runs/` 外的目录 |
| `make clean` | 删除选定的运行目录 |

命令、源码哈希和结果见 [Makefile 验收 JSON](evidence/fifo-v2-makefile-validation-20261010.json)；日志与结果保存在 [Makefile 验收 ZIP](evidence/fifo-v2-makefile-validation-20261010.zip)。

## 复现与证据

使用 [README](README.md) 中的 Makefile 指令复现已有 SV 的编译、仿真和覆盖率。需要从 PSS 重新生成 SV 时，按 [Linux 操作指南](LINUX_WALKTHROUGH.md) 执行。代码生成配置与命令见 [SMOKE_COMMANDS.md](SMOKE_COMMANDS.md)，任务输入见 [prompt.md](prompt.md)。

[证据 ZIP](evidence/current-agent-fifo-20261010-evidence.zip) 与 [逐文件清单](evidence/current-agent-fifo-20261010-evidence-manifest.json) 保存原始运行目录结构，清单包含 61 项文件校验。[TRANSFER_MANIFEST.json](TRANSFER_MANIFEST.json) 记录首次传输时的来源、文件对应关系与哈希。文档标准化后，当前仓库文件的校验以根目录 [SHA256SUMS](../SHA256SUMS) 为准；首次传输清单不用于校验修改后的文档。PSS、SV、RTL 与原始结果保持原样。证据文件名中的时间戳用于标识运行记录。
