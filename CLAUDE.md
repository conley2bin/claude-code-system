# CLAUDE.md - System-Level Development Guidelines

## AI Assistant Principles

### Professional Rigor and Accuracy
- **Think carefully before responding**: Take time to fully understand the question's context and implications
- **Professional and rigorous answers only**: Every response must be technically accurate and well-reasoned
- **Zero tolerance for errors**: If uncertain, investigate and verify rather than guessing
- **Acknowledge limitations**: Explicitly state when lacking sufficient information to provide a definitive answer
- **Verify before claiming**: Test hypotheses, read actual code, check documentation - never assume

**Key behaviors:**
- Use reasoning/thinking process before providing answers to complex questions
- Cross-reference multiple sources when validating technical details
- Prefer "I need to verify X before answering" over potentially incorrect immediate responses
- When multiple interpretations exist, present all valid options with their trade-offs

## Build Commands
<!-- Replace with your project's build and test commands -->
- Install: `[your install command]`
- Run tests: `[your test command]`
- Build: `[your build command]`
- Run with options: `[example with configuration overrides]`

## Development Philosophy

### Fail Fast - No Defensive Programming
This is research/development code where exposing bugs immediately is critical. NEVER hide errors with fallbacks.

❌ FORBIDDEN:
```python
if x is None: x = default_value  # NO!
try: ... except: use_fallback   # NO!
value = x if x else fallback     # NO!
if hasattr(obj, 'attr'): ...     # NO! Let AttributeError expose bugs
```

✅ REQUIRED:
```python
if x is None:
    raise RuntimeError("x is None - this indicates initialization bug")
# Let code crash immediately to expose problems at their source
```

**Defensive Programming Clarification:**
- ✅ DO check for external failures (hardware, file I/O, network)
- ❌ DON'T check if your own dependencies are None
- ❌ DON'T add fallbacks for your own logic errors
- If a dependency is required at init, it should NEVER be None later

### Think Like a Scientist/Engineer
Write elegant, clear code, not defensive business logic.

❌ WRONG - Defensive mindset:
```python
if self.config_option_enabled:
    if self.data.shape[1] > 0:
        result = self.process_data()
        # ... 20 more lines of branching
```

✅ CORRECT - Scientific/engineering mindset:
```python
# Use vectorization, masks, and precomputation
processed_data[active_mask] = self._process_with_config(data[active_mask])
```

**Key Principles:**
1. **Masking > Branching**: Boolean masks replace conditional logic - use array operations instead of if/else chains
2. **Precompute Everything**: Runtime should be pure math - move all logic decisions to initialization
3. **Vectorize Operations**: Think in tensors/arrays, not loops - leverage SIMD and GPU parallelism
4. **Function Pointers**: Assign functions during init, not runtime branching - use dispatch tables and callbacks

### Fail-Fast for Required Dependencies
When a component requires something to function, NEVER check if it exists before using it.

❌ WRONG - Defensive check that silently fails:
```python
if self.required_component:
    if self.required_data:  # Silent failure if None!
        result = self.process(self.required_data)
```

✅ CORRECT - Fail fast if required dependency is missing:
```python
# Component MUST exist - fail if not initialized properly
if self.required_component is None:
    raise RuntimeError("required_component is None - initialization failed")
result = self.required_component.process(self.required_data)
```

**Key principle:** If something is required for correct operation, it should NEVER be None after initialization. Don't check - just use it and let it fail fast if there's a bug.

### Issue Resolution Protocol - CRITICAL
The AI must NEVER claim an issue is resolved without explicit user confirmation, especially in long-running troubleshooting tasks.

❌ WRONG - Premature resolution claims:
```
"The issue has been fixed by updating the configuration."
"This should resolve the problem."
"The bug is now resolved."
```

✅ CORRECT - Seek explicit confirmation:
```
"I've implemented a potential fix. Please test and confirm if this resolves the issue."
"The changes are complete. Can you verify the problem is fixed?"
"Please run the test and let me know if the issue persists."
```

**Key principle:** Only the user can confirm that an issue is truly resolved. The AI provides fixes and requests verification, but never assumes success without user confirmation.

### Debugging Protocol - CRITICAL
When investigating issues:
1. **Test thoroughly** - Run the actual failing scenario, don't just assume fixes work
2. **Check end-to-end** - Verify the complete workflow, not just individual components
3. **Wait for user feedback** - Always ask the user to confirm if the issue is resolved
4. **Document actual behavior** - Report what actually happens, not what should happen
5. **Never claim success** - If testing shows intermittent results, crashes, or hangs, report the actual behavior
6. **Distinguish between partial progress and full resolution** - Component initialization ≠ working system

### Documentation Development Protocol - CRITICAL
When writing or updating documentation, follow these principles to ensure reader-oriented, accurate, and maintainable content.

#### Motivation-First Writing
**Always explain WHY before HOW**:
- **Problem context**: Start with the actual pain points users face
- **Solution rationale**: Explain why the proposed approach solves those problems
- **Trade-offs**: Be explicit about advantages and limitations of different approaches

❌ WRONG - Commands without context:
```markdown
## Feature X
Use `--flag` to enable:
```

✅ CORRECT - Problem-motivated explanation:
```markdown
## The Problem
Traditional approach has these issues:
- Pain point 1
- Pain point 2

## The Solution: Feature X
Feature X solves this by...
```

#### Architecture Explanation Requirements
**Explain non-standard patterns and "magic" behavior**:
- **Magic parameters**: Explain what special values actually do under the hood
- **Integration points**: Reference related systems and how they interact
- **Implementation details**: How mechanisms work, what triggers behaviors

#### Fact-Checking and Code Validation
**Every technical detail must be verified against actual implementation**:
- **Parameter names**: Verify against current configuration files
- **Default values**: Check actual defaults, not assumed values
- **Command syntax**: Test all example commands to ensure they work
- **File paths**: Verify file names and locations

**Validation process**:
1. **Read actual code**: Check implementations, don't assume behavior
2. **Verify configuration**: Look at actual config files for current parameter names and defaults
3. **Test commands**: Run examples to confirm syntax and behavior
4. **Cross-reference**: Link to related documentation appropriately

#### Reader-Oriented Structure
**Organize around user scenarios, not implementation structure**:
- **Use-case scenarios**: Structure around different user contexts
- **Progressive disclosure**: Basic usage first, advanced configuration later
- **Practical examples**: Real commands users can copy-paste and modify

#### Conciseness vs Completeness Balance
**Be concise but not at the expense of essential context**:
- **Essential motivation**: Always include problem context and solution rationale
- **Sufficient detail**: Explain non-obvious design decisions and system interactions
- **Descriptive flow**: Use paragraphs to explain concepts, not just bullet points
- **Eliminate fluff**: Remove generic "best practices" sections that add no real value

**Conciseness techniques**:
- Use active voice and direct language
- Structure with clear headings for scanning
- Provide complete examples rather than explaining every option
- Link to related documentation instead of duplicating

#### Common Documentation Anti-Patterns to Avoid
❌ **Commands without context**: Listing commands without explaining the underlying problem
❌ **Magic without explanation**: Using special syntax without explaining how it works
❌ **Outdated examples**: Including examples that don't match current parameter names
❌ **Implementation assumption**: Assuming readers understand non-standard architectural patterns
❌ **Generic advice**: Including "best practices" sections with no actionable specifics
❌ **Missing integration**: Failing to reference related systems and documentation

#### Documentation Quality Gates
Before submitting documentation updates:
1. **Code validation**: Every parameter name, command, and example verified against current code
2. **Motivation check**: Problem context clearly explained before presenting solutions
3. **Architecture explanation**: Any non-standard or "magic" behavior clearly explained
4. **Cross-references**: Appropriate links to related documentation and systems
5. **Practical completeness**: Users can accomplish their goals using only the provided information

## Code Style
<!-- Customize based on your language and conventions -->
- Imports: Standard library → third-party → local
- Use structured logging, not print statements
- Include assertions for critical invariants (e.g., shape assertions for tensors/arrays)
- Prefer clear, explicit code over clever tricks
- Prefer vectorized operations over loops
- Use type hints/annotations where applicable

### Git Commit Messages
- **ALWAYS run `git diff` and read the entire diff before writing commit message**
- Commit message must accurately reflect ALL changes, not just the most recent fix
- Include all file changes, config updates, and code modifications in the message
- Follow conventional commit format if applicable

### Precommit Hook Handling
- If a file is modified by precommit hook, run `git add` on it again before retrying the commit
- Precommit modifications should be included in the same commit, not separate ones

## Implementation Guidelines

### Study Before Modifying
Before changing any component:
1. **Understand existing abstractions**: Use search tools to find similar patterns
2. **Follow established patterns**: Don't reinvent what already exists
3. **Check naming conventions**: Maintain consistency with existing code
4. **Read related tests**: Understand expected behavior

### Respect Component Responsibilities
Each component has a specific purpose. Don't violate separation of concerns:
<!-- Customize based on your architecture -->
- **Component A**: Responsibility A
- **Component B**: Responsibility B
- **Component C**: Responsibility C

**Key principle:** Keep responsibilities clearly separated. If a component needs functionality from another domain, delegate to the appropriate component.

### Architectural Principles - Abstraction and Polymorphism

#### Never Put Specific Logic in Base Classes
- **NEVER put task/type-specific logic in base classes or general components**
- Base classes should not have knowledge of specific implementations
- Always think abstractly - if you find yourself checking for specific attributes, you're violating the abstraction
- When implementing fixes, choose the most general solution that works for all implementations
- Example: Process ALL items uniformly rather than checking for specific item types

#### No Special Cases - Use Polymorphism
**This is a core architectural principle that applies to the entire codebase.**

The project uses polymorphism extensively through abstract interfaces:
<!-- Customize based on your abstractions -->
- **Interface/Base Class 1**: Different implementations for different use cases
- **Interface/Base Class 2**: Pluggable behaviors through common interface

**NEVER write special-case logic in generic classes:**
- ❌ WRONG: `if isinstance(obj, SpecificType): special_handling()`
- ❌ WRONG: `if name == "SpecificCase": different_logic()`
- ❌ WRONG: `if self.type == "variant": alternative_path()`
- ✅ CORRECT: Query the object for its capabilities via interface methods
- ✅ CORRECT: Let each implementation provide its own behavior through overrides

**AI Development Warning:**
As an AI assistant, you have a tendency to propose quick workarounds and special cases instead of elegant architectural solutions. Before implementing ANY solution, ask yourself:
1. Am I adding an "if type == X" check anywhere?
2. Am I hardcoding knowledge about specific implementations in generic code?
3. Could this behavior be exposed through an interface method instead?
4. Would adding a new type require modifying generic code?

If any answer is "yes", STOP and redesign using proper polymorphism.

**Key Principle**: Generic code should NEVER know about specific implementations. It should only know about interfaces. This ensures that adding new types requires zero changes to existing generic code.

### Write Minimal Code
- Don't create unnecessary instance variables
- Use existing abstractions rather than reimplementing
- If you're writing more than necessary, you're probably doing it wrong
- Delete dead code aggressively

### Validate Understanding First
Before implementing:
1. Articulate what each component's responsibility is
2. Ensure changes align with the component's purpose
3. If unsure, study how existing features use the abstraction

## AI Development Workflow

<!-- Optional: Structured workflow for managing complex projects -->

This project uses a structured development workflow for managing development tasks.

### Task Organization

**Task Categories (by prefix):**
<!-- Customize based on your project's task taxonomy -->
- `meta_*`: Workflow, tooling, and project organization
- `refactor_*`: Code quality improvements and architectural enhancements
- `feat_*`: New functionality and API enhancements
- `fix_*`: Bug fixes and issue resolution
- `docs_*`: Documentation improvements
- `perf_*`: Performance optimization
- `test_*`: Test coverage and quality

**File Structure:**
<!-- Customize based on your project structure -->
```
tasks/
├── meta-001-workflow-setup.md
├── refactor-001-architecture.md
├── feat-001-new-feature.md
└── ...
```

### 3-Phase Development Process

**Phase 1: Ultrathink & Context Gathering**
- Read task requirements carefully
- Use sequential thinking to understand problem context and scope
- Consider architectural constraints (component boundaries, initialization patterns, established principles)
- Analyze domain-specific implications (e.g., for performance/research tasks: physics, algorithms, system behavior)
- Expand brief requirements into detailed PRD/architecture document

**Phase 2: Implementation Planning**
- Create detailed step-by-step implementation plan
- Identify which components will be modified
- Check for architectural principle violations (special cases, abstraction leaks, responsibility violations)
- Plan testing approach using existing test commands
- Request explicit user approval before proceeding

**Phase 3: Implementation & Validation**
- Execute plan methodically using TodoWrite for progress tracking
- Maintain component responsibility separation
- Follow single source of truth principles
- Test thoroughly with project's test commands
- Request user review and explicit confirmation of issue resolution
- Update project tracking (e.g., ROADMAP.md) with completion status

### Workflow Rules

1. **One item per session**: Focus on single task for quality
2. **No premature resolution claims**: Always request user confirmation
3. **Respect architectural constraints**: Follow established patterns and initialization sequences
4. **Test thoroughly**: Use existing test commands before claiming completion
5. **Update tracking**: Mark tasks complete and update project tracking documents

### Quality Gates

- All code must pass existing test commands
- Component responsibilities must be respected
- Initialization patterns must be maintained (if applicable)
- No defensive programming allowed (fail fast principle)
- User must explicitly confirm issue resolution
- Git commits must reflect ALL changes made

## Component Architecture

<!-- Customize based on your architecture patterns -->

### Single Source of Truth
- Each piece of state/configuration should have exactly one authoritative source
- Other components access via getters/properties, never duplicate
- No manual synchronization needed
- Properties/getters provide clean access without coupling

**Example:**
```python
class Component:
    @property
    def shared_resource(self):
        """Access from parent (single source of truth)."""
        return self.parent.shared_resource
```

### Component Development Guidelines

When creating new components, follow these standards:

#### Component Structure Pattern
```python
class MyComponent:
    """
    Component description and responsibilities.

    This component provides functionality to:
    - Specific responsibility 1
    - Specific responsibility 2
    """

    def __init__(self, parent):
        """Initialize with parent reference."""
        self.parent = parent
        self._initialized = False

    @property
    def shared_dependency(self):
        """Access from parent (single source of truth)."""
        return self.parent.shared_dependency

    def initialize(self):
        """Initialize component."""
        # Setup logic
        self._initialized = True
```

#### Property Accessor Standards

**✅ ALWAYS use property decorators for parent access:**
```python
@property
def shared_component(self):
    """Access from parent (single source of truth)."""
    return self.parent.shared_component
```

**❌ NEVER store direct references that can get stale:**
```python
def __init__(self, parent):
    # WRONG - creates coupling and staleness risk
    self.shared = parent.shared
```

### Complexity-Justified Separation

**Key Principle**: Different complexity levels warrant different architectural approaches - avoid forcing consistency where it would harm maintainability.

**When to extract components:**
- Significant complexity difference (e.g., 3:1 line count ratio or higher)
- Complex multi-component coordination/orchestration
- Clear single responsibility emerges from complexity
- Improves testability and debugging

**When NOT to extract:**
- Simple, straightforward logic (under ~50 lines)
- No orchestration complexity
- Extraction would create unnecessary indirection
- Logic is cohesive with its current location

**Example**: A 40-line simple input handler might stay inline, while a 120+ line orchestration module with multiple component coordination should be extracted into its own component.

This prevents both:
- **Over-abstraction**: Unnecessary indirection for simple logic
- **Under-abstraction**: Bloated classes with complex embedded logic

## Critical Lessons - Optimization and Refactoring

### ALWAYS Understand Before Optimizing
When asked to optimize or refactor code, FIRST understand what it does:
- Read the complete implementation and understand its behavior
- Identify all API contracts and external interfaces
- Map out the data flow and dependencies
- Only then plan optimizations that preserve exact behavior

### NEVER Hardcode Dynamic Data
If the system can discover information dynamically, use that mechanism:
- Query configuration systems for available components
- Use existing registries and discovery mechanisms
- Avoid duplicating knowledge that exists elsewhere

### Respect Exact Requirements
When asked to "optimize without changing logic":
- Preserve ALL aspects of the output (structure, format, meaning)
- Only change the internal implementation
- Test that outputs remain identical

### Discourage Backward Compatibility in Research Code
Research/development code should break fast and embrace current best practices:
- Don't bloat codebase with legacy support
- Clean breaks are preferred over compatibility layers
- Focus on maintaining a modern, clean codebase

### Query Existing Systems for Truth
- Don't maintain separate lists of components/features
- Use the system's own discovery mechanisms
- Single source of truth principle applies everywhere

---
