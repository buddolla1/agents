#!/bin/bash
set -euo pipefail

INPUT=$(cat)

SESSION_ID=$(printf '%s' "$INPUT" | jq -r '.sessionId // ""')
AGENT_NAME=$(printf '%s' "$INPUT" | jq -r '.agentName // ""')
TRANSCRIPT_PATH=$(printf '%s' "$INPUT" | jq -r '.transcriptPath // ""')
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

SUBAGENT_ID=$(printf '%s' "${SESSION_ID}|${AGENT_NAME}|${TRANSCRIPT_PATH}" | shasum -a 256 | awk '{print substr($1,1,12)}')

mkdir -p logs/copilot
mkdir -p logs/copilot/subagent-counts

COUNT_FILE="logs/copilot/subagent-counts/${SESSION_ID}.count"
if [[ -f "$COUNT_FILE" ]]; then
  SUBAGENT_COUNT=$(($(cat "$COUNT_FILE") + 1))
else
  SUBAGENT_COUNT=1
fi
printf '%s' "$SUBAGENT_COUNT" > "$COUNT_FILE"

echo "{\"timestamp\":\"$TIMESTAMP\",\"event\":\"subagentStart\",\"sessionId\":\"$SESSION_ID\",\"subagentId\":\"$SUBAGENT_ID\",\"subagentCount\":$SUBAGENT_COUNT,\"agentName\":\"$AGENT_NAME\"}" >> logs/copilot/subagents.log

exit 0
