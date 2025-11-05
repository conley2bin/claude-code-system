---
name: audit-compliance
description: "Audit project code compliance with system-level CLAUDE.md principles and generate detailed violation reports"
allowed-tools: Read, Grep, Glob, Edit, Write, Bash, mcp__serena__*, mcp__sequential-thinking__*
argument-hint: [scope] | --focus <domain> | --severity <level> | --interactive | --baseline | --compare
category: workflow
complexity: advanced
mcp-servers: [serena, sequential]
personas: [architect, quality]
---

# /audit-compliance - Code Compliance Audit

## Triggers
- Code compliance verification against CLAUDE.md development principles
- Architecture and code quality assessment based on established standards
- Project-wide principle adherence validation and technical debt identification
- Periodic compliance audits for maintaining coding standards

## Usage
```
/audit-compliance [scope] [--focus <domain>] [--severity critical|warning|all] [--interactive] [--baseline] [--compare]
```

### Execution Modes

#### **Default: Auto-Fix** `/audit-compliance`
- Analyzes code against all CLAUDE.md principles
- **Automatically fixes all safe violations**
- Still requires Claude Code Edit permission per file
- Fast and efficient for trusted fixes
- Shows summary report of what was fixed

#### **Interactive Mode: `--interactive`**
- Analyzes code and finds all violations
- **Shows each violation with before/after diff**
- Asks: "Fix this? (y/n/skip-all)" for each fixable issue
- Applies only user-approved fixes
- Use when you want to review each change carefully

**Example Interactive Flow:**
```
[1/12] src/config/manager.ts:15
Principle: "Avoid Abbreviations" (from CLAUDE.md)

Before:
  const cfg = getConfig()

After:
  const configuration = getConfig()

Fix this? (y/n/skip-all): y
✓ Fixed

[2/12] src/utils/context.ts:23
...
```

## Behavioral Flow
1. **Parse CLAUDE.md**: Read ~/.claude/CLAUDE.md and dynamically extract all principles, patterns, and rules
   - Identify "Required Patterns" (✅ correct examples)
   - Identify "Forbidden Patterns" (❌ anti-patterns to avoid)
   - Extract principle names and descriptions from section headers
2. **Build Checkers**: Dynamically construct validation rules based on parsed principles
   - Create pattern matchers for each required/forbidden pattern
   - Build symbol analyzers for structural principles
   - Configure severity levels based on principle importance
3. **Analyze**: Scan project codebase using Serena MCP symbolic analysis
   - Apply all dynamically-built checkers against codebase
   - Collect violations with file locations and code context
4. **Report**: Generate compliance report organized by CLAUDE.md structure
   - Group violations by CLAUDE.md sections (Core Principles, Architecture, etc.)
   - Quote original principle text from CLAUDE.md for each violation
   - Provide code examples showing violation vs correct pattern
5. **Action**: Optionally auto-fix violations or save baseline for progress tracking

Key behaviors:
- **Dynamic Rule Extraction**: CLAUDE.md is the Single Source of Truth - all rules derived from it
- **Zero Hardcoded Rules**: No predefined categories - everything parsed from CLAUDE.md dynamically
- **Automatic Updates**: CLAUDE.md changes automatically reflect in next audit run
- Multi-persona coordination (architect for architecture, quality for code patterns)
- Serena MCP integration for token-efficient symbolic code analysis
- Sequential MCP for systematic principle-by-principle validation
- Baseline tracking for measuring compliance improvement over time

## MCP Integration
- **Serena MCP**: Mandatory for symbolic code analysis and pattern detection
  - `find_symbol`: Locate symbols for naming and structure validation
  - `search_for_pattern`: Pattern matching for principle violations
  - `find_referencing_symbols`: Dependency and usage analysis
  - `get_symbols_overview`: High-level code structure understanding
- **Sequential MCP**: Auto-activated for complex multi-principle analysis and systematic validation

## Tool Coordination
- **Read**: Load ~/.claude/CLAUDE.md and parse principles for validation rules
- **Serena Tools**: Symbolic code analysis for token-efficient compliance checking
- **Grep/Glob**: Pattern-based violation detection across codebase
- **Write**: Generate compliance report and baseline files
- **Edit**: Auto-fix violations when --fix flag is used
- **TodoWrite**: Track multi-file compliance improvements

## Key Patterns
- **Dynamic Principle Parsing**: Read CLAUDE.md → Parse structure → Extract all principles dynamically
- **Rule Generation**: Principle text → Identify patterns → Build checkers → No hardcoded rules
- **Violation Detection**: Apply dynamic checkers → Pattern matching → Context extraction → Severity assignment
- **Report Generation**: Violations → Group by CLAUDE.md sections → Quote original principles → Recommendations

## Examples

### Default: Auto-Fix Everything
```
/audit-compliance
# Automatically fixes all safe violations
# Shows summary:
#   ✓ Fixed 12 naming violations
#   ✓ Fixed 8 dead code issues
#   ⚠ 5 error handling issues require manual review
#
#   Compliance Score: 78 → 89 (+11)
```

### Interactive: Review Each Change
```
/audit-compliance --interactive
# Shows each violation with before/after diff
# User approves/rejects each fix individually
#
# [1/12] src/config/manager.ts:15
# Principle: "Avoid Abbreviations"
#
# Before:  const cfg = getConfig()
# After:   const configuration = getConfig()
#
# Fix this? (y/n/skip-all): y
# ✓ Fixed
```

### Focus on Specific Domain
```
/audit-compliance --focus naming
# Auto-fixes only naming-related violations

/audit-compliance --focus naming --interactive
# Interactive mode for naming violations only
```

### Specific Directory or File
```
/audit-compliance src/
# Auto-fix violations in src/ directory only

/audit-compliance src/config/manager.ts --interactive
# Interactive fix for single file
```

### Critical Issues Only
```
/audit-compliance --severity critical
# Auto-fix only critical violations

/audit-compliance --severity critical --interactive
# Interactive mode for critical issues only
```

### Baseline and Progress Tracking
```
/audit-compliance --baseline
# Creates compliance baseline at .claude/audit-baseline.json
# Use for tracking improvement over time

/audit-compliance --compare
# Compares current state with baseline
# Shows compliance score delta and improvement metrics
```

### Incremental Audit (Changed Files Only)
```
/audit-compliance --since HEAD~5
# Only audits files changed in last 5 commits
# Fast compliance check for recent changes
```

## How Principles Are Detected (Dynamic Extraction)

The command **does not have hardcoded rules**. Instead, it dynamically extracts principles from CLAUDE.md:

### Parsing Strategy
1. **Section Headers**: Extract from ## and ### markdown headers
   - Example: "### Fail-Fast Principle" → Create "Fail-Fast" checker

2. **Required Patterns**: Code blocks marked with ✅ or "CORRECT" comments
   ```
   // CORRECT: Access from parent
   getSharedResource() { return this.parent.sharedResource }
   ```
   → Build checker to encourage this pattern

3. **Forbidden Patterns**: Code blocks marked with ❌ or "WRONG" comments
   ```
   // WRONG: Silent failure
   if (x == null) { x = defaultValue }
   ```
   → Build checker to detect and flag this anti-pattern

4. **Severity Keywords**: Derive severity from principle language
   - "MUST", "NEVER", "Forbidden" → Critical
   - "SHOULD", "Avoid", "Recommended" → Warning
   - "Consider", "Prefer" → Info

5. **Principle Descriptions**: Extract "Core Concept" text for violation reports
   - Used to explain WHY code violates the principle

### Example: How Fail-Fast Gets Parsed

From CLAUDE.md:
```markdown
### Fail-Fast Principle
**Core Concept**: Expose errors immediately...

**Required Pattern**:
if (dependency == null) {
    throw Error("Required dependency is null")
}

**Forbidden Patterns**:
if (x == null) { x = defaultValue }  // Hides initialization issues
```

Becomes:
- **Checker Name**: "Fail-Fast Principle"
- **Severity**: Critical (contains "must", "forbidden")
- **Pattern Matcher**: Detect `if (...== null) { ... = ...}` patterns
- **Violation Message**: Quote "Core Concept" text
- **Fix Suggestion**: Show Required Pattern from CLAUDE.md

## Report Format

Reports are **dynamically organized** by CLAUDE.md structure. Here's an example:

```markdown
# Code Compliance Audit Report
Generated: 2025-11-05 16:30:00
Scope: Full project
Based on: ~/.claude/CLAUDE.md (SHA: abc123...)

## Summary
- **Compliance Score**: 78/100 (Good)
- **Total Issues**: 42 (across 15 principles from CLAUDE.md)
- 🔴 Critical: 5 (Must fix)
- 🟡 Warning: 28 (Should fix)
- 🔵 Info: 9 (Consider)

## Violations by CLAUDE.md Section

### Core Principles → Fail-Fast Principle (5 violations)

#### 🔴 Silent Failure Detected
**From CLAUDE.md**:
> "Expose errors immediately, fail at the problem source rather than hiding or delaying errors."

**Forbidden Pattern** (from CLAUDE.md):
```
// WRONG: Silent failure
if (x == null) { x = defaultValue }
```

**Your Code** (`src/init.ts:67`):
```typescript
if (dependency == null) {
    dependency = createDefault()  // ❌ Violates Fail-Fast
}
```

**Required Pattern** (from CLAUDE.md):
```
// CORRECT
if (dependency == null) {
    throw Error("Required dependency is null - initialization failed")
}
```

**Quick Fix Available**: No (requires manual review)

---

### Architecture Patterns → Naming Principles (12 violations)

#### 🟡 Cryptic Abbreviation
**From CLAUDE.md**:
> "Avoid abbreviations like cfg, ctx, usr, mgr, svc. Use configuration, context, user, manager, service."

**Your Code**:
- `src/config/manager.ts:15` - Variable `cfg`
- `src/utils/context.ts:23` - Class `UsrMgr`

**Quick Fix**: `/audit-compliance --fix --focus naming`

---

## Recommendations (Derived from CLAUDE.md priorities)

1. **Priority 1**: Fix 5 critical Fail-Fast violations
2. **Priority 2**: Remove 15 Dead Code instances
3. **Priority 3**: Refactor 12 Naming violations

## Next Steps

```bash
/audit-compliance --fix --focus naming  # Auto-fix simple issues
/audit-compliance --baseline            # Track improvement
/audit-compliance --compare             # See progress
```
```

**Note**: The actual report structure mirrors CLAUDE.md's organization. As you update CLAUDE.md, reports automatically adapt.

## Permission Model

### Claude Code Permission Flow

Both modes require Claude Code Edit permission when modifying files:

1. **Default (Auto-Fix)**: `/audit-compliance`
   - Agent applies all safe fixes automatically
   - Claude Code asks for Edit permission per file
   - User can approve/reject at file level

2. **Interactive Mode (`--interactive`)**: `/audit-compliance --interactive`
   - Agent shows each violation with before/after diff
   - User decides: "Fix this? (y/n/skip-all)"
   - After user approves, Claude Code asks for Edit permission per file
   - **Double confirmation**: User approval + Claude Code permission

### What Can Be Auto-Fixed
- ✅ **Naming violations**: `cfg` → `configuration`, `usr` → `user`
- ✅ **Unused imports**: Remove unused import statements
- ✅ **Dead code**: Remove unreferenced functions/variables (with confirmation)
- ❌ **Architecture issues**: Circular dependencies (requires manual refactoring)
- ❌ **Error handling**: Silent failures (requires logic changes)
- ❌ **YAGNI violations**: Premature abstractions (requires judgment)

## Boundaries

**Will:**
- Audit code compliance against system-level CLAUDE.md principles systematically
- **Default to auto-fixing** for immediate value and efficiency
- Show before/after diffs in interactive mode for careful review
- Generate detailed reports showing what was fixed and what needs manual review
- Support baseline tracking for measuring compliance improvement over time
- Auto-fix simple violations (naming, imports, dead code) safely
- Always respect Claude Code's permission system for file modifications

**Will Not:**
- Modify code without Claude Code Edit permission (always required)
- Override project-specific conventions that differ from CLAUDE.md
- Audit external dependencies or third-party library code
- Perform runtime analysis or execute code for validation
- Apply risky fixes that could break functionality (architecture, logic changes)
