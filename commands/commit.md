---
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*), Bash(git diff:*), Bash(git log:*)
argument-hint: [message] | --amend
description: Create well-formatted commits with conventional commit format
---

# Smart Git Commit

CRITICAL: NEVER create commits automatically.
CRITICAL: NEVER modify the staging area when files are already staged.

ONLY commit when:
1. User explicitly runs /commit command
2. User explicitly requests "commit" or "create a commit"

Default behavior: Do not commit. If uncertain, do not commit.

When files are already staged: Commit only what's staged. DO NOT add other files.

---

Create well-formatted commit: $ARGUMENTS

## Current Repository State

- Git status: !`git status --porcelain`
- Current branch: !`git branch --show-current`
- Staged changes: !`git diff --cached --stat`
- Unstaged changes: !`git diff --stat`
- Recent commits: !`git log --oneline -5 2>/dev/null || echo "No commits yet"`

## What This Command Does

1. Checks which files are staged with `git status`
2. **If files are already staged**: DO NOT modify staging area - commit only what's staged
3. **If 0 files are staged**: Automatically adds all modified files with `git add -u` (tracked files only, excludes untracked files)
4. Performs a `git diff` to understand what changes are being committed
5. Analyzes the diff to determine if multiple distinct logical changes are present
6. If multiple distinct changes are detected, suggests breaking the commit into multiple smaller commits
7. For each commit (or the single commit if not split), creates a commit message using conventional commit format

## Best Practices for Commits

- **Atomic commits**: Each commit should contain related changes that serve a single purpose
- **Split large changes**: If changes touch multiple concerns, split them into separate commits
- **Conventional commit format**: Use the format `[type] description` where type is one of:
  - `[feat]`: A new feature
  - `[fix]`: A bug fix
  - `[docs]`: Documentation changes
  - `[style]`: Code style changes (formatting, etc)
  - `[refactor]`: Code changes that neither fix bugs nor add features
  - `[perf]`: Performance improvements
  - `[test]`: Adding or fixing tests
  - `[chore]`: Changes to the build process, tools, etc.
  - `[ci]`: CI/CD improvements
  - `[revert]`: Reverting changes
- **Present tense, imperative mood**: Write commit messages as commands (e.g., "add feature" not "added feature")
- **Concise first line**: Keep the first line under 72 characters

## Commit Type Reference

- `[feat]`: New feature
- `[fix]`: Bug fix
- `[docs]`: Documentation
- `[style]`: Formatting/style
- `[refactor]`: Code refactoring
- `[perf]`: Performance improvements
- `[test]`: Tests
- `[chore]`: Tooling, configuration
- `[ci]`: CI/CD improvements
- `[revert]`: Reverting changes

## Guidelines for Splitting Commits

When analyzing the diff, consider splitting commits based on these criteria:

1. **Different concerns**: Changes to unrelated parts of the codebase
2. **Different types of changes**: Mixing features, fixes, refactoring, etc.
3. **File patterns**: Changes to different types of files (e.g., source code vs documentation)
4. **Logical grouping**: Changes that would be easier to understand or review separately
5. **Size**: Very large changes that would be clearer if broken down

## Examples

Good commit messages:
- [feat] add user authentication system
- [fix] resolve memory leak in rendering process
- [docs] update API documentation with new endpoints
- [refactor] simplify error handling logic in parser
- [fix] resolve linter warnings in component files
- [chore] improve developer tooling setup process
- [feat] implement business logic for transaction validation
- [fix] address minor styling inconsistency in header
- [fix] patch critical security vulnerability in auth flow
- [style] reorganize component structure for better readability
- [refactor] remove deprecated legacy code
- [feat] add input validation for user registration form
- [fix] resolve failing CI pipeline tests
- [feat] implement analytics tracking for user engagement
- [fix] strengthen authentication password requirements
- [feat] improve form accessibility for screen readers

Example of splitting commits:
- First commit: [feat] add new solc version type definitions
- Second commit: [docs] update documentation for new solc versions
- Third commit: [chore] update package.json dependencies
- Fourth commit: [feat] add type definitions for new API endpoints
- Fifth commit: [feat] improve concurrency handling in worker threads
- Sixth commit: [fix] resolve linting issues in new code
- Seventh commit: [test] add unit tests for new solc version features
- Eighth commit: [fix] update dependencies with security vulnerabilities

## Important Notes

- **If specific files are already staged**: The command will ONLY commit those files and will NOT add any other files to staging area
- **If no files are staged**: It will automatically stage all modified files (tracked files only, using `git add -u`) - untracked files are excluded
- The commit message will be constructed based on the changes detected
- Before committing, the command will review the diff to identify if multiple commits would be more appropriate
- If suggesting multiple commits, it will help you stage and commit the changes separately
- Always reviews the commit diff to ensure the message matches the changes
