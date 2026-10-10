# 本次实战任务说明

请以 inputs/fifo.md 和 inputs/headers/ 为初始信息，为 Spec2Cov 异步 FIFO 建立可执行验证流程。
PSS 固定指 Accellera Portable Test and Stimulus Standard，使用 PSS 3.0 与当前 PSSC 支持的语法。
保持 DUT 默认参数：data_width=32、address_width=16、depth=65536。

1. 元动作分解子 Agent 提取可复用元动作、参数、前后条件、SV 绑定和时钟/复位/握手契约。
2. 验证计划子 Agent 独立产生验证意图、刺激策略、通过判据和覆盖目标。
3. 主 Agent 审核目录与计划的一致性，并把元动作拼接为每条意图对应的一个复合动作。
4. 审核拼接实现后，生成 PSS 原子动作、复合动作、组合全部意图的顶层动作，以及 SV exec body。
5. 使用真实 PSSC 解析和生成，接入原始 DUT，以 Verilator 编译、仿真并收集代码覆盖率。
6. 依据真实错误修复生成工程，保留原计划、检查和 DUT，不硬编码 PASS。

检查实际接受的读写次数、FIFO 数据顺序、复位丢弃、满/空合法阻止、回绕与并发行为。
输入没有规定的严格 CDC 延迟或阻止访问时输出稳定要求，不得自行补为规范要求。
每条意图的通过判据必须落实在可执行检查中，报告保留实际状态与覆盖范围。
每条意图明确 setup、刺激、采样、oracle 和 cleanup，以计数快照后的 delta 判定。
单独复位的测试从已知地址/数据状态起步，分别维护 DUT 指针模型、shadow 有效性和统计计数；
检查器开启新 epoch 不代表 DUT RAM 清零。修复时保留已接受计划和真实失败证据。

这是给人和后续开发使用的任务说明。当前 CLI 读取 inputs/input.json，
实际系统指令是 prompts/roles/ 中从程序导出的六角色快照，不直接加载本文件。


## 最新范围（2026-10-10）
用户指令：不需要测得非常完备，先跑通，跑到能出覆盖率。允许输入完整 RTL 或顶层 RTL。保留真实失败和来源，分别记录新模型生成与既有代码的 EDA 重跑，不把跳过评审当作通过。


## 当前新代码验收要求（2026-10-10）

用户要求当前 Agent 新生成 PSS 和 SV；旧代码回放不能替代本轮生成。只打通生成、仿真及获取覆盖率，不考虑提升覆盖率。成功新代码保存在 runs/current-agent-fifo-20261010；执行诊断保存在 inputs/current-agent-execution-feedback.json，完整模型上下文与返回工程保存在该 run 的 artifacts。
