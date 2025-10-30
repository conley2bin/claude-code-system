# Claude Code Workflows

> AI-Driven Automated Review Workflows

**GitHub Stars**: 3K+ | **License**: MIT | **Status**: Actively Maintained

## Overview

Claude Code Workflows is an open-source collection of "best workflows and configurations" developed based on real-world experience from AI-native startups. The core purpose is to provide automated review systems that reduce manual workload and allow teams to focus on strategic work.

## Core Workflows

### 1. Code Review Workflow

**Features**:
- Dual-loop architecture for automated PR review
- Syntax correctness checking
- Code completeness verification
- Style guide compliance
- Potential bug identification

**Integration**: Supports slash commands and GitHub Actions

### 2. Security Review Workflow

**Features**:
- Based on OWASP Top 10 standards
- Automatic vulnerability detection
- Credential exposure identification
- Security risk classification by severity
- Actionable remediation recommendations

**Integration**: On-demand slash commands and automated GitHub Actions

### 3. Design Review Workflow

**Features**:
- Browser automation via Microsoft Playwright MCP
- UI/UX consistency validation
- Accessibility standards checking
- Design quality assurance

**Purpose**: Prevents visual defects from reaching production environments

## Key Benefits

- ✅ Reduce manual review workload
- ✅ Team focuses on strategic decisions
- ✅ AI handles routine verification tasks
- ✅ Catch issues before production

## Integration Options

### Slash Commands
On-demand manual trigger for immediate review

### GitHub Actions
Automated CI/CD integration for continuous quality checks

### Git Hooks
Local pre-commit validation to catch issues early

## Typical Use Cases

1. **Automated PR Review Process**
   - Systematic code quality checks
   - Consistent review standards
   - Faster review cycles

2. **Pre-commit Security Scanning**
   - Prevent credential leaks
   - Identify vulnerabilities before commit
   - Maintain security standards

3. **Pre-release Visual Issue Detection**
   - UI/UX consistency checks
   - Accessibility validation
   - Design quality assurance

4. **Design Quality Consistency Across Teams**
   - Maintain team design standards
   - Automated design reviews
   - Visual regression detection

## Installation

```bash
# Clone repository
git clone git@github.com:OneRedOak/claude-code-workflows.git
cd claude-code-workflows

# Follow documentation in each workflow directory for configuration
```

## Configuration

Each workflow has detailed documentation in its respective directory:
- `code-review-workflow/` - Code review setup
- `security-review-workflow/` - Security scanning configuration
- `design-review-workflow/` - Design review setup

Refer to individual workflow README files for specific configuration instructions.

## Resources

- **GitHub**: https://github.com/OneRedOak/claude-code-workflows
- **Video Tutorials**: Patrick Ellis YouTube Channel
- **Project Stats**: 3K+ stars, MIT license

## Architecture

The workflows use a dual-loop architecture:
1. **First Loop**: Initial automated analysis
2. **Second Loop**: Refined review with context

This approach ensures thorough coverage while maintaining efficiency.

---

**Last Updated**: 2025-10-30
**Data Source**: https://github.com/OneRedOak/claude-code-workflows
