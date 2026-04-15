
---

### `skills.md`
```md
# Skills for java-npe-detector

These skills are reusable and should stay outside the agent so multiple agents can share them.

## Skill 1: Null Flow Tracing
Trace where null can originate and how it reaches a dereference point.

### Apply this when
- A value comes from API input
- A repository/service may return null
- A nested getter chain exists
- An object is conditionally assigned

### Method
- Identify nullable source
- Track assignment path
- Check guards before usage
- Confirm dereference site
- Mark confidence based on evidence

---

## Skill 2: Java Dereference Risk Detection
Spot direct and indirect dereference patterns that often fail at runtime.

### Detect patterns
- chained getters
- method calls on nullable references
- collection element dereference
- map lookup dereference
- wrapper unboxing
- `optional.get()`

### Good output example
- nullable source
- exact risky line
- safe alternative

---

## Skill 3: Framework-aware Null Safety Review
Understand common NPE sources in Spring, JPA, REST, and service layers.

### Spring checks
- field injection
- missing bean wiring
- nullable request payloads
- missing config values
- unsafe response body access

### JPA checks
- nullable columns
- lazy-loaded references
- repository null returns
- incomplete projections

### API/DTO checks
- missing nested request fields
- partial response contracts
- optional JSON fields treated as required

---

## Skill 4: Safe Fix Generation
Generate minimal, practical fixes instead of overengineering.

### Preferred fixes
- early validation
- guard clause
- safe equals
- constructor injection
- `Objects.requireNonNull`
- empty collection default
- better method contract
- `Optional` only where appropriate

### Avoid
- giant refactors
- catch-and-ignore
- blanket null checks everywhere
- behavior-changing defaults without warning

---

## Skill 5: Null-safe Test Suggestion
Suggest tests that reproduce or prevent NPE regressions.

### Example test ideas
- null request field
- empty repository result
- missing nested DTO
- null config value
- null external API response field
- collection empty/null case

### Test style
- one focused test per issue
- name the scenario clearly
- verify failure or safe handling

---

## Skill 6: Findings Prioritization
Rank issues so teams fix the highest-impact NPE risks first.

### Priority order
1. Production request path crashes
2. Service layer business logic crashes
3. Persistence and integration risks
4. Rare edge cases
5. Preventive code smells

### Severity hints
- Critical: frequent crash path
- High: common business flow
- Medium: conditional path
- Low: preventive hardening

---

## Skill 7: Reporting Format
Always produce findings in a clean engineering-review format.

## Output template
- Summary
- Findings by severity
- Risk explanation
- Suggested fix
- Suggested test
- Priority fix order

### Rule
Every finding must answer:
- What can be null?
- Where is it dereferenced?
- Why is it risky?
- What is the safest fix?