# FIFO v2：当前 Agent 新生成结果

2026-10-10，当前 Agent 通过 DeepSeek 新生成 PSS、SV testbench 和覆盖率辅助 C++，随后 PSSC 解析与生成、Verilator 编译与仿真、覆盖率统计均成功。三个前序阶段复用上一轮产物，代码生成角色本次真实调用 1 次。模型语义评审跳过，不表示评审通过。

功能检查：**10/10 意图通过，errors=0**。DUT 覆盖率：line 8/8、branch 16/16、expr 15/15（100%），toggle 1196/1246（95.99%）。本例目标是跑通生成至覆盖率的流程。

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

仿真指南使用现有 Ubuntu 的 PSSC 0.1.0（commit c44287ec3493b62ccbcbbe4505f9dbfb35604e4e）和 Verilator 5.052。无需再次调用模型；其他环境需调整工具安装路径。原始执行日志中的绝对路径保留用于审计。

统计包含已实例化 DUT 及补充依赖，排除 testbench、PSS runtime、未实例化模块；RAM 数组翻转未计入默认插桩范围。完整范围见覆盖率 JSON 和测试报告。

Spec/RTL 来自固定的 Spec2Cov 提交 98ddc836668c81d116e0bb9a7faf8f56b2c58cdb，出处记录在 [SOURCE.json](SOURCE.json)。该来源未发现根目录或本设计的 LICENSE，不对其另行声明许可。补充 CVDP 同步模块的原始 [LICENSE](dependencies/CVDP_LICENSE) 和 [NOTICE](dependencies/CVDP_NOTICE) 一并保留。
