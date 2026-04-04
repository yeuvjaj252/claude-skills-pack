---
name: skill-csp-blinko-knowledge-capture
description: Update-first Blinko capture workflow with user-owned hashtags and concise reporting.
---

# Blinko Knowledge Capture

Use this skill when the user wants to save or update knowledge in Blinko.

## Default mindset
- Default type is `note`
- Default action is **search old note → update it**
- Only use `blinko` for short idea-like content
- Only use `todo` for explicit action items
- Search before create
- Normalize lightly
- Report the result clearly

## Hashtag rule
- Hashtag is decided by the user, not the agent
- If the user did not give a hashtag, ask for it before saving
- Do not invent a new hashtag on your own
- Reuse the exact tag the user provided, for example `#lcl-consol` or `#auth-system`

## 3-step workflow

### Step 1: Identify intent
- If the user gave a hashtag, search existing notes with that hashtag first
- If the user did not give a hashtag, ask for it first
- If the user clearly asked to create a new note, create one
- If the user said "update", "thêm vào", "ghi lại", or similar, update-first
- If the content is mixed or unclear, prefer `note`

### Step 2: Execute
- Use `blinko_searchBlinko` first
- If a matching note exists, use `blinko_updateBlinko` and append the new session summary
- If nothing relevant exists, use `blinko_upsertBlinko`
- Use `type=blinko` for short fleeting ideas
- Use `type=todo` for explicit tasks or next steps
- Use `type=note` for everything else

## Note content rules
- Summarize what was done in the current session from conversation context
- Keep it short and retrieval-friendly
- Prefer bullets for feature, file, and logic changes
- Preserve the user's wording for important domain terms

### Title format for note entries
Use this format when creating a new session note:

`{change summary} - Session {number} - {YYYY-MM-DD}`

Rules:
- Count prior notes with the same hashtag, then use the next session number
- Use today's date for the final segment
- Keep the title summary concise and specific

Example:
- `POL/POD External API, Favorite Filter, Promotion Tabs - Session 7 - 2026-04-04`

### Multi-module sessions
- If the session clearly covers one module, use that tag
- If the session clearly covers multiple modules, update each matching tagged note separately
- If tag mapping is ambiguous, ask the user before saving

### Light normalization
- Keep the first line meaningful
- Prefer short bullets over long prose
- Do not over-structure a quick capture
- Do not create duplicate notes when an update is enough

### Step 3: Report
Tell the user briefly:
- whether you updated or created
- which hashtag was used
- which type was used
- whether you split the save across multiple module notes

Example result style:
- `Updated note #lcl-consol as type note.`
- `Created new note #auth-system as Session 3 for today's work.`
- `Created todo #release-followup with the action items.`

## Practical rules
- Prefer update over create unless the user clearly asked for a new note
- Prefer `note` over overthinking the type
- Ask only when the hashtag or destination is truly unclear
- Do not create noisy comments when a normal note update is better
- After finishing `/csp-blinko`, report the result and then run `/compact` if that command is available in the current environment
