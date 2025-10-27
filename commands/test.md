# Test Command

Run tests for the project and analyze failures to suggest fixes.

## Instructions:

1. **Identify Test Framework:**
   - Check project for test framework (pytest, unittest, jest, cargo test, go test, etc.)
   - Look for test configuration files (pytest.ini, jest.config.js, etc.)
   - Check package.json scripts or Makefile for test commands

2. **Run Tests:**
   - Execute appropriate test command for the project
   - If specific test file/function provided, run only that test
   - Capture full output including failures and stack traces

3. **Analyze Results:**

   **For Passing Tests:**
   - Report success summary (number of tests passed)
   - Highlight any warnings or deprecations
   - Check test coverage if available

   **For Failing Tests:**
   - Identify root cause of each failure
   - Distinguish between:
     - Logic errors in code
     - Incorrect test expectations
     - Missing dependencies or setup
     - Environment issues
   - Trace failure back to relevant code location

4. **Suggest Fixes:**
   - Provide specific code changes to fix failures
   - Explain WHY the fix addresses the root cause
   - Consider edge cases and potential side effects
   - Suggest additional test cases if coverage gaps found

5. **Report Format:**

   ```markdown
   ## Test Results

   **Framework:** [test framework used]
   **Command:** `[test command executed]`
   **Status:** [PASS/FAIL]
   **Summary:** [X passed, Y failed, Z skipped]

   ### Failures

   #### Test: `test_function_name`
   **Location:** file.py:123
   **Error:** [error message]
   **Root Cause:** [explanation]
   **Suggested Fix:**
   ```[language]
   [code fix]
   ```
   **Rationale:** [why this fixes it]

   ### Warnings
   - [any warnings or deprecations]

   ### Coverage Gaps
   - [untested code paths if identified]
   ```

6. **Common Test Patterns:**
   - **Python**: `pytest`, `python -m pytest`, `python -m unittest`
   - **JavaScript**: `npm test`, `jest`, `vitest`
   - **Rust**: `cargo test`
   - **Go**: `go test ./...`
   - **Java**: `mvn test`, `gradle test`

## Test Execution Examples:

### Example 1: Run all tests
```bash
pytest -v  # Python
npm test   # JavaScript
cargo test # Rust
```

### Example 2: Run specific test
```bash
pytest tests/test_module.py::test_function -v
jest tests/module.test.js -t "test name"
cargo test test_name
```

### Example 3: Run with coverage
```bash
pytest --cov=src tests/
npm test -- --coverage
cargo tarpaulin
```

## Important:
- Always read the full test output to understand failures
- Don't just fix the test - fix the underlying issue
- Consider if test expectations are correct
- Run tests again after suggesting fixes to verify
- Report if tests require specific setup or environment
- Flag flaky tests that pass/fail inconsistently
