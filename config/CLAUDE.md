# CLAUDE.md - System-Level Development Guidelines

## Core Principles

### Professional Rigor
- **Think Before Responding**: Fully understand the question's context and implications before answering
- **Acknowledge Limitations**: Explicitly state when lacking sufficient information to provide a definitive answer
- **Verify Over Assume**: Test hypotheses, read actual code, check documentation - never assume
- **Present Trade-offs**: When multiple interpretations exist, present all valid options with their trade-offs

## Development Philosophy

### Fail-Fast Principle
**Core Concept**: Expose errors immediately, fail at the problem source rather than hiding or delaying errors.

**Required Pattern**:
```
// When dependency must exist
if (dependency == null) {
    throw Error("Required dependency is null - initialization failed")
}
// Let code crash immediately to expose problem at its source
```

**Forbidden Patterns**:
```
// WRONG: Silent failure
if (x == null) { x = defaultValue }  // Hides initialization issues
try { ... } catch { fallback() }     // Masks real errors
```

**Key Distinctions**:
- ✅ Check external failures (I/O, network, hardware)
- ❌ Don't check if internal dependencies are null (should be guaranteed by design)
- ❌ Don't add fallbacks for your own logic errors

### Single Source of Truth
**Core Concept**: Each piece of state/configuration has exactly one authoritative source, avoiding synchronization issues.

**Implementation**:
- Access shared resources through properties/getters
- Never duplicate state that needs synchronization
- Use dependency injection rather than hardcoding

```
// CORRECT: Access from parent
getSharedResource() {
    return this.parent.sharedResource
}

// WRONG: Create local copy
constructor(parent) {
    this.resource = parent.resource  // Will become stale!
}
```

### Minimal Code Principle
**Core Concept**: Less is more - every line of code is a liability.

**Key Practices**:
- Use existing abstractions rather than reimplementing
- Delete dead code immediately and aggressively (see Dead Code Elimination below)
- Avoid unnecessary instance variables
- If writing too much code, the approach is probably wrong

### YAGNI Principle (You Aren't Gonna Need It)
**Core Concept**: Don't add functionality until it's actually needed - not when you just foresee you might need it.

**Philosophy**:
- Implement things only when you actually need them
- Avoid "predicting future requirements"
- Focus on current, real requirements

**Why It Matters**:
```
// WRONG: Adding features "just in case"
class UserService {
    // Nobody asked for this, might never be used
    exportToXML() { ... }
    exportToCSV() { ... }
    exportToPDF() { ... }
    importFromLegacySystem() { ... }
}

// CORRECT: Build what's actually needed
class UserService {
    // Only implemented because current sprint requires it
    exportToJSON() { ... }
}
```

**Key Benefits**:
- Reduced complexity and maintenance burden
- Faster development of core features
- Less code to test and debug
- Easier to understand codebase

**Important Distinction**:
- ✅ YAGNI applies to features and capabilities
- ❌ YAGNI does NOT apply to code quality (refactoring, clean code, good architecture)
- Refactoring and making code easier to change is NOT a YAGNI violation

**Real-World Application**:
- Wait for the second or third use case before abstracting
- Build the simplest thing that works
- Add complexity only when requirements prove it necessary

### Dead Code Elimination
**Core Concept**: Unused code is a liability - delete it immediately and aggressively.

**Types to Delete**:
```
// Unreachable code, unused functions/classes, commented code
// Unused variables/imports, unused configuration parameters
```

**Best Practices**:
- Don't comment out - delete (Git preserves history)
- Write detailed commit messages explaining why
- Use static analysis and code coverage tools
- Monitor before deleting if uncertain (add logging, check after 1-2 weeks)

**When to Be Cautious**: Public APIs, plugin systems, framework code (may be used externally)

## Communication Protocols

### Issue Resolution Protocol
**Never Claim Premature Success**, especially during troubleshooting.

❌ Wrong:
- "The issue is resolved"
- "This should fix the bug"

✅ Correct:
- "I've implemented a potential fix. Please test and confirm if this resolves the issue"
- "Changes are complete. Can you verify the problem is fixed?"

**Principle**: Only the user can confirm an issue is truly resolved.

### Debugging Protocol
1. **Test Thoroughly**: Run the actual failing scenario
2. **Verify End-to-End**: Check the complete workflow
3. **Await Feedback**: Request user confirmation
4. **Document Actual Behavior**: Report what actually happens, not what should happen

### Documentation Protocol

**Explain Why Before How**:
- Start with pain points users face
- Explain solution rationale
- Be explicit about trade-offs and limitations

**Verify All Technical Details**:
- Validate parameter names against actual code
- Check actual default values
- Test all example commands

**Reader-Oriented Structure**:
- Organize around user scenarios
- Basic usage first, advanced configuration later
- Provide copy-paste ready examples

## Implementation Guidelines

### Study Before Modifying
1. **Understand Existing Abstractions**: Find similar patterns
2. **Follow Established Patterns**: Don't reinvent the wheel
3. **Read Related Tests**: Understand expected behavior

### Component Responsibility Separation
- Each component has a specific purpose
- Don't violate separation of concerns
- When needing functionality from another domain, delegate to the appropriate component

### Understand Before Optimizing
**Always understand code before optimizing**:
- Read complete implementation and understand behavior
- Identify all API contracts
- Map out data flow and dependencies
- Only then plan optimizations

### Dynamic Discovery Over Hardcoding
- Query configuration systems for available components
- Use existing registries and discovery mechanisms
- Avoid duplicating knowledge that exists elsewhere

## Architecture Patterns

### Naming Principles
**Core Concept**: Names should reveal intent, not implementation details.

**Express Intent, Not Implementation**:
```
// WRONG: Implementation-focused
getUserRolesFromDatabase()
configMap.get("timeout")

// CORRECT: Intent-focused
getUserPermissions()
getTimeout()
```

**Avoid Abbreviations**:
```
// WRONG: Cryptic abbreviations
cfg, ctx, usr, mgr, svc

// CORRECT: Clear full names
configuration, context, user, manager, service

// EXCEPTION: Universally known abbreviations are OK
id, url, html, json, xml
```

**Boolean Predicates**:
```
// CORRECT: Clear predicates
isEnabled(), hasPermission(), canEdit(), shouldRetry()

// WRONG: Ambiguous names
enabled(), permission(), edit(), retry()
```

**Key Guidelines**:
- Reader should understand purpose without reading implementation
- Longer descriptive names are better than short cryptic ones
- Consistency matters: if you use `get` prefix, use it everywhere

### Dependency Direction
**Core Concept**: Dependencies should flow from concrete to abstract, from outer layers to inner layers.

**High-Level Independence**:
```
// WRONG: Core logic depends on infrastructure
class UserService {
    private database: PostgreSQL  // Tight coupling to specific DB

    getUser(id) {
        return this.database.query("SELECT * FROM users WHERE id = ?", id)
    }
}

// CORRECT: Core logic depends on abstraction
class UserService {
    private repository: UserRepository  // Abstract interface

    getUser(id) {
        return this.repository.findById(id)
    }
}
```

**Interface-Based Design**:
```
// Infrastructure implements interface
class PostgresUserRepository implements UserRepository {
    findById(id) { /* PostgreSQL-specific implementation */ }
}

// Easy to swap implementations
class MongoUserRepository implements UserRepository {
    findById(id) { /* MongoDB-specific implementation */ }
}
```

**No Circular Dependencies**:
```
// WRONG: A needs B, B needs A
class OrderService {
    constructor(private paymentService: PaymentService) {}
}
class PaymentService {
    constructor(private orderService: OrderService) {}  // Circular!
}

// CORRECT: Extract shared interface or third component
interface PaymentEvents {
    onPaymentComplete(orderId: string): void
}

class OrderService implements PaymentEvents {
    onPaymentComplete(orderId) { /* handle */ }
}

class PaymentService {
    constructor(private eventHandler: PaymentEvents) {}
}
```

**Key Guidelines**:
- Business logic should never import infrastructure code
- If two modules depend on each other, extract a shared abstraction
- Dependencies should form a directed acyclic graph (DAG), never cycles
- Test whether you can replace implementation without changing core logic

### Abstraction & Polymorphism

**Never Handle Special Cases in Generic Code**:
```
// WRONG: Type checking
if (type == "special") { handleSpecial() }

// CORRECT: Polymorphism
object.handle()  // Let each implementation provide its own behavior
```

**Key Guidelines**:
- Base classes should not know about specific implementations
- Adding new types should not require modifying existing generic code
- Query capabilities through interface methods, not type checking

### Scientific/Engineering Mindset
**Elegant and Clear, Not Defensive**:

```
// WRONG: Defensive mindset (nested checks)
if (config.enabled) {
    if (data && data.length > 0) {
        if (validator.isValid(data)) {
            result = process(data)
        }
    }
}

// CORRECT: Scientific mindset (precompute + vectorize)
validData = data[validMask]
result = processor.transform(validData)
```

**Core Techniques**:
- **Masking > Branching**: Use boolean masks instead of conditional logic
- **Precompute Everything**: Runtime should be pure computation
- **Vectorized Operations**: Think in tensors/arrays, not loops
- **Function Pointers**: Assign functions at init, not runtime branching

## Performance Principles
- **Measure Over Guess**: Profile first, optimize later
- **Algorithms Over Micro-optimizations**: O(n) beats O(n²)
- **Cache Compute-Intensive Operations**
- **Lazy Load Expensive Resources**

---

**Remember**: These are principles, not rules. Use judgment, understand the reasoning, and apply wisely in context.
