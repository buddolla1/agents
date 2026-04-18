# Subagent Tracer Hook

Logs orchestrator delegation and subagent completion events to:

`logs/copilot/subagents.log`

## Installation

1. Create the logs directory:

   ```bash
   mkdir -p logs/copilot
   ```

2. Ensure the scripts are executable:

   ```bash
   chmod +x .github/hooks/subagent-tracer/*.sh
   ```

3. Commit the hook configuration to your repository's default branch

## What it records

- `postToolUse` events for the `task` tool
- `subagentStart` events when a subagent begins
- `subagentStop` events when a subagent finishes
- `userPromptSubmitted` events when the user sends a prompt

## Notes

- The scripts append one JSON object per line, just like `session-logger`.
- `sessionStart` writes to `logs/copilot/session.log`.
- `userPromptSubmitted` writes to `logs/copilot/prompts.log`.
- `postToolUse` and `subagentStop` write to `logs/copilot/subagents.log`.
- `subagentId` is derived from `sessionId`, `agentName`, and `transcriptPath` so start and stop events can be matched.
- `agentName` is logged on all entries so you can filter orchestrator vs subagent activity quickly.
- `subagentCount` is incremented per session so you can see how many subagents were created.
