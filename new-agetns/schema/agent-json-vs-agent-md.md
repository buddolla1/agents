# `agent.json` vs `agent.md`

This document explains when to use `agent.json` and when to use `agent.md` in this repository. The short version is simple: use `json` for execution, use `md` for explanation.

## 1. Core Difference

`agent.json` is a machine contract. `agent.md` is a human contract.

- `agent.json` defines structure that a runtime can parse, validate, and execute.
- `agent.md` describes intent, behavior, and instructions in readable prose.

## 2. Best Use Cases

### Use `agent.json` when you need:

- Executable configuration
- Strict schema validation
- Workflow orchestration
- Parallel or sequential step execution
- Routing and fallback rules
- Tool binding and agent handoffs
- Auditable, versioned automation

### Use `agent.md` when you need:

- Human-readable agent instructions
- Prompt guidance
- Operating notes
- Architectural explanations
- Skill documentation
- Design decisions and conventions

## 3. Decision Matrix

| Need | `agent.json` | `agent.md` |
| --- | --- | --- |
| Runtime execution | Yes | No |
| Schema validation | Yes | No |
| Multi-step workflows | Yes | Not reliably |
| Parallel orchestration | Yes | No |
| Routing logic | Yes | Only as text |
| Tool integration | Yes | Only described |
| Human readability | Moderate | Excellent |
| Versioned automation | Yes | Weak |
| Fast authoring | Moderate | Yes |
| Safe enterprise use | Strong | Limited |

## 4. Major Advantages Of `agent.json`

### 4.1 Predictable Structure

- What it does: forces the file into a known schema.
- Why it matters: the runtime always knows where to find agents, workflows, tools, and policies.

### 4.2 Validation Before Execution

- What it does: lets you catch missing fields and invalid values early.
- Why it matters: reduces runtime failures and broken orchestration.

### 4.3 Real Orchestration

- What it does: supports workflows, steps, dependencies, retries, and branching.
- Why it matters: makes multi-agent systems actually executable, not just descriptive.

### 4.4 Deterministic Behavior

- What it does: standardizes identifiers, inputs, outputs, and fallback paths.
- Why it matters: improves reliability across repos, teams, and environments.

### 4.5 Better Tooling

- What it does: integrates well with parsers, IDEs, CI/CD, and runtime engines.
- Why it matters: automation becomes easier to build and maintain.

### 4.6 Easier Governance

- What it does: expresses policies, approvals, observability, and memory in a structured way.
- Why it matters: supports enterprise controls like auditability and safety checks.

## 5. Limitations Of `agent.md`

### 5.1 No Enforced Schema

- What it does not do: prevent malformed or inconsistent structure.
- Why this is a problem: the meaning depends on whoever reads it.

### 5.2 No Reliable Execution Contract

- What it does not do: guarantee that steps are run in order or in parallel.
- Why this is a problem: it can describe orchestration, but it cannot enforce orchestration.

### 5.3 Weak Automation Support

- What it does not do: provide a native format for runtimes or validators.
- Why this is a problem: extra parsing and interpretation logic is needed.

### 5.4 More Ambiguous At Scale

- What it does not do: standardize large systems cleanly.
- Why this is a problem: long markdown files become inconsistent across contributors.

### 5.5 Harder To Audit

- What it does not do: define explicit machine-readable logs, policies, or artifact contracts.
- Why this is a problem: enterprise traceability is weaker.

## 6. Section-By-Section Comparison

### Identity

- `agent.json`: stores ids, names, roles, and models in fields the runtime can use directly.
- `agent.md`: explains identity in prose, which is easy to read but hard to validate.

### Behavior

- `agent.json`: can define constraints, delegation rules, and runtime limits.
- `agent.md`: can describe behavior, but not enforce it.

### Workflows

- `agent.json`: expresses multi-step execution with dependencies and retries.
- `agent.md`: can document a workflow, but it remains instructional.

### Routing

- `agent.json`: maps intent or signals to workflows and agents.
- `agent.md`: can list routing ideas, but not execute them deterministically.

### Policies

- `agent.json`: encodes security, compliance, and approval gates.
- `agent.md`: explains policies, but does not apply them.

### Tools

- `agent.json`: binds tools by id and config.
- `agent.md`: references tools conceptually only.

### Memory

- `agent.json`: declares memory type, scope, provider, and retention.
- `agent.md`: describes memory strategy, but not storage behavior.

### Observability

- `agent.json`: defines logging, metrics, tracing, and exporters.
- `agent.md`: documents what should be observed.

## 7. When To Use Each One

### Choose `agent.json` if:

- The file must be loaded by code.
- The file must be validated automatically.
- The file must drive workflows or routing.
- The file must support parallel or conditional execution.
- The file must be safe for enterprise automation.

### Choose `agent.md` if:

- The file is primarily for people to read.
- The file is a prompt, guide, or design note.
- The file is meant to explain behavior instead of enforce it.
- The file is part of documentation or skill instructions.

## 8. Recommended Pattern For This Repo

Use both formats together.

- Use `agent.json` for runtime configuration and orchestration.
- Use `agent.md` for explanation, prompt guidance, and operational notes.

This combination works well here because the repo already has both executable JSON agents and descriptive markdown skills/docs.

## 9. Practical Examples

### Good Fit For `agent.json`

- Spring Boot migration pipeline
- Multi-agent code review
- Repo analysis and fix workflow
- Routing a request to review, security, or performance agents

### Good Fit For `agent.md`

- Skill instructions for null safety or dependency analysis
- Agent behavior notes
- Workflow rationale
- Human review checklist

## 10. Final Rule

- Use `agent.json` when the system must do something.
- Use `agent.md` when the document must explain something.

