#!/bin/bash
set -euo pipefail

INPUT=$(cat)

SESSION_ID=$(printf '%s' "$INPUT" | jq -r '.sessionId // ""')
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
PROMPT_TEXT=$(printf '%s' "$INPUT" | jq -r '.prompt // .text // ""')

mkdir -p logs/copilot

echo "{\"timestamp\":\"$TIMESTAMP\",\"event\":\"userPromptSubmitted\",\"sessionId\":\"$SESSION_ID\",\"promptLength\":${#PROMPT_TEXT}}" >> logs/copilot/prompts.log

exit 0
