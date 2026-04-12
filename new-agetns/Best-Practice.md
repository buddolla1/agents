1. Orchestrator Agent (Best Practice)

Instead of Agent2 calling Agent1, create a third “orchestrator” agent:

User → Orchestrator Agent → (calls Agent1 + Agent2)

Example flow:

Orchestrator:
Calls Agent1 (code analysis)
Takes output
Passes it to Agent2 (PR creation / review)

👉 This is the cleanest and scalable approach (you’ve already been heading this direction 👍)




Shared Context / Output Files

A simpler workaround:

Agent1 writes output → review.md or JSON
Agent2 reads that file

Flow:

Agent1 → generates review.json
Agent2 → reads review.json → creates PR
Agent2 → reads review.json → creates PR