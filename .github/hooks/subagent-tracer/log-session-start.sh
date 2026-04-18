#!/bin/bash
set -euo pipefail

INPUT=$(cat)

TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
mkdir -p logs/copilot

echo "{\"timestamp\":\"$TIMESTAMP\",\"event\":\"sessionStart\",\"source\":\"subagent-tracer\",\"agentName\":\"orchestrator\"}" >> logs/copilot/session.log

exit 0
