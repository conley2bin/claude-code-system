# 自动提交命令

分析所有已暂存和未暂存的变更，然后创建格式良好的 git 提交。

## 使用说明：

1. **分析变更：**
   - 运行 `git status` 查看所有已修改和未跟踪的文件
   - 运行 `git diff` 查看已暂存和未暂存的变更
   - 运行 `git log -5 --oneline` 了解项目的提交信息风格

2. **生成提交信息：**
   - 总结变更的性质（feat/fix/refactor/docs/test/perf）
   - 编写简洁的提交标题（最多50字符，祈使语气）
   - 如需要添加详细描述（解释为什么，而不是做了什么）
   - 遵循以下格式：
     ```
     <类型>: <主题>

     <可选的正文>

     🤖 Generated with [Claude Code](https://claude.com/claude-code)

     Co-Authored-By: Claude <noreply@anthropic.com>
     ```

3. **提交类型：**
   - `feat`: 新功能
   - `fix`: Bug 修复
   - `refactor`: 代码重构（不改变行为）
   - `docs`: 文档变更
   - `test`: 测试相关的添加或修改
   - `perf`: 性能改进
   - `chore`: 构建/工具变更

4. **执行提交：**
   - 将所有相关文件添加到暂存区
   - 使用 HEREDOC 格式创建提交
   - 提交后运行 `git status` 验证

## 提交信息示例：

```
feat: 添加基于 BytesIO 的音频流

实现基于内存的音频捕获以消除磁盘 I/O。
录音数据存储在 BytesIO 中并直接流式传输到 Whisper API。

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

```
fix: 使用设备原生采样率进行录音

从硬编码的 16000Hz 改为设备原生的 44100Hz
以避免 USB 麦克风出现"无效采样率"错误。

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

## 重要提示：
- 使用 git diff 读取所有变更，不仅仅是最近的修改
- 确保提交信息准确反映所有变更
- 永远不要提交包含机密信息的文件（.env、credentials.json 等）
- 除非明确要求，否则不要推送
