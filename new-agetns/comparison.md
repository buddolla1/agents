┌───────────────────────────────┬───────────────────────────────┐
│           JSON (.json)        │        Markdown (.md)          │
├───────────────────────────────┼───────────────────────────────┤
│ Purpose                       │ Purpose                       │
│ Execution / Automation        │ Readability / Instructions     │
├───────────────────────────────┼───────────────────────────────┤
│ Machine Readable              │ Human Readable                │
│ Strict structure              │ Flexible free-form text       │
├───────────────────────────────┼───────────────────────────────┤
│ Can Execute Steps             │ Cannot Execute Steps          │
│ (run_command, agent_call)     │ Only describes steps          │
├───────────────────────────────┼───────────────────────────────┤
│ Supports Logic                │ No Real Logic                 │
│ (conditions, branching)       │ (only written rules)          │
├───────────────────────────────┼───────────────────────────────┤
│ Variable Binding              │ No Variable Binding           │
│ ${step.output} supported      │ Not reliably supported        │
├───────────────────────────────┼───────────────────────────────┤
│ Parallel / Sequential Control │ No Execution Control          │
│ Yes                           │ No                            │
├───────────────────────────────┼───────────────────────────────┤
│ Integration                   │ Integration                   │
│ CLI, Git hooks, CI/CD         │ Copilot prompts, docs         │
├───────────────────────────────┼───────────────────────────────┤
│ Best For                      │ Best For                      │
│ - Orchestrator agents         │ - Prompt design               │
│ - Workflow engines            │ - Documentation               │
│ - Automation pipelines        │ - Copilot interaction         │
├───────────────────────────────┼───────────────────────────────┤
│ Limitation                    │ Limitation                    │
│ Harder to read/write          │ Not executable                │
└───────────────────────────────┴───────────────────────────────┘