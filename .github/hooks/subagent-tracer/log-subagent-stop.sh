#!/bin/bash
set -euo pipefail

INPUT=$(cat)

SESSION_ID=$(printf '%s' "$INPUT" | jq -r '.sessionId // ""')
AGENT_NAME=$(printf '%s' "$INPUT" | jq -r '.agentName // ""')
TRANSCRIPT_PATH=$(printf '%s' "$INPUT" | jq -r '.transcriptPath // ""')
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

SUBAGENT_ID=$(printf '%s' "${SESSION_ID}|${AGENT_NAME}|${TRANSCRIPT_PATH}" | shasum -a 256 | awk '{print substr($1,1,12)}')
COUNT_FILE="logs/copilot/subagent-counts/${SESSION_ID}.count"
if [[ -f "$COUNT_FILE" ]]; then
  SUBAGENT_COUNT=$(cat "$COUNT_FILE")
else
  SUBAGENT_COUNT=0
fi

mkdir -p logs/copilot

echo "{\"timestamp\":\"$TIMESTAMP\",\"event\":\"subagentStop\",\"sessionId\":\"$SESSION_ID\",\"subagentId\":\"$SUBAGENT_ID\",\"subagentCount\":$SUBAGENT_COUNT,\"agentName\":\"$AGENT_NAME\"}" >> logs/copilot/subagents.log

exit 0
