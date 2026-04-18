# Logging Subagent Activity Guide

## Overview

This guide teaches you how to implement comprehensive logging for subagent activity in your multi-agent orchestration system. It covers observability configuration, logging patterns, log formats, and troubleshooting strategies.

---

## 1. Observability Configuration in Agent Schema

### Basic Logging Setup

Add a `logging` section to your `agent.json` or `agent.md` file:

```json
{
  "name": "my-subagent",
  "description": "A sample subagent with logging",
  "observability": {
    "logging": {
      "enabled": true,
      "level": "INFO",
      "format": "json",
      "includeContext": true,
      "redactFields": ["apiKey", "password", "token"]
    },
    "tracing": {
      "enabled": true,
      "samplingRate": 0.1
    },
    "metrics": [
      "latency",
      "cost",
      "success-rate",
      "step-failure-rate"
    ],
    "exporters": ["stdout", "datadog", "splunk"]
  }
}
```

### Key Parameters

| Parameter | Purpose | Default |
|-----------|---------|---------|
| `enabled` | Turn logging on/off | `true` |
| `level` | Log level (DEBUG, INFO, WARN, ERROR) | `INFO` |
| `format` | Output format (json, text) | `json` |
| `includeContext` | Include parent/child trace IDs | `true` |
| `redactFields` | PII/sensitive fields to mask | `[]` |

---

## 2. Log Message Format

### Standard Log Structure

Each log entry should follow this structure:

```json
{
  "timestamp": "2026-04-18T14:40:52Z",
  "traceId": "550e8400-e29b-41d4-a716-446655440000",
  "parentAgentId": "orchestrator-main",
  "subagentId": "subagent-planner",
  "taskId": "task-12345",
  "level": "INFO",
  "event": "subagentStarted",
  "duration": 0,
  "status": "initiated",
  "metadata": {
    "skill": "planning",
    "input_tokens": 150,
    "max_tokens": 1000
  }
}
```

### Log Event Types

| Event | When Logged | Key Fields |
|-------|-----------|-----------|
| `subagentStarted` | Subagent begins execution | `subagentId`, `taskId`, `skill` |
| `subagentCompleted` | Subagent finishes successfully | `duration`, `output_tokens`, `cost` |
| `subagentFailed` | Subagent encounters error | `errorCode`, `errorMessage`, `retryCount` |
| `skillExecuted` | Individual skill completes | `skillName`, `latency`, `stepIndex` |
| `contextPropagated` | Trace context forwarded to child | `childAgentId`, `traceId` |

---

## 3. Logging at Each Stage

### Stage 1: Parent Agent Initiates Subagent

```json
{
  "timestamp": "2026-04-18T14:40:52Z",
  "traceId": "550e8400-e29b-41d4-a716-446655440000",
  "parentAgentId": "orchestrator",
  "subagentId": "planner",
  "taskId": "task-12345",
  "level": "INFO",
  "event": "subagentStarted",
  "metadata": {
    "parentSkills": ["plan", "execute", "review"],
    "input": "Create a guide for logging"
  }
}
```

### Stage 2: Subagent Completes

```json
{
  "timestamp": "2026-04-18T14:41:10Z",
  "traceId": "550e8400-e29b-41d4-a716-446655440000",
  "parentAgentId": "orchestrator",
  "subagentId": "planner",
  "taskId": "task-12345",
  "level": "INFO",
  "event": "subagentCompleted",
  "duration": 18000,
  "status": "success",
  "metadata": {
    "output_tokens": 450,
    "cost": 0.00045,
    "stepsTaken": 3
  }
}
```

### Stage 3: Error Handling

```json
{
  "timestamp": "2026-04-18T14:41:45Z",
  "traceId": "550e8400-e29b-41d4-a716-446655440000",
  "parentAgentId": "orchestrator",
  "subagentId": "implementer",
  "taskId": "task-12345",
  "level": "ERROR",
  "event": "subagentFailed",
  "status": "failed",
  "metadata": {
    "errorCode": "TIMEOUT",
    "errorMessage": "Subagent exceeded 5s timeout",
    "retryAttempt": 1,
    "retryScheduled": true
  }
}
```

---

## 4. Context Propagation

### Maintaining Trace Continuity

When a parent agent spawns subagents, include trace context:

```json
{
  "parentTraceId": "550e8400-e29b-41d4-a716-446655440000",
  "subagentTraceId": "550e8400-e29b-41d4-a716-446655440001",
  "correlationId": "workflow-12345",
  "timestamp": "2026-04-18T14:40:52Z"
}
```

This enables:
- ✅ End-to-end request tracing
- ✅ Identifying bottlenecks across agents
- ✅ Correlating related logs across multiple systems

---

## 5. Exporting Logs

### Configuration by Platform

**Stdout (Development)**
```json
{
  "exporters": ["stdout"]
}
```

**Splunk (Enterprise)**
```json
{
  "exporters": ["splunk"],
  "splunk": {
    "endpoint": "https://your-instance.splunkcloud.com",
    "port": 8088,
    "token": "${SPLUNK_HEC_TOKEN}",
    "index": "subagent_logs"
  }
}
```

**Datadog (SaaS)**
```json
{
  "exporters": ["datadog"],
  "datadog": {
    "apiKey": "${DD_API_KEY}",
    "site": "datadoghq.com",
    "tags": ["env:production", "service:orchestrator"]
  }
}
```

---

## 6. Redacting Sensitive Data

### Automatic Field Masking

```json
{
  "observability": {
    "logging": {
      "redactFields": [
        "apiKey",
        "password",
        "token",
        "ssn",
        "creditCard",
        "authorization"
      ]
    }
  }
}
```

### Before Redaction
```json
{
  "event": "apiCall",
  "apiKey": "sk-abc123xyz",
  "password": "secretPass123"
}
```

### After Redaction
```json
{
  "event": "apiCall",
  "apiKey": "[REDACTED]",
  "password": "[REDACTED]"
}
```

---

## 7. Troubleshooting Common Issues

### Issue: Logs Not Appearing

**Checklist:**
- [ ] `logging.enabled` is `true`
- [ ] `exporters` array includes at least one exporter
- [ ] Log level threshold is met (e.g., event is INFO or higher if level is INFO)
- [ ] Exporter credentials are valid and endpoint is reachable
- [ ] Check for silent failures in error logs

**Debug Command:**
```bash
grep -i "error\|warning" logs/copilot/*.log | head -20
```

### Issue: Missing Context or Trace IDs

**Solution:**
- Ensure `includeContext: true` in observability config
- Verify parent agent is propagating `traceId` to subagents
- Check that `correlationId` is consistent across all related logs

### Issue: High Log Volume or Cost

**Solution:**
- Reduce `samplingRate` for tracing
- Lower log `level` from DEBUG to INFO
- Filter exporters to only essential platforms
- Archive old logs to reduce storage cost

---

## 8. Example: Complete Orchestrator Logging

```json
{
  "name": "orchestrator-with-logging",
  "description": "3-step orchestrator with full logging",
  "subagents": [
    {
      "name": "planner",
      "role": "Plan creation"
    },
    {
      "name": "implementer",
      "role": "Implementation"
    },
    {
      "name": "reviewer",
      "role": "Review & validation"
    }
  ],
  "observability": {
    "logging": {
      "enabled": true,
      "level": "INFO",
      "format": "json",
      "includeContext": true,
      "redactFields": ["apiKey", "token", "password"]
    },
    "tracing": {
      "enabled": true,
      "samplingRate": 0.5
    },
    "metrics": [
      "latency",
      "cost",
      "success-rate",
      "step-failure-rate"
    ],
    "exporters": ["stdout", "splunk"]
  }
}
```

---

## 9. Best Practices

| Practice | Benefit |
|----------|---------|
| Use structured JSON logging | Enables easy parsing and querying |
| Include trace IDs in all logs | Supports end-to-end debugging |
| Set appropriate log levels | Reduces noise, focuses on important events |
| Redact PII automatically | Ensures compliance and security |
| Monitor metrics (latency, cost) | Enables cost optimization and performance tuning |
| Archive logs to cold storage | Reduces active log storage costs |

---

## 10. Quick Start

1. Add `observability` section to your `agent.json`
2. Set `logging.enabled: true` and choose exporters
3. Deploy and verify logs appear in your chosen platform
4. Configure alerting on ERROR and high-latency events
5. Review logs weekly for patterns and optimization opportunities

---

**Need help?** Refer to [Multi-Skill-Orchestrator-agent.md](./Multi-Skill-Orchestrator-agent.md) or [splunk-info.md](./splunk-info.md) for platform-specific guidance.

