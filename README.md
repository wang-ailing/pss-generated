# PSS Generated

## fifo_v2：当前 Agent 新生成并跑通

本次 DeepSeek 新生成 PSS 和 SV，随后真实执行 PSSC 与 Verilator，10/10 意图通过、错误数 0。line/branch/expr 覆盖率 100%，toggle 95.99%。

- [fifo_v2 产物目录](fifo_v2/)
- [PSS](fifo_v2/model/fifo.pss) · [SV](fifo_v2/tb/tb_async_fifo.sv)
- [编译、仿真和覆盖率指令](fifo_v2/README.md)
- [测试报告及各阶段产物](fifo_v2/TEST_REPORT.md)

## fifo：上一轮已有代码回放结果

这里保存异步 FIFO 的 Spec、PSS 模型、SystemVerilog 测试平台、PSSC 生成的 SV 和 DUT 源码。

示例已在 Linux 上完成 PSS 解析、SV 生成、Verilator 编译、仿真和覆盖率统计。该次运行复用了之前 DeepSeek 生成的 PSS/SV，并重新执行全部 EDA 步骤。

- [Spec](fifo/docs/fifo.md)
- [PSS 模型](fifo/model/fifo.pss)
- [SV 测试平台](fifo/tb/tb_async_fifo.sv)
- [PSSC 生成的 SV](fifo/generated/zsp_gen_pkg.sv)
- [DUT 源码](fifo/rtl/)
- [Linux 仿真和覆盖率步骤](fifo/README.md)

已有运行的 10 条测试意图全部通过；DUT 的行、分支、表达式覆盖率为 100%，翻转覆盖率为 98.555377%。完整统计见 [coverage.json](fifo/reference_results/coverage.json)，功能检查见 [functional.json](fifo/reference_results/functional.json)。

Spec 和 RTL 来自 Spec2Cov，固定提交为 `98ddc836668c81d116e0bb9a7faf8f56b2c58cdb`。源码来源、补充依赖及其许可说明保存在 [SOURCE.json](fifo/SOURCE.json) 和 [dependencies](fifo/dependencies/) 中；首次上传文件的传输哈希见 [TRANSFER_MANIFEST.json](fifo/TRANSFER_MANIFEST.json)，当前文件哈希见 [SHA256SUMS](SHA256SUMS)。
