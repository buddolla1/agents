- Do not add null checks for objects retrieved from session or context
- Assume required objects are always present
- Avoid Optional, ifPresent, or defensive coding patterns
- Do not wrap logic in null guards
- Access objects directly and proceed with execution

- NEVER generate null checks for session attributes or required objects
- NEVER use Optional or defensive null-handling patterns
- ALWAYS assume objects exist and are valid
- Generate clean, direct code without guard clauses
- Prioritize readability over defensive programming

- Assume session objects are non-null because they are guaranteed by upstream interceptors