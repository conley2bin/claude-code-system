#!/bin/bash
# ============================================================================
# Claude Code Workflows 安装脚本
# ============================================================================
#
# 【项目简介】
#   Claude Code Workflows - AI驱动的自动化审查工作流
#   基于AI原生创业公司实战经验开发的最佳工作流和配置集合
#
# 【核心工作流】
#   • 代码审查工作流 (Code Review)
#     - 双循环架构自动化PR审查
#     - 语法正确性检查
#     - 代码完整性验证
#     - 风格指南遵循
#     - 潜在缺陷识别
#
#   • 安全审查工作流 (Security Review)
#     - 基于OWASP Top 10标准
#     - 漏洞自动检测
#     - 凭证泄露识别
#     - 按严重程度分类安全风险
#     - 提供可操作的修复建议
#
#   • 设计审查工作流 (Design Review)
#     - 使用Microsoft Playwright MCP进行浏览器自动化
#     - UI/UX一致性验证
#     - 可访问性标准检查
#     - 设计质量保障
#
# 【核心优势】
#   • 减少人工审查工作量
#   • 团队专注战略性决策
#   • AI处理常规验证任务
#   • 生产环境前发现问题
#
# 【集成方式】
#   • 斜杠命令: 按需手动触发
#   • GitHub Actions: 自动化CI/CD集成
#   • Git Hooks: 本地提交前验证
#
# 【典型场景】
#   • 自动化PR审查流程
#   • 代码提交前安全扫描
#   • UI发布前视觉问题检测
#   • 团队间设计质量一致性维护
#
# 【快速安装】
git clone git@github.com:OneRedOak/claude-code-workflows.git
#
# 【详细文档】
#   GitHub: https://github.com/OneRedOak/claude-code-workflows
#   视频教程: Patrick Ellis YouTube频道
# ============================================================================

# 安装步骤
echo "正在克隆 Claude Code Workflows 仓库..."
git clone git@github.com:OneRedOak/claude-code-workflows.git

echo ""
echo "✓ 仓库克隆完成!"
echo ""
echo "下一步:"
echo "  1. 进入项目目录: cd claude-code-workflows"
echo "  2. 查看各工作流的README文档"
echo "  3. 根据需要配置工作流:"
echo "     - Code Review Workflow"
echo "     - Security Review Workflow"
echo "     - Design Review Workflow"
echo ""
echo "详细配置请参考各工作流目录中的文档"
