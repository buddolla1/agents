# Null Pointer Exception Detection Skill

## Description
This skill scans a Java Spring Boot project for potential Null Pointer Exceptions (NPEs) and interacts with the user to determine the scan scope, report format, and analysis details.

## Interactive Steps

1. **Welcome Prompt**
    - Agent: "Do you want to scan the **full project** or only **recent changes**?"
    - User chooses: `full_project` or `recent_changes`

2. **Optional File Selection** (only for `recent_changes`)
    - Agent: "Do you want to scan **all changed files** or select specific files?"
    - User chooses:
        - `all_files` → proceed with all changed files
        - `select_files` → agent presents a list of changed files for user to pick

3. **Report Format**
    - Agent: "Which report format do you prefer: **Markdown** or **JSON**?"
    - User chooses: `md` or `json` (default `md`)

4. **Null-Safety Enhancement**
    - Agent: "Do you want the skill to also suggest **null-safety improvements** like `Optional` usage or `Objects.requireNonNull()`?"
    - User chooses: `yes` or `no`

5. **Run Scan**
    - Agent parses the selected files and analyzes:
        - Object accesses without null checks
        - Method calls on potentially null objects
        - Return values of methods that can be null
    - Assigns **risk levels**: LOW, MEDIUM, HIGH

6. **Generate Report**
    - Includes summary, file-specific details, and optional improvement suggestions
    - Formats report according to user choice (`md` or `json`)

## Inputs
- `scanScope`: "full_project" or "recent_changes"
- `filePaths` (array[string], optional): If specific files selected
- `reportFormat`: "md" or "json"
- `suggestImprovements`: "yes" or "no"

## Outputs
- `summary`: High-level summary of NPE risks found
- `details` (array[object]):
    - `file`: File path
    - `line`: Line number of potential NPE
    - `codeSnippet`: Code snippet around risky line
    - `riskLevel`: LOW, MEDIUM, HIGH
    - `recommendation`: Suggested fix or null-safety improvement

## Example Interaction

**Agent**: "Do you want to scan the full project or just recent changes?"  
**User**: "recent changes"

**Agent**: "Do you want to scan all changed files or select specific files?"  
**User**: "select files"

**Agent**: "Here are the changed files, please pick which ones to scan."  
**User**: selects `UserService.java` and `OrderController.java`

**Agent**: "Which report format do you prefer, Markdown or JSON?"  
**User**: "Markdown"

**Agent**: "Do you want null-safety improvement suggestions?"  
**User**: "Yes"

**Agent**: Runs analysis → Generates Markdown report.

---

## 2️⃣ `SKILLS.md` (Interactive Reference)

```markdown
# Skills Reference

## Skills List

### 1. Null Pointer Exception Detection (Interactive)
- **name**: null_pointer_exception
- **description**: Interactively scans Java project for potential Null Pointer Exceptions, asks user for scan scope, file selection, report format, and improvement suggestions.
- **file**: null_pointer_exception_skill.md
- **inputs**:
  - scanScope (full_project/recent_changes)
  - filePaths (optional, array[string])
  - reportFormat (md/json)
  - suggestImprovements (yes/no)
- **outputs**:
  - summary
  - details (file, line, codeSnippet, riskLevel, recommendation)
- **interactions**:
  1. Ask for scan scope: full project or recent changes
  2. Ask for file selection (all or specific)
  3. Ask for report format: Markdown or JSON
  4. Ask if null-safety suggestions are required
  5. Run scan and generate report