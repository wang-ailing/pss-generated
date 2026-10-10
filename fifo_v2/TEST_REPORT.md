# 当前 Agent 新生成 FIFO：Linux 实战报告

日期：2026-10-10（北京时间）。

**当前 Agent 新生成的 PSS/SV 已跑通，且产出真实覆盖率。** 本轮通过配置的 DeepSeek `deepseek-v4-pro` 执行代码生成角色 1 次，沿用当前 Agent 之前的元动作目录、验证计划、拼接方案及失败候选作为上下文。PSS、SV testbench 和覆盖率辅助 C++ 是本轮模型返回文件，未手工改写。随后 PSSC 解析与生成、Verilator 编译与仿真、覆盖率统计全部通过。仿真日志记录 walltime 2.086 秒。

本轮的三个较早阶段各复用 1 次，代码生成阶段没有复用旧输出。模型语义评审按用户“只打通，不提高覆盖率”的范围跳过，accepted 为 null，不能视作评审通过。本次成功与此前旧代码回放区分保存。

## 当前代码与产物位置

Linux 根目录：`/home/pssprobe/spec2cov_fifo_practice/runs/current-agent-fifo-20261010`。

| 阶段 | 本实战文件夹内的产物 | 本次来源 |
| --- | --- | --- |
| 输入 | [request.json](artifacts/request.json)、[SOURCE.json](SOURCE.json) | Spec、完整六份 RTL 内容、工具配置与来源 |
| 元动作 | [atomic_decomposition.json](artifacts/atomic_decomposition.json) | 沿用前一阶段 |
| 验证计划 | [verification_plan.json](artifacts/verification_plan.json) | 沿用前一阶段 |
| 拼接方案 | [composition.json](artifacts/composition.json) | 沿用前一阶段 |
| Agent 生成 PSS | [model/fifo.pss](model/fifo.pss) | 本轮真实 DeepSeek 新输出 |
| Agent 生成 SV | [tb/tb_async_fifo.sv](tb/tb_async_fifo.sv) | 本轮真实 DeepSeek 新输出，连接 DUT、执行和检查 |
| 模型返回完整工程 | [project.json](artifacts/project.json) | 与实际源码逐字节核对 |
| PSSC 解析 | [model.ir.yaml](results/model.ir.yaml) | 本轮工具执行 |
| PSSC 生成 SV | [zsp_gen_pkg.sv](generated/zsp_gen_pkg.sv)、[zsp_rt_pkg.sv](generated/zsp_rt_pkg.sv) | 由本轮 PSS 编译生成 |
| 功能结果 | [functional.json](results/functional.json) | 本轮新仿真 |
| 覆盖率 | [coverage.json](results/coverage.json)、[coverage.dat](results/coverage.dat)、[dut.info](results/dut.info) | 本轮新仿真和统计 |
| 工具轨迹 | [toolchain.json](results/toolchain.json)、[simulate.log](results/simulate.log) | 实际命令、时间、退出码与日志 |
| 调用与复用记录 | [smoke_scope.json](artifacts/smoke_scope.json)、[report.json](artifacts/report.json) | outcome=success，codegen live role invocations=1 |

## 测试与结果

32 bit 数据、16 bit 地址、65536 深度、种子 42。功能结果为 pass=true、errors=0，十条意图均通过：

- `basic_ordered_write_read`：通过。
- `full_detection_and_extra_write_blocking`：通过。
- `empty_detection_and_read_blocking`：通过。
- `concurrent_producer_consumer`：通过。
- `write_domain_reset_with_nonzero_read_pointer`：通过。
- `read_domain_reset_with_nonzero_read_pointer`：通过。
- `coordinated_reset_flush`：通过。
- `near_full_boundary_transition`：通过。
- `pointer_synchronization_empty_full_flags`：通过。
- `back_to_back_continuous_enable`：通过。

| 类型 | 命中/插桩点 | 百分比 |
| --- | --- | --- |
| line | 8/8 | 100.00% |
| branch | 16/16 | 100.00% |
| toggle | 1196/1246 | 95.99% |
| expr | 15/15 | 100.00% |

统计 `async_fifo` 和其已实例化子模块。分母是 Verilator 插桩点；testbench、PSS 运行时及未实例化的 load_memory 不计入 DUT。默认 max-width 256 时 RAM 数组翻转不计入分母。原仓库 RTL 单独统计翻转 1090/1140（95.61%），其余三类 100%；完整 DUT 翻转含补齐的 write_to_read_pointer_sync 依赖。DUT 六份源码执行前后哈希相同。源码与依赖出处、许可证见 SOURCE.json。

按用户范围，不继续提高覆盖率，也不将本次结果解释成完整功能验证。本轮 functional.json 没有 observations 字段；此前回放中的写读计数不能套用到本轮。

## 打通了什么

前一候选 PSS 使用 soft blocking/gap 默认约束；PSSC 生成的 SV 中相关约束为空。字数固定而间隔仍可取 0..100000，阻塞模式也未确定，导致长时间运行。该生成机制已由文件核实，前次随机值没有记录。

本轮将具体诊断与 previous_project 交给当前代码生成 Agent。新 PSS 对普通读写显式绑定 blocking=1、burst gap_cycles=0，两个边界非法尝试保留 blocking=0；SV 加入意图和 burst 参数进度，以及独立 20 ms watchdog。新仿真日志确认实际参数为 blocking=1、gap_cycles=0，并完成十个场景。

案例入口新增 `--execution-feedback` 和 `--tool-timeout`；反馈、前一项目及其他来源均保存 SHA，后续自动修复优先使用最新候选。`--check-only` 与本轮真实模型/EDA 运行已验证；没有重新执行全面回归。

## 工具执行

| 步骤 | 返回码 | 日志 |
| --- | --- | --- |
| versions_python | 0 | [results/versions_python.log](results/versions_python.log) |
| versions_pssc | 0 | [results/versions_pssc.log](results/versions_pssc.log) |
| versions_verilator | 0 | [results/versions_verilator.log](results/versions_verilator.log) |
| parse | 0 | [results/parse.log](results/parse.log) |
| generate | 0 | [results/generate.log](results/generate.log) |
| build | 0 | [results/build.log](results/build.log) |
| simulate | 0 | [results/simulate.log](results/simulate.log) |
| coverage | 0 | [results/coverage.log](results/coverage.log) |

工具为用户 PSSC main 对应的 commit c44287ec3493b62ccbcbbe4505f9dbfb35604e4e（PSSC 0.1.0）与 Verilator 5.052。全部 8 步返回 0，report outcome=success，toolchain success=true，functional_pass=true。

## Linux 操作与保存的指令

直接按 [LINUX_WALKTHROUGH.md](LINUX_WALKTHROUGH.md) 的 1～8 步操作：新建练习目录，解析 PSS，生成 SV，编译，仿真，检查功能结果，再导出覆盖率。不需要再次调用模型或配置密钥。

真实代码生成命令见 [SMOKE_COMMANDS.md](SMOKE_COMMANDS.md) 的 current-agent 章节。专用反馈位于 [current-agent-execution-feedback.json](artifacts/execution-feedback.json)，完整输入、目录、计划、拼接方案及返回工程位于本轮 artifacts。原始用户目标见 [prompt.md](prompt.md)。

公开证据包：[原始证据 ZIP](evidence/current-agent-fifo-20261010-evidence.zip)和[原始清单](evidence/current-agent-fifo-20261010-evidence-manifest.json)，逐文件校验 61 项。ZIP 内保留原始 Linux 运行目录结构。

当前仓库目录是 fifo_v2；[TRANSFER_MANIFEST.json](TRANSFER_MANIFEST.json)保存逐字节复制文件与原产物的对应关系。文档路径已适配仓库。上一轮回放结果保留在 [fifo](../fifo/README.md)。
