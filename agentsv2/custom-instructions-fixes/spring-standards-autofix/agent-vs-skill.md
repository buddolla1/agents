# Agent vs Skill

## Purpose

Explain how the Spring standards agent and its skills work together.

## Core Idea

- An `agent` is the executor.
- A `skill` is a rule set the agent consults.
- The prompt tells the agent what task to perform.
- The skill tells the agent what is safe, guided, or advisory.

## How It Works

1. The user invokes the agent.
2. The agent loads the matching skill or skills on demand for the current task.
3. The skills classify code patterns and rules.
4. The agent applies only changes that are explicitly marked safe.
5. The agent reports guided or advisory issues without changing code.

## Trigger Points

- Use the agent when the task touches controllers, services, repositories, DTOs, entities, or exceptions.
- Use the agent when transaction boundaries, SQL, JPA, or JDBC code changes.
- Use the agent when reviewing changed files in a PR and you only want safe fixes.
- Use the agent when you want standards applied to new Spring code without broad refactoring.

## Example

- `spring-standards-autofix-agent.md` loads `jdbc-jpa-usage-check`.
- The agent scans code for JDBC and JPA misuse.
- If a fix is safe, such as parameterizing SQL, it can be applied.
- If a change would alter persistence behavior, the agent should only report it.

## Important Rule

- Do not call a skill as if it were the executor.
- Always invoke the agent when you want the skill rules applied to code.
- The agent should load only the skills relevant to the current request.

## Prompt Pattern

```text
@spring-standards-autofix-agent
Review this module for JDBC vs JPA issues and apply only SAFE fixes.
```

## Summary

- Agent = worker
- Skill = rule file
- Prompt = task request
- Safe changes can be applied
- Guided and advisory changes should be reported
