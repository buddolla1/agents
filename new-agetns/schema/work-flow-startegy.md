# `agents.json` Schema for Orchestrated Multi-Step Agents

This document defines a practical enterprise-style `agents.json` schema for this repository. It is designed for multi-agent orchestration, staged execution, routing, guardrails, retries, and traceable outputs.

## Design Goals

- Support one agent or many agents.
- Support sequential, parallel, and hybrid execution.
- Keep routing separate from execution.
- Make every step explicit and machine-readable.
- Support enterprise concerns like security, compliance, observability, and memory.

## Top-Level Schema

This is the container for the full agent system.

- What it does: defines the top-level configuration that the runtime loads.
- Why we need it: keeps agents, workflows, routing, policies, and observability in one predictable contract.

```json
{
  "version": "1.0",
  "name": "string",
  "description": "string",
  "domain": "string",
  "environment": "local | dev | staging | prod",
  "executionMode": "single-agent | multi-agent | orchestrated",
  "orchestration": {},
  "agents": [],
  "skills": [],
  "tools": [],
  "workflows": [],
  "routing": {},
  "policies": {},
  "memory": {},
  "observability": {},
  "artifacts": {},
  "versioning": {},
  "defaults": {}
}
```

## Orchestration

Use orchestration to control how the system runs as a whole.

- What it does: controls global execution style, agent spawning, delegation, and conflict resolution.
- Why we need it: lets the system scale from a simple single-agent flow to coordinated multi-agent execution.

```json
{
  "orchestration": {
    "strategy": "sequential | parallel | hierarchical | hybrid | adaptive",
    "dynamicAgents": true,
    "allowDelegation": true,
    "maxParallelAgents": 6,
    "taskDistribution": "balanced | chunked | capability-based",
    "aggregation": {
      "mergeStrategy": "risk-priority | confidence-priority | last-write-wins",
      "deduplicate": true,
      "resolveConflicts": "manual-review | rule-based | confidence-based"
    },
    "fallback": {
      "mode": "safe-stop | safe-continue | reroute",
      "defaultWorkflowId": "safe-default-workflow"
    }
  }
}
```

## Agent Schema

Each agent should have one responsibility and one clear role in the system.

- What it does: describes a reusable worker with a role, model, tools, and constraints.
- Why we need it: prevents agents from becoming vague or overlapping in responsibility.

```json
{
  "id": "string",
  "name": "string",
  "type": "planner | executor | reviewer | orchestrator | router | analyzer",
  "role": "string",
  "description": "string",
  "model": "string",
  "skills": ["skill-id"],
  "tools": ["tool-id"],
  "memoryEnabled": true,
  "canDelegate": true,
  "canSpawnAgents": false,
  "inputSchema": {},
  "outputSchema": {},
  "systemPrompt": "string",
  "constraints": {
    "maxTokens": 8192,
    "timeoutMs": 60000
  }
}
```

### Recommended Agent Roles

- `planner` creates the execution plan.
- `executor` performs implementation work.
- `reviewer` validates correctness, safety, and quality.
- `orchestrator` coordinates other agents.
- `router` selects the right workflow or agent.
- `analyzer` inspects the repository, logs, or requirements.

These roles help keep the system modular.

- What it does: assigns a clear function to each agent.
- Why we need it: makes delegation, debugging, and scaling much easier.

## Workflow Schema

A workflow defines the exact execution path. This is where multiple steps, dependencies, retries, and conditional branches belong.

- What it does: describes the ordered plan that executes a task end to end.
- Why we need it: makes complex work deterministic, auditable, and easier to retry or recover.

```json
{
  "id": "string",
  "name": "string",
  "description": "string",
  "trigger": "manual | api | event | schedule",
  "mode": "sequential | parallel | hybrid",
  "ownerAgentId": "string",
  "inputSchema": {},
  "outputSchema": {},
  "steps": [
    {
      "id": "string",
      "name": "string",
      "type": "agent-call | action | tool-call | conditional | human-approval",
      "agentId": "string",
      "action": "string",
      "toolId": "string",
      "dependsOn": ["step-id"],
      "condition": "string",
      "input": {},
      "outputKey": "string",
      "retry": {
        "maxAttempts": 3,
        "backoffMs": 1000
      },
      "timeoutMs": 60000,
      "onFailure": {
        "strategy": "stop | continue | fallback | escalate",
        "fallbackStepId": "string"
      }
    }
  ],
  "artifacts": {
    "storeOutputs": true,
    "path": ".agent/output",
    "format": "json | markdown | text"
  }
}
```

### Best Practice For Steps

- Keep each step small and deterministic.
- Use `dependsOn` to make execution order explicit.
- Use `conditional` steps for branching.
- Use `human-approval` for risky or destructive actions.
- Use `outputKey` so later steps can consume earlier results cleanly.

Each step should do one thing well.

- What it does: turns a large task into smaller executable units.
- Why we need it: reduces failure blast radius and makes orchestration predictable.

## Strategy Schema

A strategy decides which workflow to run, or which agent should be selected, based on rules, model reasoning, or both.

- What it does: chooses the best path before execution starts.
- Why we need it: avoids hardcoding one workflow for every possible project shape or request type.

```json
{
  "id": "string",
  "name": "string",
  "description": "string",
  "decisionEngine": {
    "type": "rule-based | llm-based | hybrid",
    "temperature": 0.1
  },
  "signals": [
    "repo.size",
    "repo.type",
    "tests.coverage",
    "risk.level",
    "change.scope"
  ],
  "rules": [
    {
      "if": "condition expression",
      "then": {
        "workflowId": "string",
        "agentId": "string"
      }
    }
  ],
  "llmRouting": {
    "enabled": true,
    "prompt": "string"
  },
  "fallback": {
    "workflowId": "string",
    "agentId": "string",
    "reason": "string"
  },
  "constraints": {
    "maxDecisionTimeMs": 3000,
    "requireExplainability": true
  }
}
```

## Routing Schema

Routing connects user intent or repository context to the correct agent or workflow.

- What it does: maps intent or signals to the right execution target.
- Why we need it: prevents the wrong agent from handling the wrong task.

```json
{
  "strategy": "rule-based | confidence-based | llm-router | hybrid",
  "defaultAgentId": "string",
  "rules": [
    {
      "match": "string",
      "targetAgentId": "string",
      "targetWorkflowId": "string",
      "minConfidence": 0.75
    }
  ],
  "askClarificationWhenUncertain": true
}
```

## Policies

Policies enforce enterprise guardrails across all agents and workflows.

- What it does: defines safety, compliance, and execution limits.
- Why we need it: protects the repository, data, and runtime from unsafe or unauthorized actions.

```json
{
  "security": {
    "maskSecrets": true,
    "allowExternalNetwork": false,
    "auditAllActions": true
  },
  "compliance": {
    "piiHandling": "mask | block | allow",
    "retentionDays": 30,
    "standards": ["SOC2", "GDPR"]
  },
  "execution": {
    "requireApprovalForWrites": false,
    "requireApprovalForDeletes": true,
    "maxConcurrentSteps": 6
  }
}
```

## Memory

Memory gives agents short-term context and long-term repository knowledge.

- What it does: stores useful context across steps, workflows, or sessions.
- Why we need it: avoids repeated re-analysis and keeps multi-step tasks coherent.

```json
{
  "enabled": true,
  "type": "short-term | long-term | vector-store | hybrid",
  "provider": "redis | postgres | pinecone | local",
  "retentionDays": 30,
  "scope": "session | workflow | project | enterprise"
}
```

## Observability

Observability is required for debugging, auditability, and cost control.

- What it does: captures traces, metrics, and logs from execution.
- Why we need it: helps explain failures, measure cost, and verify behavior.

```json
{
  "logging": true,
  "tracing": true,
  "metrics": [
    "latency",
    "cost",
    "success-rate",
    "step-failure-rate"
  ],
  "exporters": ["datadog", "prometheus", "openTelemetry"],
  "redactSensitiveFields": true
}
```

## Artifacts

Artifacts store outputs from workflows and agents in a predictable location.

- What it does: persists generated files, reports, traces, or intermediate results.
- Why we need it: lets later steps and humans inspect what the system produced.

```json
{
  "store": true,
  "basePath": ".agent/output",
  "formats": ["json", "markdown", "txt"],
  "includeTrace": true
}
```

## Versioning

Versioning makes agent definitions and workflows safe to evolve.

- What it does: tracks how configs and workflows change over time.
- Why we need it: supports rollback, compatibility checks, and safe upgrades.

```json
{
  "agents": "semver",
  "workflows": "semver",
  "schema": "semver",
  "config": "git-sha"
}
```

## Recommended Enterprise Example

```json
{
  "version": "1.0",
  "name": "enterprise-engineering-agents",
  "description": "Multi-agent orchestration for analysis, implementation, review, and validation.",
  "domain": "software-engineering",
  "environment": "prod",
  "executionMode": "orchestrated",
  "orchestration": {
    "strategy": "hierarchical",
    "dynamicAgents": true,
    "allowDelegation": true,
    "maxParallelAgents": 4,
    "taskDistribution": "capability-based",
    "aggregation": {
      "mergeStrategy": "risk-priority",
      "deduplicate": true,
      "resolveConflicts": "confidence-based"
    },
    "fallback": {
      "mode": "safe-stop",
      "defaultWorkflowId": "safe-default-workflow"
    }
  },
  "agents": [
    {
      "id": "repo-analyzer",
      "name": "Repository Analyzer",
      "type": "analyzer",
      "role": "Inspects repository structure and change scope",
      "model": "gpt-5.2",
      "skills": ["repo-analysis", "dependency-analysis"],
      "tools": ["filesystem", "git"],
      "memoryEnabled": true,
      "canDelegate": false,
      "canSpawnAgents": false,
      "systemPrompt": "Analyze the repository, identify the task scope, and produce a structured plan."
    },
    {
      "id": "implementation-agent",
      "name": "Implementation Agent",
      "type": "executor",
      "role": "Applies the required code or configuration changes",
      "model": "gpt-5.2",
      "skills": ["code-editing", "refactoring"],
      "tools": ["filesystem", "git"],
      "memoryEnabled": true,
      "canDelegate": false,
      "canSpawnAgents": false
    },
    {
      "id": "review-agent",
      "name": "Review Agent",
      "type": "reviewer",
      "role": "Validates correctness, regressions, and quality",
      "model": "gpt-5.2",
      "skills": ["code-review", "risk-analysis"],
      "tools": ["filesystem", "git"],
      "memoryEnabled": true,
      "canDelegate": false,
      "canSpawnAgents": false
    }
  ],
  "workflows": [
    {
      "id": "repo-change-workflow",
      "name": "Repository Change Workflow",
      "description": "Analyze, implement, review, and validate repository changes.",
      "trigger": "api",
      "mode": "hybrid",
      "ownerAgentId": "repo-analyzer",
      "steps": [
        {
          "id": "analyze",
          "name": "Analyze Repository",
          "type": "agent-call",
          "agentId": "repo-analyzer",
          "outputKey": "analysis"
        },
        {
          "id": "implement",
          "name": "Implement Changes",
          "type": "agent-call",
          "agentId": "implementation-agent",
          "dependsOn": ["analyze"],
          "input": {
            "analysis": "{{analysis}}"
          },
          "outputKey": "changes"
        },
        {
          "id": "review",
          "name": "Review Changes",
          "type": "agent-call",
          "agentId": "review-agent",
          "dependsOn": ["implement"],
          "input": {
            "changes": "{{changes}}"
          },
          "outputKey": "review"
        },
        {
          "id": "approve",
          "name": "Approve or Retry",
          "type": "conditional",
          "dependsOn": ["review"],
          "condition": "review.status == 'pass'"
        }
      ],
      "artifacts": {
        "storeOutputs": true,
        "path": ".agent/output",
        "format": "json"
      }
    }
  ],
  "routing": {
    "strategy": "hybrid",
    "defaultAgentId": "repo-analyzer",
    "rules": [
      {
        "match": "review|audit|verify",
        "targetAgentId": "review-agent",
        "minConfidence": 0.8
      },
      {
        "match": "analyze|inspect|scan",
        "targetAgentId": "repo-analyzer",
        "minConfidence": 0.7
      }
    ],
    "askClarificationWhenUncertain": true
  },
  "policies": {
    "security": {
      "maskSecrets": true,
      "allowExternalNetwork": false,
      "auditAllActions": true
    },
    "compliance": {
      "piiHandling": "mask",
      "retentionDays": 30,
      "standards": ["SOC2", "GDPR"]
    },
    "execution": {
      "requireApprovalForWrites": false,
      "requireApprovalForDeletes": true,
      "maxConcurrentSteps": 4
    }
  },
  "memory": {
    "enabled": true,
    "type": "hybrid",
    "provider": "postgres",
    "retentionDays": 30,
    "scope": "project"
  },
  "observability": {
    "logging": true,
    "tracing": true,
    "metrics": ["latency", "cost", "success-rate", "step-failure-rate"],
    "exporters": ["prometheus", "datadog"],
    "redactSensitiveFields": true
  },
  "artifacts": {
    "store": true,
    "basePath": ".agent/output",
    "formats": ["json", "markdown"],
    "includeTrace": true
  },
  "versioning": {
    "agents": "semver",
    "workflows": "semver",
    "schema": "semver",
    "config": "git-sha"
  },
  "defaults": {
    "model": "gpt-5.2",
    "timeoutMs": 60000,
    "retry": {
      "maxAttempts": 3,
      "backoffMs": 1000
    }
  }
}
```

## What Makes This Strong For This Repo

- It matches the repo’s existing agent, orchestrator, and router patterns.
- It supports both single-purpose agents and full workflow orchestration.
- It makes review and validation first-class steps.
- It is safe by default with explicit policies and fallbacks.
- It is flexible enough for Spring, React, docs, analysis, and code review use cases.

This is the reason this schema is a good fit here.

- What it does: aligns the schema with the project’s current agent patterns.
- Why we need it: avoids introducing a generic design that does not fit the repo.

## Summary

- `orchestration` controls global execution behavior.
- `agents` define specialized workers.
- `workflows` define multi-step execution.
- `routing` selects the right agent or workflow.
- `policies`, `memory`, and `observability` make it enterprise-ready.
