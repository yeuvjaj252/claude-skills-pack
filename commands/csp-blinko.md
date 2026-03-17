---
description: Capture ideas, notes, todos, and follow-ups into Blinko
---

# /csp-blinko - Blinko Knowledge Capture

Task: $ARGUMENTS

## Instructions

1. **Load the right skill**: use `skill-csp-blinko-knowledge-capture` for note capture workflow
2. **Understand the capture request**:
   - identify whether the content is best stored as `blinko`, `note`, or `todo`
   - ask a short clarification question only if the intent is unclear
3. **Search before create**:
   - use Blinko search first when the topic may already exist
   - prefer update or comment over duplicate creation when appropriate
4. **Write intentionally**:
   - create new entries only when they are clearly standalone
   - use update for canonical notes that should absorb new context
   - use comments for small follow-ups
5. **Normalize lightly**:
   - keep the first line meaningful
   - keep formatting compact and retrieval-friendly
   - use only a few useful hashtags
6. **Report clearly**:
   - say what was saved
   - say which type was used
   - say whether it was created, updated, or added as a comment

## Output format

```markdown
## Capture Result
- Action: [created / updated / commented]
- Type: [blinko / note / todo]
- Summary: [what was saved]

## Notes
- [search/update decision if relevant]
- [assumptions if any]
```

## Example requests

- `/csp-blinko save ý tưởng này vào blinko`
- `/csp-blinko turn đoạn này thành note trong Blinko`
- `/csp-blinko tạo todo từ các action items này`
- `/csp-blinko thêm phần update này vào note auth rollout`
