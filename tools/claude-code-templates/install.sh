#!/bin/bash
# ============================================================================
# Claude Code Templates 安装脚本
# ============================================================================
#
# 【项目简介】
#   Claude Code Templates - 即用型配置模板库
#   为 Claude Code 提供 100+ 预构建配置，快速增强 AI 开发工作流
#
# 【核心组件】
#   • 🤖 Agents (48+)：领域专家代理（安全审计、性能优化、数据库架构...）
#   • ⚡ Commands (21+)：斜杠命令（/generate-tests、/optimize-bundle...）
#   • 🔌 MCPs：外部服务集成（GitHub、PostgreSQL、Stripe、AWS、OpenAI...）
#   • ⚙️ Settings：配置选项（超时、内存分配、输出格式...）
#   • 🪝 Hooks：自动化触发器（pre-commit 验证、post-completion 动作...）
#
# 【核心优势】
#   • 100+ 即用型模板
#   • MIT 兼容许可
#   • 交互式浏览和安装
#   • 完整技术栈支持
#
# 【典型场景】
#   • 安全审计工作流
#   • React 性能优化
#   • 数据库架构设计
#   • 自动化测试生成
#   • 包体积优化
#   • Pre-commit 自动验证
#
# 【额外工具】
#   • Analytics：实时会话监控
#   • Health Check：安装诊断
#   • Plugin Dashboard：统一插件管理
#   • Conversation Monitor：移动端响应查看（支持 Cloudflare Tunnel）
#
# 【快速安装】
#   交互式：npx claude-code-templates@latest
#   指定组件：npx claude-code-templates@latest --agent=<name> --yes
#
# 【详细文档】
#   GitHub: https://github.com/davila7/claude-code-templates
#   官网: https://aitmpl.com
#   文档: https://docs.aitmpl.com
# ============================================================================

# agents
npx claude-code-templates@latest --agent=development-tools/code-reviewer --yes

# commands
npx claude-code-templates@latest --command=documentation/create-architecture-documentation --yes
npx claude-code-templates@latest --command=git-workflow/commit --yes

# settings
npx claude-code-templates@latest --setting=statusline/context-monitor --yes

# hooks
npx claude-code-templates@latest --hook=automation/simple-notifications --yes

# mcps
npx claude-code-templates@latest --mcp=integration/memory-integration --yes

# plugins
/plugin install ai-ml-toolkit@claude-code-templates

# skills
npx claude-code-templates@latest --skill=development/skill-creator --yes



