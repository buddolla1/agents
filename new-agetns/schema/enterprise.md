# Enterprise `agents.json` Schema

This document describes a practical enterprise-grade schema for `agents.json` in this repository. It is designed for multi-agent orchestration, governed execution, reusable skills, and auditable outputs.

## What This Schema Should Solve

- Route requests to the right agent or workflow.
- Break complex work into multiple steps.
- Support planning, execution, review, and validation.
- Enforce policies for security, compliance, and safety.
- Capture traces, logs, and artifacts for later review.

## Recommended Top-Level Structure

```json
{
  "version": "1.0",
  "discovery": {},
  "enterprise": {},
  "environment": {},
  "orchestration": {},
  "agents": [],
  "workflows": [],
  "skills": [],
  "tools": [],
  "routing": {},
  "policies": {},
  "memory": {},
  "observability": {},
  "artifacts": {},
  "versioning": {},
  "featureFlags": {},
  "costControls": {},
  "defaults": {}
}
```

## Enterprise Layer

The enterprise layer defines org-wide context and defaults.

```json
{
  "enterprise": {
    "name": "Acme Corp",
    "domain": "software-engineering",
    "region": "us-east-1",
    "compliance": ["SOC2", "GDPR"],
    "defaultModel": "gpt-5.2"
  }
}
```

- What it does: stores shared organization-level metadata.
- Why we need it: keeps the same runtime behavior across teams, projects, and environments.

## Environment Layer

The environment layer controls deployment-specific behavior.

```json
{
  "environment": {
    "name": "prod",
    "mode": "local | dev | staging | prod",
    "region": "us-east-1",
    "allowNetwork": false,
    "logLevel": "info"
  }
}
```

- What it does: defines where and how the agent system runs.
- Why we need it: prevents dev-only settings from leaking into production.

## Discovery Layer

Discovery controls how the agent finds files, configs, and external dependencies before it generates any document or runs any workflow.

```json
{
  "discovery": {
    "fileSearch": {
      "include": [
        "**/*.java",
        "**/*.md",
        "**/*.json",
        "**/*.yml",
        "**/*.yaml",
        "src/main/resources/**"
      ],
      "exclude": [
        "target/**",
        "build/**",
        "node_modules/**",
        ".git/**"
      ],
      "priority": [
        "src/main/resources/application.yaml",
        "src/main/resources/application.yml",
        "src/main/resources/bootstrap.yaml",
        "src/main/resources/bootstrap.yml"
      ]
    },
    "externalApiScan": {
      "enabled": true,
      "sourceFiles": [
        "src/main/resources/application.yaml",
        "src/main/resources/application.yml",
        "src/main/resources/bootstrap.yaml",
        "src/main/resources/bootstrap.yml"
      ],
      "matchKeys": [
        "base-url",
        "baseUrl",
        "url",
        "uri",
        "endpoint",
        "host",
        "port",
        "service",
        "client",
        "api",
        "oauth",
        "token",
        "api-key"
      ],
      "extract": [
        "service names",
        "external API base URLs",
        "client identifiers",
        "auth settings",
        "feature flags that gate external calls"
      ]
    },
    "outputContract": {
      "format": "markdown",
      "preserveSourceFormat": true,
      "strictSectionOrder": true,
      "requiredSections": [
        "Overview",
        "Discovered Files",
        "External APIs",
        "Workflow",
        "Findings",
        "Recommendations"
      ]
    }
  }
}
```

- What it does: makes file selection, config scanning, and output formatting explicit.
- Why we need it: prevents missed files, missed APIs, and inconsistent generated documents.

## Orchestration Layer

Orchestration defines how multiple agents work together.

```json
{
  "orchestration": {
    "strategy": "sequential | parallel | hierarchical | hybrid | adaptive",
    "dynamicAgents": true,
    "allowDelegation": true,
    "maxParallelAgents": 4,
    "taskDistribution": "balanced | chunked | capability-based",
    "aggregation": {
      "mergeStrategy": "risk-priority | confidence-priority | last-write-wins",
      "deduplicate": true
    },
    "fallback": {
      "mode": "safe-stop | safe-continue | reroute",
      "defaultWorkflowId": "safe-default-workflow"
    }
  }
}
```

- What it does: controls scaling, delegation, and result aggregation.
- Why we need it: makes multi-agent execution predictable instead of ad hoc.

## Agent Schema

Each agent should have one clear responsibility.

```json
{
  "id": "repo-analyzer",
  "name": "Repository Analyzer",
  "type": "analyzer | planner | executor | reviewer | orchestrator | router",
  "role": "Inspects repository structure and identifies the task scope",
  "model": "gpt-5.2",
  "skills": ["repo-analysis", "dependency-analysis"],
  "tools": ["filesystem", "git"],
  "memoryEnabled": true,
  "canDelegate": false,
  "canSpawnAgents": false,
  "constraints": {
    "maxTokens": 8192,
    "timeoutMs": 60000
  }
}
```

- What it does: defines the capabilities and limits of a single agent.
- Why we need it: prevents overlapping responsibilities and unclear handoffs.

## Workflow Schema

Workflows define multi-step execution.

```json
{
  "id": "repo-change-workflow",
  "name": "Repository Change Workflow",
  "trigger": "api | event | manual | schedule",
  "mode": "sequential | parallel | hybrid",
  "ownerAgentId": "repo-analyzer",
  "steps": [
    {
      "id": "analyze",
      "type": "agent-call",
      "agentId": "repo-analyzer",
      "outputKey": "analysis"
    },
    {
      "id": "implement",
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
      "type": "agent-call",
      "agentId": "review-agent",
      "dependsOn": ["implement"],
      "input": {
        "changes": "{{changes}}"
      },
      "outputKey": "review"
    }
  ],
  "artifacts": {
    "storeOutputs": true,
    "path": ".agent/output",
    "format": "json"
  }
}
```

- What it does: turns a task into an explicit execution path.
- Why we need it: makes the system auditable, testable, and recoverable.

## Step Schema

Steps should be small and deterministic.

```json
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
```

- What it does: defines one unit of work inside a workflow.
- Why we need it: reduces complexity and isolates failures.

## Strategy Schema

Strategy selects the best workflow or agent based on project signals.

```json
{
  "id": "migration-strategy",
  "name": "Migration Strategy",
  "decisionEngine": {
    "type": "rule-based | llm-based | hybrid",
    "temperature": 0.1
  },
  "signals": ["repo.size", "repo.type", "tests.coverage", "risk.level"],
  "rules": [
    {
      "if": "repo.hasMultipleModules == true",
      "then": {
        "workflowId": "multi-module-migration-workflow"
      }
    }
  ],
  "fallback": {
    "workflowId": "safe-default-workflow",
    "reason": "Use the safest path when confidence is low"
  }
}
```

- What it does: decides what should run before execution starts.
- Why we need it: avoids hardcoding one path for every request.

## Routing Schema

Routing connects intent to the right agent or workflow.

```json
{
  "strategy": "rule-based | confidence-based | llm-router | hybrid",
  "defaultAgentId": "repo-analyzer",
  "rules": [
    {
      "match": "review|verify|audit",
      "targetAgentId": "review-agent",
      "minConfidence": 0.8
    }
  ],
  "askClarificationWhenUncertain": true
}
```

- What it does: sends requests to the right agent or workflow.
- Why we need it: prevents wrong-agent execution and reduces user back-and-forth.

## Skills Layer

Skills are reusable knowledge modules shared by agents.

```json
{
  "id": "dependency-analysis",
  "name": "Dependency Analysis",
  "description": "Detects dependency issues and upgrade risks",
  "type": "analysis | transformation | generation",
  "implementation": "prompt | code | toolchain"
}
```

- What it does: packages reusable expertise for many agents.
- Why we need it: avoids duplicating the same logic across agents.

## Tools Layer

Tools connect agents to real systems.

```json
{
  "id": "filesystem",
  "type": "filesystem | git | api | db | webhook",
  "name": "Filesystem Access",
  "authType": "none | api_key | oauth | token",
  "config": {}
}
```

- What it does: gives agents access to files, repositories, APIs, and services.
- Why we need it: makes the system operational, not just conversational.

## External API Discovery Rules

When the task is documentation, analysis, or architecture generation, the agent should always inspect application configuration for outbound dependencies.

- Scan `src/main/resources/application.yaml` first, then `application.yml`, then bootstrap variants.
- Prefer explicit file reads over keyword-only search.
- Extract every external API, service URL, and integration host defined in configuration.
- Correlate config values with controllers, clients, SDKs, and HTTP adapters found elsewhere in the repository.
- If an external API is present, include it in the document output under a dedicated `External APIs` section.
- If no external API is found, state that explicitly instead of omitting the section.

## Policies Layer

Policies enforce safety and governance.

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
    "maxConcurrentSteps": 4
  }
}
```

- What it does: limits unsafe behavior and controls sensitive operations.
- Why we need it: enterprise systems need guardrails, not just capabilities.

## Memory Layer

Memory stores useful context across steps or sessions.

```json
{
  "enabled": true,
  "type": "short-term | long-term | vector-store | hybrid",
  "provider": "redis | postgres | pinecone | local",
  "retentionDays": 30,
  "scope": "session | workflow | project | enterprise"
}
```

- What it does: preserves context for later reasoning and reuse.
- Why we need it: keeps multi-step work consistent and reduces repeated analysis.

## Observability Layer

Observability helps debug and audit the system.

```json
{
  "logging": true,
  "tracing": true,
  "metrics": ["latency", "cost", "success-rate", "step-failure-rate"],
  "exporters": ["prometheus", "datadog"],
  "redactSensitiveFields": true
}
```

- What it does: captures traces, metrics, and logs from execution.
- Why we need it: helps explain failures and control runtime cost.

## Artifacts Layer

Artifacts store outputs from execution.

```json
{
  "store": true,
  "basePath": ".agent/output",
  "formats": ["json", "markdown", "txt"],
  "includeTrace": true
}
```

- What it does: keeps generated files and reports in a predictable location.
- Why we need it: lets humans and downstream steps inspect results.

## Versioning Layer

Versioning makes the schema safe to evolve.

```json
{
  "agents": "semver",
  "workflows": "semver",
  "schema": "semver",
  "config": "git-sha"
}
```

- What it does: tracks changes to agents, workflows, and config.
- Why we need it: supports rollback and compatibility management.

## Feature Flags

Feature flags let you roll out new behavior safely.

```json
{
  "enableParallelAgents": true,
  "enableAdaptiveRouting": true,
  "enableHumanApproval": true
}
```

- What it does: toggles capabilities without changing the whole schema.
- Why we need it: helps ship changes gradually and safely.

## Cost Controls

Cost controls prevent runaway execution.

```json
{
  "maxTokensPerRequest": 5000,
  "maxTokensPerWorkflow": 20000,
  "budgetPerDay": 100
}
```

- What it does: limits token usage and daily spend.
- Why we need it: enterprise systems need predictable operating costs.

## Defaults

Defaults reduce repetition across the config.

```json
{
  "model": "gpt-5.2",
  "timeoutMs": 60000,
  "retry": {
    "maxAttempts": 3,
    "backoffMs": 1000
  }
}
```

- What it does: supplies shared fallback values for agents and workflows.
- Why we need it: keeps the config smaller and more consistent.

## Recommended Execution Model

Use this order for most enterprise tasks:

1. Route the request.
2. Run a file discovery pass.
3. Scan configuration files for `application.yaml` and external APIs.
4. Run an analyzer or planner.
5. Execute the workflow steps.
6. Review the results.
7. Store artifacts and traces.

This structure works well for code review, migration, analysis, and documentation agents in this repository.

## Strict Output Rule

All generated documents must preserve the requested output format.

- If the input asks for Markdown, output Markdown only.
- If the input asks for JSON, output JSON only.
- If the input asks for a specific document structure, keep the same heading order and section names.
- Do not mix formats unless the user explicitly requests a conversion.
- If a source document already has a format convention, mirror that convention in the generated output.

## Recommended Example

```json
{
  "version": "1.0",
  "enterprise": {
    "name": "Acme Corp",
    "domain": "software-engineering",
    "region": "us-east-1",
    "compliance": ["SOC2", "GDPR"],
    "defaultModel": "gpt-5.2"
  },
  "environment": {
    "name": "prod",
    "mode": "prod",
    "region": "us-east-1",
    "allowNetwork": false,
    "logLevel": "info"
  },
  "orchestration": {
    "strategy": "hierarchical",
    "dynamicAgents": true,
    "allowDelegation": true,
    "maxParallelAgents": 4,
    "taskDistribution": "capability-based"
  },
  "agents": [
    {
      "id": "repo-analyzer",
      "name": "Repository Analyzer",
      "type": "analyzer",
      "role": "Inspects repository structure and identifies the task scope",
      "model": "gpt-5.2",
      "skills": ["repo-analysis"],
      "tools": ["filesystem", "git"],
      "memoryEnabled": true,
      "canDelegate": false,
      "canSpawnAgents": false
    },
    {
      "id": "implementation-agent",
      "name": "Implementation Agent",
      "type": "executor",
      "role": "Applies required code or configuration changes",
      "model": "gpt-5.2",
      "skills": ["code-editing"],
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
      "skills": ["code-review"],
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
      "trigger": "api",
      "mode": "hybrid",
      "ownerAgentId": "repo-analyzer",
      "steps": [
        {
          "id": "analyze",
          "type": "agent-call",
          "agentId": "repo-analyzer",
          "outputKey": "analysis"
        },
        {
          "id": "implement",
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
          "type": "agent-call",
          "agentId": "review-agent",
          "dependsOn": ["implement"],
          "input": {
            "changes": "{{changes}}"
          },
          "outputKey": "review"
        }
      ]
    }
  ],
  "routing": {
    "strategy": "hybrid",
    "defaultAgentId": "repo-analyzer",
    "rules": [
      {
        "match": "review|verify|audit",
        "targetAgentId": "review-agent",
        "minConfidence": 0.8
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
    "metrics": ["latency", "cost", "success-rate"],
    "exporters": ["prometheus", "datadog"],
    "redactSensitiveFields": true
  },
  "artifacts": {
    "store": true,
    "basePath": ".agent/output",
    "formats": ["json", "markdown"]
  },
  "versioning": {
    "agents": "semver",
    "workflows": "semver",
    "schema": "semver",
    "config": "git-sha"
  },
  "featureFlags": {
    "enableParallelAgents": true,
    "enableAdaptiveRouting": true,
    "enableHumanApproval": true
  },
  "costControls": {
    "maxTokensPerRequest": 5000,
    "maxTokensPerWorkflow": 20000,
    "budgetPerDay": 100
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

## Summary

This schema gives you a strong enterprise baseline for this repo:

- clear org context
- explicit orchestration
- modular agents
- multi-step workflows
- routing and fallback
- policies and guardrails
- memory and observability
- versioning, flags, and cost control
