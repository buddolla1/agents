---
name: feature-delivery-planner
description: Transform feature.txt into a professional delivery plan with epics, user stories, tasks, dependencies, BDD, Gherkin scenarios, estimates, HLD, LLD, and diagrams. Use when a feature specification must be broken into an enterprise-ready planning document.
---

# Feature Delivery Planner

## Purpose

Use this skill to turn `feature.txt` content into a polished engineering planning document suitable for product, engineering, and QA review.

## Workflow

1. Read the feature text and extract the core outcome, actors, constraints, and implied scope.
2. If the user has not provided sizing inputs, ask for:
   - number of epics
   - number of user stories per epic
   - number of tasks per story
3. Break the feature into epics with clear business intent.
4. Under each epic, create user stories with:
   - title
   - description
   - dependencies
   - story points
   - tasks
5. For each story, include:
   - BDD coverage
   - Gherkin scenarios
   - acceptance criteria
   - test data notes
6. Add an enterprise delivery layer:
   - executive summary
   - assumptions
   - scope boundaries
   - dependency matrix
   - HLD
   - LLD
   - Mermaid diagrams
   - risks
   - next steps

## Output Standards

- Write in formal, professional markdown.
- Keep the structure predictable and presentation-ready.
- Prefer tables for epics, stories, dependencies, and estimates.
- Keep story points consistent across the document.
- Do not guess sizing inputs when they are missing; ask the user first.
- Keep BDD and Gherkin scenarios aligned to the described story behavior.
- Make dependencies explicit and traceable.

## Recommended Output Sections

1. Cover page
2. Feature summary
3. Executive summary
4. Assumptions
5. Scope
6. Epics
7. Story breakdown
8. Dependency matrix
9. Stories
10. BDD coverage
11. Gherkin scenarios
12. Estimate points
13. Test strategy
14. Test data
15. Architecture overview
16. HLD
17. LLD
18. Diagrams
19. Risks
20. Next steps

## Quality Check

Before finalizing, verify that:

- every epic has stories
- every story has a point estimate
- every story has tasks
- dependencies are listed where relevant
- BDD and Gherkin cover the primary flows and edge cases
- the document reads like a delivery artifact, not a rough draft
