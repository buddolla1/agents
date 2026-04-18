#!/bin/bash
set -euo pipefail

INPUT=$(cat)

TOOL_NAME=$(printf '%s' "$INPUT" | jq -r '.toolName // ""')
if [[ "$TOOL_NAME" != "task" ]]; then
  exit 0
fi

AGENT_NAME=$(printf '%s' "$INPUT" | jq -r '.agentName // "orchestrator"')

TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
mkdir -p logs/copilot

echo "{\"timestamp\":\"$TIMESTAMP\",\"event\":\"orchestratorTask\",\"toolName\":\"$TOOL_NAME\",\"agentName\":\"$AGENT_NAME\"}" >> logs/copilot/subagents.log

exit 0
