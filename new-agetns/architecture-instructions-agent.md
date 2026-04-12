{
  "name": "architecture-instructions-agent",
  "description": "Scalable architecture analyzer with dynamic chunking, Mermaid diagrams, and auto-update on PRs",
  "version": "5.0",
  "entry": "generate-instructions",
  "tools": ["filesystem", "search", "codebase", "git"],

  "strategy": {
    "type": "parallel",
    "maxConcurrency": 5
  },

  "workflows": {
    "generate-instructions": [
      "discover-modules",
      "dynamic-chunking",
      "parallel-analysis",
      "aggregate-results",
      "generate-visual-diagram",
      "generate-instructions-file",
      "auto-pr-update"
    ]
  },

  "actions": {

    "discover-modules": {
      "type": "inline",
      "prompt": "Scan the repository and list all top-level modules (services, backend, frontend, shared libs). Output JSON array with name, path, type."
    },

    "dynamic-chunking": {
      "type": "inline",
      "prompt": "For any module/folder with >500 files or >10k LOC, split into sub-modules for parallel analysis. Output JSON array of all final chunks with name, path, type."
    },

    "parallel-analysis": {
      "type": "parallel",
      "foreach": "dynamic-chunking",
      "maxConcurrency": 5,
      "actions": [
        "scan-module",
        "detect-module-architecture"
      ]
    },

    "scan-module": {
      "type": "inline",
      "prompt": "Analyze a module: detect language, frameworks, build tools, folder structure, dependencies. Return JSON."
    },

    "detect-module-architecture": {
      "type": "inline",
      "prompt": "Detect architecture style, layer usage, integration patterns, and anti-patterns for this module. Return JSON."
    },

    "aggregate-results": {
      "type": "inline",
      "prompt": "Combine all module-level outputs into a global architecture summary, tech stack, patterns, and anti-patterns. Return JSON."
    },

    "generate-visual-diagram": {
      "type": "inline",
      "prompt": "Using aggregated results, generate a Mermaid diagram showing:\n- Modules/services\n- Layers (Controller/Service/Repo/Frontend)\n- Integration flows (REST, Messaging, DB)\nReturn Markdown snippet:\n```\n```mermaid\ngraph TD\n<diagram-content>\n```\n```"
    },

    "generate-instructions-file": {
      "type": "inline",
      "prompt": "Use aggregated results and Mermaid diagram to generate `instructions.md`. Include:\n- Architecture overview\n- Tech stack\n- Coding standards\n- Backend, Frontend, Integration guidelines\n- Anti-patterns\n- Testing, Security, Performance\n- Copilot enforcement rules\n- Mermaid diagram embedded\nOutput Markdown only, save as instructions.md."
    },

    "auto-pr-update": {
      "type": "inline",
      "prompt": "Detect if any module files changed in the PR. If yes:\n1. Regenerate `instructions.md` with latest architecture and Mermaid diagram.\n2. Commit changes automatically to a new branch (e.g., `update-instructions`) and create a PR to main branch.\n3. Include PR description summarizing updated modules, tech stack changes, or new patterns detected.\n4. If no relevant changes, skip PR creation.\nReturn PR URL or skip message."
    }

  },

  "outputs": [
    {
      "type": "file",
      "path": "instructions.md"
    },
    {
      "type": "url",
      "path": "pr-url"
    }
  ]
}