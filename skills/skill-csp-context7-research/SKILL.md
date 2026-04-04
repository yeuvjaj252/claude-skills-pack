---
name: skill-csp-context7-research
description: Consult Context7 for library and framework docs when planning or implementation depends on exact external APIs, version behavior, or official best practices.
---

# Context7 Research

Use this skill when the task depends on external library or framework documentation.

This is a utility skill for commands like `/csp-plan`, `/cook`, and `/csp-docs`.

## When to Use
Use Context7 when the task involves:
- a named library, framework, SDK, or package
- version-sensitive APIs or configuration
- official best-practice decisions
- setup, migration, or integration syntax that must be exact
- bug investigation where deprecated or changed APIs may be the cause

## Skip When
Do not use Context7 when the task is mostly:
- local business logic
- internal refactoring
- renaming or cleanup
- simple UI polish
- codebase exploration that depends on project code, not external docs

## Default Workflow

### Step 1: Detect docs risk
Ask: will the answer likely be wrong or incomplete without official docs?

If yes, use Context7.
If no, continue normally.

### Step 2: Resolve and query
- Resolve the best matching library ID first
- Query docs with a focused question
- Prefer the smallest query that answers the implementation or planning risk
- If the version is known, include it in the query

### Step 3: Return only decision-useful output
Summarize only what helps the next step:
- detected library
- relevant version or API notes
- recommended approach
- pitfalls or deprecated patterns
- short docs-backed snippet or constraint

## Output Shape
Use compact output like:

- Library: `next.js`
- Why docs were needed: `App Router caching behavior is version-sensitive`
- Recommendation: `use server components for initial fetch and avoid client waterfall`
- Pitfalls: `do not rely on deprecated pages-router data hooks`
- Impact: `plan can assume App Router-native data fetching`

## Integration Rules

### `/csp-plan`
Use this skill before finalizing a plan when:
- the request includes a library/framework name
- architecture depends on framework conventions
- the user asked for best practice or the latest recommended pattern

### `/cook`
Use this skill before editing code when:
- implementation depends on exact external APIs
- config, setup, migration, or integration syntax must be correct
- the bug may come from outdated docs or version mismatch

### `/csp-docs`
Use this skill when documentation quality depends on accurate library usage or current official guidance.

## Practical Rules
- Prefer one focused docs query over broad research
- Do not dump raw docs into the response
- Use docs to reduce hallucination, not to replace reasoning
- If project code answers the question better, prefer project inspection first
- Mention when Context7 changed or confirmed the plan
