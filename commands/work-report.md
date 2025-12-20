---
allowed-tools: Bash(git log:*), Bash(git show:*), Write
argument-hint: <MM.DD-MM.DD> [--author=name] [--lang=zh|en]
description: Generate concise work contribution summary and save to markdown (defaults: conley, Chinese)
---

# Work Report Generator

Generate concise work contribution summary by analyzing git commit history for specified time period, automatically save to markdown file in project root.

## Usage

```bash
/work-report 12.1-12.7
/work-report 12.18-1.2 --author="bin zhao"
/work-report 12.1-12.7 --lang=en
/work-report 12.18-12.19 --author="bin zhao" --lang=en
```

**Required:** Time period in format MM.DD-MM.DD
**Optional:**
- `--author=name` (default: "conley")
- `--lang=zh|en` (default: zh)

## What This Command Does

1. Parses arguments: time period (required), author (default: "conley"), language (default: zh)
2. Parses time period from input (e.g., "12.1-12.7" → 2025-12-01 to 2025-12-07)
3. Analyzes git commit history for specified author in date range
4. Categorizes commits by type (features, refactoring, documentation, maintenance)
5. Extracts key technical contributions and impact
6. Generates concise summary organized by themes (3-5 themes) in specified language
7. Saves summary to `work-report-MMDD-MMDD.md` in project root directory

## Analysis Steps

### 1. Parse Time Period

Input format: `MM.DD-MM.DD` (e.g., `12.1-12.7`, `12.18-1.2`)

**Smart Year Detection:**

1. Get reference year from latest commit:
   ```bash
   git log -1 --format=%cd --date=format:%Y
   ```

2. Parse input dates:
   - Extract start_month.start_day and end_month.end_day
   - End date always uses reference_year
   - Start date year logic:
     * If start_month > end_month → Cross-year range → start_year = reference_year - 1
     * If start_month <= end_month → Same-year range → start_year = reference_year

3. Examples:
   - Latest commit: 2026-01-02, Input: `12.18-1.2`
     → Parse: start_month=12 > end_month=1 (cross-year)
     → Result: 2025-12-18 to 2026-01-02

   - Latest commit: 2025-12-19, Input: `12.1-12.19`
     → Parse: start_month=12 <= end_month=12 (same-year)
     → Result: 2025-12-01 to 2025-12-19

   - Latest commit: 2026-03-15, Input: `2.20-3.15`
     → Parse: start_month=2 < end_month=3 (same-year)
     → Result: 2026-02-20 to 2026-03-15

### 2. Collect Commit Data
```bash
git log --since="YYYY-MM-DD" --until="YYYY-MM-DD" --author="<author>" --format=fuller --stat --no-merges
```
(YYYY-MM-DD calculated from smart year detection above, author defaults to "conley")

### 3. Categorize Contributions

Group commits into themes:
- **Feature Development**: New algorithms, functionality, capabilities
- **Code Quality**: Refactoring, optimization, architecture improvements
- **Documentation**: Technical docs, guides, API documentation
- **Maintenance**: Bug fixes, dependency updates, cleanup

### 3. Extract Technical Impact

For each category, identify:
- Problem solved (what issue was addressed)
- Solution approach (key technical decisions)
- Measurable impact (performance improvements, quality metrics)
- Code contribution (lines added/removed, files modified)

### 4. Generate Concise Summary

**Output Format (Chinese - default):**

```markdown
# 工作汇报 (YYYY.MM.DD - YYYY.MM.DD)

根据git提交记录，[author]在[时间段]共提交X次，工作贡献总结如下：

## 1. [主题一]

[一段精简描述：问题+解决方案+效果，不展示具体参数数值]

## 2. [主题二]

[一段精简描述]

## 3. [主题三]

[一段精简描述]
```

**Output Format (English - with --lang=en):**

```markdown
# Work Report (YYYY.MM.DD - YYYY.MM.DD)

Based on git commit history, [author] made X commits during [period], contributions summarized below:

## 1. [Theme One]

[Concise paragraph: problem + solution + impact, without detailed parameter values]

## 2. [Theme Two]

[Concise paragraph]

## 3. [Theme Three]

[Concise paragraph]
```

### 5. Save to File

Save summary to project root directory with filename:
- Format: `work-report-MMDD-MMDD.md`
- Example: `work-report-1218-0102.md` (for 12.18-1.2)
- Example: `work-report-1201-1219.md` (for 12.1-12.19)

## Guidelines for Concise Output

### DO:
- Group related commits into thematic categories (3-5 themes max)
- Focus on problem solved and solution approach
- Describe impact qualitatively (e.g., "significantly improved", "resolved ambiguity")
- One paragraph per theme (3-5 sentences max)
- Use technical terminology accurately

### DON'T:
- List every commit individually
- Include specific parameter values (e.g., "0.73→0.94", "41%→60%")
- Show detailed code statistics unless specifically requested
- Use verbose explanations or redundant details
- Include commit hashes or timestamps in summary

## Example Analysis Pattern

**Commit Message:** "feat: add PCA multi-initialization alignment for symmetric objects"

**Extract:**
- Category: 特性开发
- Problem: PCA方向歧义导致对称物体对齐失败
- Solution: 4初始化和24初始化模式，自动选择最佳结果
- Impact: 显著提升对称物体对齐精度

**Summary Output (Chinese):**

解决了对称物体因PCA主轴方向歧义导致的对齐失败问题。实现了4初始化模式（轴翻转组合）和24初始化模式（轴排列+翻转组合），通过对每种初始化运行完整ICP并选择最佳结果，显著提升了立方体等对称物体的对齐精度。

## Theme Grouping Strategy

1. **Identify Core Contributions**: What are the 2-4 major technical achievements?
2. **Group Related Commits**: Combine commits that address the same problem area
3. **Create Theme Titles**: Use clear, descriptive titles (e.g., "PCA多初始化对齐算法")
4. **Write Unified Narrative**: Describe the theme as a cohesive solution, not individual commits

## Default Behavior

- Author: "conley" (can override with --author)
- Language: Chinese (can override with --lang=en)
- Time range: Required argument in format MM.DD-MM.DD
- Year detection: Automatic based on latest commit date
- Output file: `work-report-MMDD-MMDD.md` in project root
- Summary format: 3-5 thematic categories with one paragraph each
- Focus: Technical contributions and impact, not process details

## Important Notes

- **Time period is required**: Must provide MM.DD-MM.DD format
- **Smart year detection**: Automatically handles cross-year ranges (e.g., 12.18-1.2)
- **Default author**: "conley" (override with --author="name")
- **Default language**: Chinese (override with --lang=en)
- **Auto-save to file**: Summary saved to project root, also displayed in terminal
- **Concise format**: No detailed parameter values, focus on problem-solution-impact
- **Flexible usage**: Can specify any git author name for team collaboration reports
