#!/bin/bash
set -euo pipefail

mkdir -p logs/copilot

TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
SKILL_NAME="skill-usage-logger"
WORKDIR=$(pwd)

echo "{\"timestamp\":\"$TIMESTAMP\",\"event\":\"skillUsed\",\"skillName\":\"$SKILL_NAME\",\"cwd\":\"$WORKDIR\"}" >> logs/copilot/skills.log

exit 0
