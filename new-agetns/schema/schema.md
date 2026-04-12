There is no single official universal “agent.json schema” across all Copilot-style systems—different tools (VS Code Copilot extensions, custom agent frameworks, internal copilots) define slightly different formats.

But in practice, most agent.json files follow a common de-facto schema like this:

✅ Standard agent.json Schema (Practical Copilot Agent Model)
{
"agentName": "string",
"description": "string",
"version": "string",

"model": {
"provider": "openai | azure | local | custom",
"name": "gpt-4.1 | gpt-5-mini | etc",
"temperature": 0.0
},

"systemPrompt": "string",

"skills": [
"skill-id-1",
"skill-id-2"
],

"actions": [
{
"id": "string",
"skillPromptId": "string",
"description": "string",
"input": {},
"output": "markdown | json | code | text"
}
],

"triggers": [
{
"type": "file-save | command | manual | schedule | git-hook",
"command": "string",
"filePatterns": [
"**/*.java",
"pom.xml"
]
}
],

"context": {
"includeFiles": [
"**/*"
],
"excludeFiles": [
"target/**",
"node_modules/**"
],
"maxTokens": 8000
},

"memory": {
"enabled": true,
"scope": "workspace | project | session"
},

"uiSettings": {
"showInlineSuggestions": true,
"showChatPanel": true,
"autoRunActions": false
},

"logging": {
"level": "info | debug | error",
"storeRuns": true
}
}
🧠 Key Sections Explained
1️⃣ Core Identity
"agentName", "description", "version"

Defines what the agent is and its versioning.

2️⃣ Model Configuration
"model": {
"provider": "openai",
"name": "gpt-4.1"
}

Controls which LLM powers the agent.

3️⃣ System Prompt
"systemPrompt": "You are a Spring Boot migration expert..."

This is the brain behavior definition of the agent.

4️⃣ Skills
"skills": ["SpringBootMigration"]

Links to external skill JSON files (like your migration prompts).

👉 Skills = knowledge packs
👉 Agent = orchestrator

5️⃣ Actions (MOST IMPORTANT)

Each action defines a task the agent can execute:

{
"id": "fix-code",
"skillPromptId": "code-fixes",
"description": "Suggest code changes for Spring Boot 4.x"
}

✔ Maps to skill instructions
✔ Executable unit of work
✔ Can be triggered individually

6️⃣ Triggers

Defines when the agent runs automatically:

{
"type": "file-save",
"filePatterns": ["pom.xml", "**/*.java"]
}

Common triggers:

file-save → run on save
command → manual execution
git-hook → pre-commit / post-commit
schedule → periodic runs
7️⃣ Context Window Control

Controls what the agent can “see”:

"context": {
"includeFiles": ["**/*"],
"excludeFiles": ["target/**"]
}

Important for large enterprise codebases.

8️⃣ Memory (optional but powerful)
"memory": {
"enabled": true,
"scope": "workspace"
}

Used for:

remembering architecture decisions
migration history
repeated fixes
9️⃣ UI Behavior
"uiSettings": {
"showInlineSuggestions": true
}

Controls developer experience inside IDE.

🔥 Mental Model (Very Important)

Think of it like this:

agent.json
├── defines WHO the agent is
├── systemPrompt = personality/brain
├── skills = knowledge base
├── actions = what it can DO
├── triggers = when it runs
└── context = what it can see


