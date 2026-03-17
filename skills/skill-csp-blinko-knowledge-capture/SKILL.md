---
name: skill-csp-blinko-knowledge-capture
description: Capture ideas, structured notes, and follow-up tasks into Blinko with search-before-create and clear update rules.
---

# Blinko Knowledge Capture

Use this skill to save useful knowledge into Blinko without creating duplicate or messy notes.

This skill is best for:
- quick ideas
- structured notes
- meeting summaries
- decisions
- follow-up tasks
- updating an existing Blinko note with new context

---

## Purpose

`blinko-knowledge-capture` helps the agent turn raw user input into clean Blinko entries.

It follows a simple capture workflow:
1. understand the content
2. choose the right Blinko type
3. search existing notes first
4. create or update intentionally
5. return a clear result to the user

---

## When to Use

Use this skill when the user wants to:
- save an idea for later
- store a note in their second brain
- capture research, a summary, or an insight
- add action items or reminders
- append new information to an existing topic
- avoid losing context from a conversation

### Good triggers
- "save this to blinko"
- "note this down"
- "turn this into a note"
- "create a todo from this"
- "add this to my existing note about X"
- "capture this meeting summary"

### Skip when
- the user only wants a normal chat response
- the content is too incomplete to store meaningfully
- the user is clearly asking for file edits, not note capture
- there is no meaningful content to save yet

---

## Core Workflow

### Step 1: Understand the capture intent

Identify what the user is trying to save:
- fleeting thought
- structured knowledge
- action item
- update to an existing note
- comment on an existing note

If the request is unclear, ask a short clarification question before saving.

---

### Step 2: Choose the Blinko type

Map the content to the lightest useful record type.

#### Use `blinko` for:
- short ideas
- rough inspiration
- temporary thoughts worth keeping
- compact observations

#### Use `note` for:
- structured summaries
- meeting notes
- decisions and rationale
- how-to content
- research notes
- content with multiple bullets or sections

#### Use `todo` for:
- explicit follow-up actions
- reminders
- task lists
- next steps with clear ownership or intent

### Quick heuristic

| Content shape | Best type |
|---|---|
| short, raw, idea-like | `blinko` |
| structured, reference-worthy | `note` |
| action-oriented | `todo` |

If mixed, prefer:
- `note` when knowledge is primary and tasks are secondary
- `todo` when execution is primary

---

### Step 3: Search before create

Always search Blinko before creating a new entry when the content refers to:
- an existing project
- a repeated topic
- prior meeting notes
- a known decision
- a follow-up on earlier content

Use `blinko_searchBlinko` with a focused query based on:
- project name
- topic keywords
- decision title
- distinctive tags

Search first to answer:
1. does a matching note already exist?
2. should this become an update instead of a new note?
3. should this be added as a comment or follow-up todo?

### Prefer update instead of create when
- the same topic already has an obvious canonical note
- the user explicitly says "add to" or "update"
- the new content is incremental context, not a separate item

### Prefer create instead of update when
- the content is a distinct standalone idea
- the existing matches are only loosely related
- combining would make the old note too noisy
- the user asks for a separate item

---

### Step 4: Normalize the content

Before saving, rewrite lightly for clarity.

#### Formatting rules
- keep the first line meaningful and summary-like
- prefer short paragraphs and bullets
- keep wording concise
- preserve important user terminology
- do not over-format a quick idea into a heavy document

#### Hashtag rules
Use a few useful tags only.

Good examples:
- `#meeting`
- `#decision`
- `#research`
- `#project-name`
- `#todo`
- `#idea`

Avoid:
- too many tags
- vague tags with no retrieval value
- inventing taxonomy the user will not reuse

#### Suggested note shapes

##### Short idea
```md
Idea: lightweight summary of the thought

- Why it matters
- Possible next step

#idea #topic
```

##### Structured note
```md
Topic summary

## Context
- ...

## Key points
- ...

## Next steps
- ...

#project-name #meeting
```

##### Todo
```md
Task summary

- Context: ...
- Next action: ...
- Optional due context: ...

#todo #project-name
```

---

### Step 5: Choose the write action

Use the Blinko tools intentionally:

#### `blinko_upsertBlinko`
Use when creating a new `blinko`, `note`, or `todo`.

#### `blinko_updateBlinko`
Use when an existing note should be revised or extended.

Good uses:
- merge new findings into a canonical note
- append a new section
- refine structure while preserving core content

#### `blinko_createComment`
Use when the new content is better as commentary on an existing note than as a full rewrite.

Good uses:
- a short follow-up thought
- status update on a note
- minor observation tied to an existing entry

---

### Step 6: Report the result clearly

After saving, tell the user:
- what was saved
- which type was used
- whether it was created, updated, or commented
- any important assumption made

Example result style:
- "Saved to Blinko as a `note` with tags `#research #api`."
- "Updated your existing Blinko note about auth rollout instead of creating a duplicate."
- "Created a `todo` for the follow-up tasks and kept the summary separate."

---

## Decision Rules

### Create a new entry when
- the content stands on its own
- it would be confusing to merge into another note
- the user wants a separate capture

### Update an existing entry when
- the note is clearly the same topic
- the user asks to continue or extend it
- the new material improves a canonical reference note

### Add a comment when
- the new content is small and contextual
- a full rewrite would be unnecessary
- the note should keep its structure unchanged

### Ask before saving when
- multiple existing matches seem equally valid
- the user intent is unclear between note vs todo
- the content is too incomplete to classify well

---

## Best Practices

1. Search before create for repeated topics
2. Keep capture lightweight unless structure adds value
3. Prefer one clear canonical note over many duplicates
4. Preserve the user's terms, names, and project labels
5. Use only a small number of reusable hashtags
6. Separate knowledge from tasks when that improves retrieval
7. Tell the user what action was taken

---

## Anti-Patterns

- creating a new note every time without searching
- turning every short idea into an over-structured document
- stuffing unrelated topics into one note
- using too many hashtags
- silently updating the wrong existing note
- inventing details the user did not provide
- using `todo` for content that is actually reference knowledge

---

## Recommended Agent Behavior

1. restate the capture intent briefly when useful
2. classify the content into `blinko`, `note`, or `todo`
3. search first if the topic may already exist
4. create, update, or comment using the most appropriate tool
5. confirm the result in one concise summary

If the request mixes summary plus action items, prefer:
- one `note` for the durable knowledge
- one `todo` for explicit follow-up tasks

Keep the workflow practical, compact, and retrieval-friendly.

---

## Example Prompts

Use cases the agent should handle well:

- `save ý tưởng này vào Blinko: làm command để capture decision log cho team`
- `turn đoạn này thành note trong Blinko và thêm tag #meeting #backend`
- `tạo todo từ các action items sau: review schema, viết migration, hẹn QA verify`
- `tìm note về auth rollout trong Blinko rồi thêm phần update này vào đó`
- `đây là follow-up nhỏ cho note incident hôm qua, thêm như comment giúp mình`

## Example Outcomes

### Quick idea → `blinko`
- capture một ý tưởng ngắn
- giữ format gọn
- thêm 1-2 hashtag hữu ích

### Meeting summary → `note`
- gom nội dung thành summary + bullets
- tách context, key points, next steps
- tránh tạo note trùng nếu đã có note cùng buổi họp

### Action items → `todo`
- chuẩn hoá từng next step rõ nghĩa
- giữ context ngắn gọn
- dùng khi execution quan trọng hơn reference knowledge

### Small follow-up → comment
- dùng khi nội dung mới chỉ là update nhỏ
- tránh rewrite toàn bộ note nếu không cần
