
## Extended `skills.md`
```md
# Skills for java-runtime-exception-detector

These skills are reusable reasoning modules for exception detection across Java and Spring codebases.

---

## Skill 1: Null Flow Tracing
Trace where null originates and how it reaches a dereference point.

### Use for
- chained getters
- nullable DTO/entity fields
- repository/service returns
- external API responses
- collection/map lookups

### Check
- source of null
- path to dereference
- missing guards
- bad assumptions
- confidence level

---

## Skill 2: Property and Configuration Failure Analysis
Detect runtime failures caused by missing, malformed, or mismatched configuration.

### Use for
- `@Value`
- `@ConfigurationProperties`
- env variables
- profile-specific settings
- manual property parsing

### Detect
- missing property keys
- wrong types
- invalid formats
- renamed keys
- YAML structure mismatch
- required config not validated
- defaults masking real config errors

### Common exception patterns
- `BeanCreationException`
- `BindException`
- `IllegalArgumentException`
- `ConversionFailedException`
- `NumberFormatException`

### Recommended fixes
- validate config at startup
- use typed config classes
- add safe defaults only when valid
- document required properties
- fail fast for mandatory settings

---

## Skill 3: Runtime Exception Path Analysis
Analyze code paths that can produce common unchecked exceptions.

### Detect
- invalid state
- invalid arguments
- bad collection assumptions
- iterator misuse
- missing guards
- hidden side effects
- unsafe state transitions

### Exception families
- `IllegalArgumentException`
- `IllegalStateException`
- `IndexOutOfBoundsException`
- `NoSuchElementException`

---

## Skill 4: Parsing and Format Risk Detection
Find places where text, numbers, dates, enums, or config values are parsed unsafely.

### Detect
- `Integer.parseInt`
- `Long.parseLong`
- `Enum.valueOf`
- date/time parse calls
- implicit format assumptions
- parsing from headers/query params/properties

### Recommended fixes
- validate before parsing
- use safe wrappers
- handle invalid formats explicitly
- provide helpful error paths

---

## Skill 5: Type Safety and Casting Analysis
Detect unsafe casts and runtime type assumptions.

### Detect
- raw collections
- unchecked casts
- response/object-map casting
- deserialization shape assumptions
- framework return type assumptions

### Common exception
- `ClassCastException`

### Recommended fixes
- remove raw types
- use typed DTOs
- validate deserialized shape
- avoid blind casting

---

## Skill 6: Spring Bean and Startup Failure Analysis
Review runtime failures related to bean wiring and application startup.

### Detect
- missing beans
- circular dependency risks
- invalid constructor args
- bad conditional bean assumptions
- config property injection mismatch
- startup initialization order issues

### Common exception
- `BeanCreationException`
- `UnsatisfiedDependencyException`
- `NoSuchBeanDefinitionException`

### Recommended fixes
- constructor injection
- explicit bean contracts
- config validation
- simplify conditional wiring

---

## Skill 7: Persistence Runtime Risk Review
Detect JPA/Hibernate runtime issues and fragile database assumptions.

### Detect
- lazy loading outside transaction
- nullable DB columns used as required
- custom query result mismatch
- optional mishandling
- relation assumptions

### Common exception
- `LazyInitializationException`
- `EntityNotFoundException`
- `NonUniqueResultException`
- `NullPointerException`

### Recommended fixes
- correct transaction boundaries
- validate nullable columns
- explicit fetch design
- align repository contracts

---

## Skill 8: REST and Serialization Exception Review
Detect runtime failures around request parsing, response assumptions, and DTO mismatch.

### Detect
- missing nested request fields
- invalid enum/text conversion
- deserialization mismatch
- external API contract drift
- nullable response body assumptions

### Recommended fixes
- stronger DTO validation
- explicit request constraints
- null-safe response mapping
- typed contracts over raw maps

---

## Skill 9: Collection and Stream Safety Review
Detect fragile stream, optional, and collection handling.

### Detect
- `findFirst().get()`
- `optional.get()`
- empty collection assumptions
- modifying collection during iteration
- mapping nullable values without filtering

### Common exception
- `NoSuchElementException`
- `ConcurrentModificationException`
- `NullPointerException`

### Recommended fixes
- presence checks
- empty handling
- filter nulls before mapping
- safe iteration patterns

---

## Skill 10: Concurrency and Shared-State Runtime Review
Detect runtime failures from non-thread-safe code and shared mutable state.

### Detect
- singleton mutable state
- unsynchronized lazy init
- shared collection mutation
- cross-request data leakage
- iteration while modification

### Common exception
- `ConcurrentModificationException`
- inconsistent runtime state

### Recommended fixes
- isolate mutable state
- use proper synchronization
- avoid request data in singleton fields

---

## Skill 11: Safe Fix Generation
Generate minimal, practical fixes that reduce runtime risk without unnecessary rewrites.

### Preferred fixes
- guard clause
- fail-fast validation
- constructor injection
- config validation
- bounds check
- safe parse handling
- better contracts
- smaller refactors over broad rewrites

### Avoid
- catch-and-ignore
- hiding root cause
- giant rewrites
- broad defaults that change business behavior silently

---

## Skill 12: Exception-focused Test Suggestion
Suggest tests that reproduce and prevent runtime failures.

### Good test targets
- missing property
- malformed property type
- null nested request
- invalid enum
- empty repository result
- out-of-range index
- unsafe cast path
- startup bean wiring failure
- lazy relation outside transaction

### Test style
- one issue per test
- clear scenario name
- assert failure or safe behavior explicitly

---

## Skill 13: Findings Prioritization
Rank issues by crash likelihood and production impact.

### Priority order
1. Startup/config failures
2. Common API/service crash paths
3. Persistence/runtime integration failures
4. Rare edge-case exceptions
5. Preventive hardening

---

## Skill 14: Reporting Format
Always report findings in a clean engineering-review structure.

### Every finding must answer
- What fails?
- Under what trigger?
- Why?
- Where?
- What is the safest fix?
- What test should cover it?