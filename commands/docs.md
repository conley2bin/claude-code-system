# Documentation Generation Command

Generate or update documentation for code, ensuring it follows documentation best practices from CLAUDE.md.

## Instructions:

1. **Identify Documentation Target:**
   - If specific file(s) provided, document those
   - If no target specified, ask user what needs documentation
   - Check for existing documentation to update rather than duplicate

2. **Documentation Types:**

   **Code Documentation:**
   - Function/method docstrings
   - Class documentation
   - Module-level documentation
   - Inline comments for complex logic
   - Type hints/annotations

   **API Documentation:**
   - Endpoint descriptions
   - Request/response formats
   - Authentication requirements
   - Error codes and handling

   **User Documentation:**
   - README files
   - Usage guides
   - Installation instructions
   - Configuration options
   - Troubleshooting guides

3. **Documentation Principles (from CLAUDE.md):**

   **Motivation-First Writing:**
   - Start with the problem/pain point
   - Explain WHY before HOW
   - Describe trade-offs and design decisions

   **Fact-Checking:**
   - Verify all parameter names against actual code
   - Test all example commands
   - Confirm default values and behavior
   - Cross-reference related documentation

   **Reader-Oriented:**
   - Organize by use-case scenarios
   - Progressive disclosure (basic → advanced)
   - Practical, copy-paste examples
   - Clear headings for scanning

   **Avoid Anti-Patterns:**
   - ❌ Commands without context
   - ❌ Magic behavior without explanation
   - ❌ Outdated examples
   - ❌ Generic advice with no specifics

4. **Documentation Format:**

   **For Functions/Methods:**
   ```python
   def function_name(param1: Type1, param2: Type2) -> ReturnType:
       """
       Brief one-line description.

       Detailed explanation of what this function does and WHY it exists.
       Explain the problem it solves, not just what it does.

       Args:
           param1: Description including valid values and constraints
           param2: Description including purpose and default behavior

       Returns:
           Description of return value and its structure

       Raises:
           ErrorType: When and why this error occurs

       Example:
           >>> result = function_name("value", 42)
           >>> print(result)
           expected_output
       """
   ```

   **For User-Facing Docs:**
   ```markdown
   # Feature Name

   ## The Problem
   [Describe the pain points users face]

   ## The Solution
   [Explain how this feature solves those problems]

   ## Usage

   ### Basic Usage
   [Simple, complete example]

   ### Advanced Configuration
   [More complex scenarios]

   ## How It Works
   [Explain non-obvious mechanisms]

   ## Related
   - [Link to related docs]
   ```

5. **Quality Gates:**
   - [ ] Problem context explained before solutions
   - [ ] All parameter names verified against code
   - [ ] All examples tested and working
   - [ ] Non-standard patterns explained
   - [ ] Related documentation cross-referenced
   - [ ] No generic "best practices" fluff

## Documentation Examples:

### Example 1: Motivation-First
```markdown
## The Problem
Traditional audio processing requires writing audio data to disk, which:
- Adds latency (50-100ms for disk I/O)
- Risks data loss if disk is full
- Complicates cleanup and error handling

## The Solution: BytesIO Streaming
The streaming module uses in-memory buffers to:
- Eliminate disk I/O completely
- Stream directly to API
- Automatic cleanup via context managers

### Usage
\```python
with AudioStream() as stream:
    stream.record(duration=5)
    result = stream.transcribe()
\```
```

### Example 2: Code Documentation
```python
def process_audio(data: np.ndarray, sample_rate: int = 44100) -> AudioResult:
    """
    Process raw audio data for transcription.

    This function solves the problem of inconsistent audio formats by
    normalizing sample rate and bit depth before sending to the API.
    It uses numpy for vectorized operations rather than loops for
    performance (per CLAUDE.md principles).

    Args:
        data: Raw audio samples as numpy array, shape (n_samples,)
        sample_rate: Original sample rate in Hz. Default 44100 matches
                    most USB microphones. Will resample to 16000 for API.

    Returns:
        AudioResult containing normalized data and metadata

    Raises:
        ValueError: If data is empty or sample_rate <= 0

    Example:
        >>> audio = np.random.randn(44100)  # 1 second at 44.1kHz
        >>> result = process_audio(audio)
        >>> result.sample_rate
        16000
    """
```

## Important:
- NEVER create documentation files unless explicitly requested
- Always verify technical details against actual code
- Focus on WHY, not just WHAT
- Test all examples before including them
- Link to related documentation
- Keep it concise but complete
