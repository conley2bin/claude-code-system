# Custom Slash Commands

This directory contains custom slash commands for the claude-code-system project.

## Commands

### `/audit-compliance`

Audit project code compliance with system-level `~/.claude/CLAUDE.md` principles and generate detailed violation reports.

**Features**:
- 🔍 Dynamically extracts all principles from `~/.claude/CLAUDE.md` (zero hardcoded rules)
- ✅ Two modes: Auto-fix (default) and Interactive (`--interactive`)
- 🎯 Single Source of Truth: CLAUDE.md changes automatically reflect in audits
- 📊 Baseline tracking for measuring compliance improvement

**Usage**:
```bash
# Auto-fix all safe violations
/audit-compliance

# Interactive mode: review each change
/audit-compliance --interactive

# Focus on specific domain
/audit-compliance --focus naming --interactive

# Check specific directory
/audit-compliance src/ --interactive
```

**Installation**:
```bash
# Copy to system commands directory
cp commands/audit-compliance.md ~/.claude/commands/

# Verify
ls ~/.claude/commands/audit-compliance.md
```

## How Principles Are Detected

The command dynamically parses `~/.claude/CLAUDE.md` to extract:
- Section headers (### Fail-Fast Principle → checker)
- Required Patterns (✅ CORRECT → encourage)
- Forbidden Patterns (❌ WRONG → detect)
- Severity keywords (MUST/NEVER → critical, SHOULD/AVOID → warning)

As you update CLAUDE.md, the audit rules automatically update. No need to maintain two places.

## Development

To modify or extend these commands:

1. Edit the `.md` file in this directory
2. Test by running the command
3. Copy to `~/.claude/commands/` to use globally

## Philosophy

These commands follow the CLAUDE.md principles:
- **Single Source of Truth**: CLAUDE.md is the authority
- **Dynamic Over Static**: Parse and generate, don't hardcode
- **Fail-Fast**: Detect violations immediately
- **Minimal Code**: Leverage existing tools (Serena MCP, Sequential MCP)
