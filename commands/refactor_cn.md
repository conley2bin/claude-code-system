# 重构命令

遵循 CLAUDE.md 的架构原则执行系统化的代码重构。

## 使用说明：

1. **重构前先理解：**
   - 阅读完整的实现
   - 识别所有 API 契约和外部接口
   - 绘制数据流和依赖关系图
   - 检查相关测试以理解预期行为
   - 在代码库中查找类似模式

2. **重构原则：**

   **来自 CLAUDE.md：**
   - **快速失败**：删除防御式编程，添加显式错误检查
   - **无特殊情况**：用多态替换类型检查
   - **单一真实来源**：消除重复的状态
   - **最小化代码**：删除不必要的抽象
   - **向量化**：用数组操作替换循环
   - **预计算**：将逻辑决策移到初始化阶段

3. **重构目标：**

   **要修复的代码异味：**
   - 对必需依赖的防御性 null/undefined 检查
   - 通用代码中的类型检查（`isinstance`、`typeof`）
   - 跨组件的重复状态
   - 混合关注点的长函数（>50 行）
   - 深层嵌套（>3 层）
   - 不必要的实例变量
   - 组件之间的手动同步

   **架构问题：**
   - 基类中的特定逻辑
   - 特殊情况处理而非多态
   - 违反组件职责
   - 组件之间的紧耦合
   - 复杂逻辑缺少抽象

4. **重构流程：**

   **步骤 1：分析**
   - 识别具体问题
   - 理解为什么当前代码有问题
   - 检查架构约束

   **步骤 2：计划**
   - 设计重构后的结构
   - 确保遵循 CLAUDE.md 原则
   - 识别需要更改的所有位置
   - 计划测试方法

   **步骤 3：执行**
   - 增量进行更改
   - 每次重大更改后测试
   - 验证外部行为未改变

   **步骤 4：验证**
   - 运行所有测试
   - 检查输出是否相同
   - 验证性能影响

5. **报告格式：**

   ```markdown
   ## 重构计划

   **目标：** [文件/组件名称]
   **问题：** [当前代码的问题]
   **违反的原则：** [CLAUDE.md 原则]

   ### 当前状态
   [简要描述 + 代码片段]

   ### 建议的更改
   [重构方法的解释]

   ### 影响
   - 修改的文件：[列表]
   - 受影响的测试：[列表]
   - 破坏性变更：[是/否 + 详情]

   ### 实施
   [分步更改]
   ```

## 重构模式：

### 模式 1：删除防御式编程
```python
# ❌ 之前：防御性检查隐藏 bug
def process(self):
    if self.component and self.component.data:
        if hasattr(self.component, 'process'):
            return self.component.process()
    return None

# ✅ 之后：快速失败
def process(self):
    if self.component is None:
        raise RuntimeError("component not initialized")
    return self.component.process()
```

### 模式 2：用多态替换类型检查
```python
# ❌ 之前：特殊情况逻辑
def handle(self, item):
    if isinstance(item, TypeA):
        return self._handle_type_a(item)
    elif isinstance(item, TypeB):
        return self._handle_type_b(item)

# ✅ 之后：多态分发
def handle(self, item):
    return item.process()  # 每个类型实现自己的 process()
```

### 模式 3：单一真实来源
```python
# ❌ 之前：重复的状态
class Component:
    def __init__(self, parent):
        self.config = parent.config  # 过时的副本

# ✅ 之后：属性访问器
class Component:
    def __init__(self, parent):
        self.parent = parent

    @property
    def config(self):
        """从父对象访问（单一真实来源）。"""
        return self.parent.config
```

### 模式 4：向量化操作
```python
# ❌ 之前：基于循环的处理
results = []
for item in data:
    if condition(item):
        results.append(process(item))

# ✅ 之后：使用掩码向量化
mask = condition_vectorized(data)
results = process_vectorized(data[mask])
```

### 模式 5：预计算逻辑
```python
# ❌ 之前：运行时分支
def process(self, data):
    if self.mode == "fast":
        return self._fast_process(data)
    elif self.mode == "accurate":
        return self._accurate_process(data)

# ✅ 之后：初始化时的函数指针
def __init__(self, mode):
    self._processor = {
        "fast": self._fast_process,
        "accurate": self._accurate_process
    }[mode]

def process(self, data):
    return self._processor(data)
```

## 重构检查清单：

- [ ] 理解了完整的实现和行为
- [ ] 识别了被违反的架构原则
- [ ] 计划了保持外部行为的更改
- [ ] 在适用的地方删除了防御式编程
- [ ] 用多态替换了特殊情况
- [ ] 消除了重复的状态
- [ ] 删除了不必要的代码
- [ ] 测试了行为未改变
- [ ] 所有测试通过
- [ ] 验证了性能（如相关）

## 重要提示：
- 始终保持外部行为，除非明确要更改它
- 彻底测试 - 重构不应破坏功能
- 进行增量更改，而非全面重写
- 遵循代码库中的现有模式
- 积极删除死代码
- 除非复杂度证明有必要，否则不要添加抽象
