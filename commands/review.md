# Code Review Command

Perform a comprehensive code review on specified files or recent changes, identifying potential issues and suggesting improvements.

## Instructions:

1. **Identify Review Scope:**
   - If no file specified, review recent uncommitted changes (`git diff`)
   - If file(s) specified, review those specific files
   - Check `git status` to understand context

2. **Review Dimensions:**

   **Code Quality:**
   - Code clarity and readability
   - Naming conventions consistency
   - Function/method length and complexity
   - Code duplication

   **Architecture & Design:**
   - Separation of concerns
   - Single Responsibility Principle
   - Abstraction levels
   - Component coupling
   - No special-case logic in generic classes

   **Correctness & Logic:**
   - Potential bugs or edge cases
   - Error handling patterns
   - Null/undefined checks (should use fail-fast, not defensive programming)
   - Logic flow correctness

   **Performance:**
   - Inefficient algorithms or data structures
   - Unnecessary computations
   - Memory usage concerns

   **Testing & Maintainability:**
   - Test coverage gaps
   - Code maintainability
   - Documentation quality
   - Type safety

3. **Report Format:**

   ```markdown
   ## Code Review Summary

   **Files Reviewed:** [list files]
   **Overall Assessment:** [GOOD/NEEDS IMPROVEMENT/CRITICAL ISSUES]

   ### Critical Issues (Must Fix)
   - [Issue with location and explanation]

   ### Suggestions (Should Consider)
   - [Suggestion with rationale]

   ### Positive Aspects
   - [What's done well]

   ### Detailed Analysis
   [File-by-file breakdown if needed]
   ```

4. **Focus Areas (from CLAUDE.md):**
   - **Fail-Fast Pattern**: Code should fail immediately, not defensively check
   - **No Special Cases**: Use polymorphism instead of type-checking
   - **Single Source of Truth**: No duplicated state/configuration
   - **Minimal Code**: Remove unnecessary instance variables and abstractions
   - **Vectorization**: Prefer array operations over loops

## Review Examples:

### Example 1: Defensive Programming Anti-Pattern
```python
# L ISSUE: Defensive check hides bugs
if self.component and self.component.data:
    result = self.component.process()

#  SUGGESTION: Fail fast
if self.component is None:
    raise RuntimeError("component not initialized")
result = self.component.process()
```

### Example 2: Special-Case Logic Anti-Pattern
```python
# L ISSUE: Type-checking in generic code
if isinstance(obj, SpecificType):
    special_handling(obj)

#  SUGGESTION: Use polymorphism
result = obj.process()  # Let each type implement its own behavior
```

## Important:
- Be constructive and specific in feedback
- Prioritize critical issues over minor style preferences
- Provide actionable suggestions with code examples
- Reference CLAUDE.md principles when applicable
- Consider project-specific architectural patterns
