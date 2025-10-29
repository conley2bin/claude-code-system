# Auto Commit Command

Analyze all staged and unstaged changes, then create a git commit with a well-formatted message.

## Instructions:

1. **Analyze Changes:**
   - Run `git status` to see all modified and untracked files
   - Run `git diff` to see both staged and unstaged changes
   - Run `git log -5 --oneline` to understand the project's commit message style

2. **Generate Commit Message:**
   - Summarize the nature of changes (feat/fix/refactor/docs/test/perf)
   - Write a concise commit title (50 chars max, imperative mood)
   - Add detailed description if needed (explain WHY, not WHAT)
   - Follow this format:
     ```
     <type>: <subject>

     <optional body>

     ```

3. **Commit Types:**
   - `feat`: New feature
   - `fix`: Bug fix
   - `refactor`: Code restructuring without behavior change
   - `docs`: Documentation changes
   - `test`: Test additions or modifications
   - `perf`: Performance improvements
   - `chore`: Build/tooling changes

4. **Execute Commit:**
   - Add all relevant files to staging area
   - Create the commit using HEREDOC format
   - Run `git status` after commit to verify

## Example Commit Messages:

```
feat: add BytesIO-based audio streaming

Implement memory-based audio capture to eliminate disk I/O.
Recording data stored in BytesIO and directly streamed to Whisper API.

```

```
fix: use device native sample rate for recording

Change from hardcoded 16000Hz to device's native 44100Hz
to avoid "Invalid sample rate" error with USB microphone.

```

## Important:
- Read ALL changes with git diff, not just the most recent modification
- Ensure commit message accurately reflects ALL changes
- Never commit files with secrets (.env, credentials.json, etc)
- Do not push unless explicitly requested
