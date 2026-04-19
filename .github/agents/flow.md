```mermaid
%%{init: {"themeVariables": {"fontSize": "44px"}, "flowchart": {"nodeSpacing": 140, "rankSpacing": 160, "padding": 40}} }%%
flowchart TD

A[Start Backend Review] --> B[Read Git Diff and Changed Files]
B --> C[Detect Spring / Java / Redis / Kafka / API Changes]

C --> D[Select Core Skills]
D --> D1[spring-standards-review]
D --> D2[java-runtime-exception-review]
D --> D3[backend-security-review]

C --> E[Select Up To 2 Optional Skills]
E -->|Redis change| E1[redis-integration-review]
E -->|Kafka change| E2[kafka-integration-review]
E -->|API or downstream integration change| E3[api-resilience-review]

D1 --> F[Run Selected Skills In Parallel]
D2 --> F
D3 --> F
E1 --> F
E2 --> F
E3 --> F

F --> G[Collect Skill Outputs]
G --> H[Merge Duplicate Findings]
H --> I[Normalize Severity]
I --> J[Generate Consolidated Review]

J --> K{Decision Engine}
K -->|Any HIGH issue| L[FAIL]
K -->|Only MEDIUM issues| M[CONDITIONAL PASS]
K -->|Only LOW or no issues| N[PASS]

L --> O[Final Report]
M --> O
N --> O
