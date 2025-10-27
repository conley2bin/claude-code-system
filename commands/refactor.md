# Refactor Command

Perform systematic code refactoring following architectural principles from CLAUDE.md.

## Instructions:

1. **Understand Before Refactoring:**
   - Read the complete implementation
   - Identify all API contracts and external interfaces
   - Map out data flow and dependencies
   - Check related tests to understand expected behavior
   - Look for similar patterns in the codebase

2. **Refactoring Principles:**

   **From CLAUDE.md:**
   - **Fail Fast**: Remove defensive programming, add explicit error checks
   - **No Special Cases**: Replace type-checking with polymorphism
   - **Single Source of Truth**: Eliminate duplicated state
   - **Minimal Code**: Remove unnecessary abstractions
   - **Vectorization**: Replace loops with array operations
   - **Precompute**: Move logic decisions to initialization

3. **Refactoring Targets:**

   **Code Smells to Fix:**
   - Defensive null/undefined checks on required dependencies
   - Type-checking (`isinstance`, `typeof`) in generic code
   - Duplicated state across components
   - Long functions (>50 lines) that mix concerns
   - Deep nesting (>3 levels)
   - Unnecessary instance variables
   - Manual synchronization between components

   **Architectural Issues:**
   - Specific logic in base classes
   - Special-case handling instead of polymorphism
   - Violations of component responsibilities
   - Tight coupling between components
   - Missing abstractions for complex logic

4. **Refactoring Process:**

   **Step 1: Analyze**
   - Identify the specific issue
   - Understand why current code is problematic
   - Check architectural constraints

   **Step 2: Plan**
   - Design the refactored structure
   - Ensure it follows CLAUDE.md principles
   - Identify all locations that need changes
   - Plan testing approach

   **Step 3: Execute**
   - Make changes incrementally
   - Test after each significant change
   - Verify external behavior unchanged

   **Step 4: Validate**
   - Run all tests
   - Check that output is identical
   - Verify performance impact

5. **Report Format:**

   ```markdown
   ## Refactoring Plan

   **Target:** [file/component name]
   **Issue:** [what's wrong with current code]
   **Principle Violated:** [CLAUDE.md principle]

   ### Current State
   [Brief description + code snippet]

   ### Proposed Changes
   [Explanation of refactoring approach]

   ### Impact
   - Files modified: [list]
   - Tests affected: [list]
   - Breaking changes: [yes/no + details]

   ### Implementation
   [Step-by-step changes]
   ```

## Refactoring Patterns:

### Pattern 1: Remove Defensive Programming
```python
# ❌ BEFORE: Defensive checks hide bugs
def process(self):
    if self.component and self.component.data:
        if hasattr(self.component, 'process'):
            return self.component.process()
    return None

# ✅ AFTER: Fail fast
def process(self):
    if self.component is None:
        raise RuntimeError("component not initialized")
    return self.component.process()
```

### Pattern 2: Replace Type-Checking with Polymorphism
```python
# ❌ BEFORE: Special-case logic
def handle(self, item):
    if isinstance(item, TypeA):
        return self._handle_type_a(item)
    elif isinstance(item, TypeB):
        return self._handle_type_b(item)

# ✅ AFTER: Polymorphic dispatch
def handle(self, item):
    return item.process()  # Each type implements its own process()
```

### Pattern 3: Single Source of Truth
```python
# ❌ BEFORE: Duplicated state
class Component:
    def __init__(self, parent):
        self.config = parent.config  # Stale copy

# ✅ AFTER: Property accessor
class Component:
    def __init__(self, parent):
        self.parent = parent

    @property
    def config(self):
        """Access from parent (single source of truth)."""
        return self.parent.config
```

### Pattern 4: Vectorize Operations
```python
# ❌ BEFORE: Loop-based processing
results = []
for item in data:
    if condition(item):
        results.append(process(item))

# ✅ AFTER: Vectorized with masks
mask = condition_vectorized(data)
results = process_vectorized(data[mask])
```

### Pattern 5: Precompute Logic
```python
# ❌ BEFORE: Runtime branching
def process(self, data):
    if self.mode == "fast":
        return self._fast_process(data)
    elif self.mode == "accurate":
        return self._accurate_process(data)

# ✅ AFTER: Function pointer at init
def __init__(self, mode):
    self._processor = {
        "fast": self._fast_process,
        "accurate": self._accurate_process
    }[mode]

def process(self, data):
    return self._processor(data)
```

## Refactoring Checklist:

- [ ] Understood complete implementation and behavior
- [ ] Identified architectural principle being violated
- [ ] Planned changes that preserve external behavior
- [ ] Removed defensive programming where applicable
- [ ] Replaced special cases with polymorphism
- [ ] Eliminated duplicated state
- [ ] Removed unnecessary code
- [ ] Tested that behavior is unchanged
- [ ] All tests pass
- [ ] Performance verified (if relevant)

## Important:
- ALWAYS preserve external behavior unless explicitly changing it
- Test thoroughly - refactoring should not break functionality
- Make incremental changes, not wholesale rewrites
- Follow existing patterns in the codebase
- Delete dead code aggressively
- Don't add abstractions unless complexity justifies it
