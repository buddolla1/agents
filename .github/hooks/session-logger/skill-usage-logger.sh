#!/bin/bash
# Log skill usage events
set -euo pipefail

# Skip if logging disabled
if [[ "${SKIP_LOGGING:-}" == "true" ]]; then
  exit 0
fi

# Read input from Copilot (contains skill usage info)
INPUT=$(cat)

# Create logs directory if it doesn't exist
mkdir -p logs/copilot

# Extract timestamp
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# Parse skill details from input (assuming JSON format)
# Extract skill name, agent, duration, etc. if available
SKILL_NAME=$(echo "$INPUT" | jq -r '.skill // "unknown"' 2>/dev/null || echo "unknown")
AGENT_ID=$(echo "$INPUT" | jq -r '.agentId // "unknown"' 2>/dev/null || echo "unknown")
DURATION=$(echo "$INPUT" | jq -r '.duration // 0' 2>/dev/null || echo "0")
STATUS=$(echo "$INPUT" | jq -r '.status // "completed"' 2>/dev/null || echo "completed")

# Log skill usage (use jq for proper JSON encoding if available)
if command -v jq >/dev/null 2>&1; then
  jq -Rn --arg timestamp "$TIMESTAMP" --arg skill "$SKILL_NAME" --arg agent "$AGENT_ID" --arg duration "$DURATION" --arg status "$STATUS" '{"timestamp":$timestamp,"event":"skillUsed","skill":$skill,"agentId":$agent,"duration":$duration|tonumber,"status":$status}' >> logs/copilot/skills.log
else
  echo "{\"timestamp\":\"$TIMESTAMP\",\"event\":\"skillUsed\",\"skill\":\"$SKILL_NAME\",\"agentId\":\"$AGENT_ID\",\"duration\":$DURATION,\"status\":\"$STATUS\"}" >> logs/copilot/skills.log
fi

exit 0
