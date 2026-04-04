---
description: 🔎 Research external library and framework docs with Context7 before planning or implementation.
---

# /csp-research - Context7 Research

$ARGUMENTS

---

## Task

Use this command when the user wants docs-backed guidance for a library, framework, SDK, or package.

Before researching, do a lightweight preflight with `skill-csp-prompt-leverage` only if needed:

- use `clarify` if the target library or question is unclear
- use `structure` if the user mixes multiple research goals in one request
- use `execute` when the request is already specific enough for docs lookup

Keep this preflight short.

### Steps

1. Load `skill-csp-context7-research`
2. Detect the target library or framework
3. Resolve the Context7 library ID
4. Query docs with the most focused question possible
5. Return only decision-useful findings
6. Say whether the result should affect `/csp-plan` or `/cook`

---

## Output format

```markdown
## Context7 Result
- Library: [name]
- Why docs were needed: [reason]
- Recommendation: [docs-backed recommendation]
- Pitfalls: [important caveats]
- Impact: [how this should change planning or implementation]
```

---

## Usage

```text
/csp-research nextjs app router caching best practice
/csp-research prisma relation query pattern
/csp-research nestjs guards vs middleware
```
