To ensure all sub-agents use the same model, you need centralized model configuration and inheritance in your agent architecture. The exact method depends on how your Copilot-style agent framework is structured, but the core idea is:

🔹 Define the model once at the parent level
🔹 Make all sub-agents inherit or reference it
🔹 Prevent local overrides unless explicitly needed

Here are the common ways to do it:

✅ 1. Parent Agent Controls the Model (Best Practice)

Create a root/manager agent that defines the model, and sub-agents inherit it.

Example: agent.json
{
"name": "enterprise-root-agent",
"model": "gpt-4.1",
"subAgents": [
{ "ref": "./agents/code-review-agent.json" },
{ "ref": "./agents/test-generator-agent.json" },
{ "ref": "./agents/doc-generator-agent.json" }
]
}
Sub-agents (no model defined)
{
"name": "code-review-agent",
"description": "Reviews Java code quality"
}
✔ Result

All sub-agents automatically use gpt-4.1 because they inherit from the parent.

✅ 2. Use Environment-Level Model Configuration

If your agents run via scripts, CI/CD, or IDE plugins, define the model globally:

Example .env
COPILOT_MODEL=gpt-4.1
Example Runner Code
const model = process.env.COPILOT_MODEL;
agentRunner.run({ model });
✔ Result

No agent can accidentally use a different model.

✅ 3. Shared Base Config File (Monorepo Friendly)

Create a shared config file that all agents import.

base-agent-config.json
{
"model": "gpt-4.1",
"temperature": 0.2,
"maxTokens": 8000
}
Sub-agent
{
"name": "test-agent",
"extends": "../base-agent-config.json"
}
✔ Result

Any change to base config updates all agents instantly.

✅ 4. Enforce Model via Agent Orchestrator (Advanced)

If you're using an orchestrator or multi-agent framework:

Example Orchestrator Rule
agentDefaults:
model: gpt-4.1
allowOverride: false
✔ Result

Even if a sub-agent specifies another model, it will be ignored.

✅ 5. IDE-based Copilot Custom Agents

If using custom agents inside:

GitHub Copilot
Visual Studio Code
IntelliJ IDEA

You must set the model in:

Workspace Settings
{
"github.copilot.chat.model": "gpt-4.1"
}

This forces all agents in that workspace to use the same model.

🚫 What to Avoid

❌ Defining model separately in each sub-agent
❌ Letting different teams modify agent configs independently
❌ Hardcoding models inside skills/actions
❌ Allowing runtime overrides without governance

🏆 Best Enterprise Pattern

Central Model Governance Layer

                Model Config
                     │
        ┌────────────┼────────────┐
        │            │            │
Agent A      Agent B      Agent C
│            │            │
SubAgents    SubAgents    SubAgents

Change model once → entire agent ecosystem updated.

If you'd like, I can also help you design:

✅ A multi-agent enterprise structure
✅ Model governance for secure networks
✅ Offline-compatible agent runners
✅ Agent.json inheritance patterns
✅ Copilot agents for IntelliJ IDEA or Visual Studio Code