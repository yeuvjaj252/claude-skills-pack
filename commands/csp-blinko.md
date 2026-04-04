---
description: Update-first Blinko capture for notes, ideas, and todos
---

# /csp-blinko - Blinko Knowledge Capture

Task: $ARGUMENTS

## Instructions

1. Load `skill-csp-blinko-knowledge-capture`
2. If the user did not provide a hashtag, ask for it before saving
3. Default flow: search existing note by hashtag, then update it
4. Only create a new note when no relevant note exists or the user explicitly asked for a new one
5. Use `blinko` only for short ideas, `todo` only for explicit action items, otherwise default to `note`
6. Summarize the current session clearly and save it in a compact, retrieval-friendly format
7. Report what was updated or created, which hashtag was used, and which type was used
8. After finishing the Blinko save, run `/compact` if that command is available in the current environment

## Output format

```markdown
## Capture Result
- Action: [created / updated]
- Type: [blinko / note / todo]
- Hashtag: [#tag]
- Summary: [what was saved]

## Notes
- [search/update decision if relevant]
- [whether `/compact` was triggered]
```
