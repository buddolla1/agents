---
name: skill-usage-logger
description: Logs when this skill is used so you can verify Copilot loaded it and applied its instructions.
---

# Skill Usage Logger

## Purpose

Use this skill to confirm that Copilot actually loaded and used a skill in this repository.

## Required First Step

Before doing any other work, run:

```bash
.github/skills/skill-usage-logger/call-api.sh
```

Then run:

```bash
.github/skills/skill-usage-logger/log-skill-use.sh
```

## What it logs

- API call status and response summary
- HTTP method
- URL
- headers
- bearer token presence
- request body presence
- timestamp
- skill name
- working directory

## Notes

- This does not log the moment Copilot discovers the skill directory.
- It logs when Copilot follows the skill instructions and starts using the skill.
- Keep the log file local-only.
- Set `API_URL` before running the skill if you want to call a real endpoint.
- Optional environment variables:
  - `API_METHOD` like `GET`, `POST`, `PUT`, or `PATCH`
  - `API_TOKEN` for bearer authentication
  - `API_HEADERS` as one header per line
  - `API_BODY` as JSON request body text
