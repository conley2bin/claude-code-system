# 测试命令

运行项目测试并分析失败原因以提出修复建议。

## 使用说明：

1. **识别测试框架：**
   - 检查项目的测试框架（pytest、unittest、jest、cargo test、go test 等）
   - 查找测试配置文件（pytest.ini、jest.config.js 等）
   - 检查 package.json 脚本或 Makefile 中的测试命令

2. **运行测试：**
   - 执行项目适当的测试命令
   - 如果提供了特定的测试文件/函数，只运行该测试
   - 捕获完整输出，包括失败和堆栈跟踪

3. **分析结果：**

   **对于通过的测试：**
   - 报告成功摘要（通过的测试数量）
   - 突出显示任何警告或弃用信息
   - 如可用，检查测试覆盖率

   **对于失败的测试：**
   - 识别每个失败的根本原因
   - 区分：
     - 代码中的逻辑错误
     - 不正确的测试预期
     - 缺失的依赖或设置
     - 环境问题
   - 将失败追溯到相关代码位置

4. **提出修复建议：**
   - 提供具体的代码更改来修复失败
   - 解释为什么修复能解决根本原因
   - 考虑边缘情况和潜在副作用
   - 如果发现覆盖率缺口，建议额外的测试用例

5. **报告格式：**

   ```markdown
   ## 测试结果

   **框架：** [使用的测试框架]
   **命令：** `[执行的测试命令]`
   **状态：** [通过/失败]
   **摘要：** [X 通过，Y 失败，Z 跳过]

   ### 失败

   #### 测试：`test_function_name`
   **位置：** file.py:123
   **错误：** [错误信息]
   **根本原因：** [解释]
   **建议修复：**
   ```[语言]
   [代码修复]
   ```
   **理由：** [为什么这能修复]

   ### 警告
   - [任何警告或弃用信息]

   ### 覆盖率缺口
   - [如果识别到，未测试的代码路径]
   ```

6. **常见测试模式：**
   - **Python**: `pytest`, `python -m pytest`, `python -m unittest`
   - **JavaScript**: `npm test`, `jest`, `vitest`
   - **Rust**: `cargo test`
   - **Go**: `go test ./...`
   - **Java**: `mvn test`, `gradle test`

## 测试执行示例：

### 示例 1：运行所有测试
```bash
pytest -v  # Python
npm test   # JavaScript
cargo test # Rust
```

### 示例 2：运行特定测试
```bash
pytest tests/test_module.py::test_function -v
jest tests/module.test.js -t "test name"
cargo test test_name
```

### 示例 3：运行并生成覆盖率
```bash
pytest --cov=src tests/
npm test -- --coverage
cargo tarpaulin
```

## 重要提示：
- 始终阅读完整的测试输出以理解失败
- 不要只修复测试 - 修复底层问题
- 考虑测试预期是否正确
- 建议修复后重新运行测试以验证
- 报告测试是否需要特定的设置或环境
- 标记不稳定的测试（时而通过时而失败）
