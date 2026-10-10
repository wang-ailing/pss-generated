# PSS Generated

基于 Accellera Portable Test and Stimulus Standard（PSS）的硬件验证示例，包含规格文档、PSS 场景模型、SystemVerilog 测试平台、DUT、仿真结果和覆盖率报告。

验证流程：规格与 RTL → 元动作与验证计划 → PSS 场景组合 → SystemVerilog → Verilator 仿真 → 功能检查与代码覆盖率。

## 示例

| 目录 | 内容 | 运行入口 |
| --- | --- | --- |
| [fifo_v2](fifo_v2/) | 异步 FIFO 验证，包含元动作、验证意图、PSS 模型、SV 测试平台和 Makefile | [构建与运行](fifo_v2/README.md) |
| [fifo](fifo/) | 异步 FIFO 基础模型与参考仿真结果 | [运行说明](fifo/README.md) |

## 快速开始

在 Linux Bash 中执行：

```bash
git clone https://github.com/wang-ailing/pss-generated.git
cd pss-generated
make -C fifo_v2 all
```

Makefile 使用已生成的 SV，按依赖顺序执行编译、仿真、功能检查和覆盖率统计。已有仓库可先执行 `git pull --ff-only origin main`。

## 环境依赖

| 工具 | 要求 |
| --- | --- |
| GNU Make | 4.3 或更新版本 |
| Python | Python 3，覆盖率脚本使用标准库 |
| Verilator / verilator_coverage | 参考环境为 5.052 |
| C++ 工具链 | 支持 Verilator `--binary` 构建 |
| PSSC | 仅重新解析 PSS 或生成 SV 时需要；参考版本为 0.1.0 |

Makefile 的默认工具路径对应参考 Linux 环境。安装位置不同时，可通过 `PYTHON`、`VERILATOR`、`VERILATOR_COVERAGE` 和 `VERILATOR_ROOT` 覆盖；具体参数见 [FIFO v2 README](fifo_v2/README.md)。

## 结果与文档

- [FIFO v2 验证报告](fifo_v2/TEST_REPORT.md)：功能场景、覆盖率指标、统计范围和执行检查。
- [PSS 解析与 SV 生成](fifo_v2/LINUX_WALKTHROUGH.md)：完整工具链命令。
- [结构化产物](fifo_v2/artifacts/)：元动作、验证计划、场景组合及生成配置。
- [参考结果](fifo_v2/results/)：功能检查、覆盖率和工具日志。
- [运行证据](fifo_v2/evidence/)：原始记录与 Makefile 验收数据。
- [SHA256SUMS](SHA256SUMS)：仓库文件校验清单。

Makefile 的新运行输出位于 `fifo_v2/runs/make/results/`。参考结果与新运行结果分别保存在各自目录。

## 来源与许可

Spec 和 RTL 来自 [Spec2Cov](https://github.com/advent-lab/Spec2Cov/tree/98ddc836668c81d116e0bb9a7faf8f56b2c58cdb/data/cvdp_agentic_async_fifo_compute_ram_application)，固定提交为 `98ddc836668c81d116e0bb9a7faf8f56b2c58cdb`。文件来源和 SHA-256 见各示例的 `SOURCE.json`。

补充的指针同步模块来自 NVIDIA CVDP 数据集；原始 LICENSE 和 NOTICE 位于示例的 `dependencies/`。Spec2Cov 来源目录未提供根目录或本设计的 LICENSE，仓库不对这些来源文件另行声明许可。
