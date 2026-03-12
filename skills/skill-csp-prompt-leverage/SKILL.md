---
name: skill-csp-prompt-leverage
description: Improve rough user input before planning or execution. Use to clarify ambiguity, restructure messy requests, compare options, or turn intent into implementation-ready instructions.
allowed-tools: Read, Glob, Grep
---

# Prompt Leverage

Use this skill to transform raw user intent into a higher-quality working prompt.

This is primarily a **supporting skill** for higher-level commands such as `/csp-plan`, not a command users must call directly.

---

## Purpose

`prompt-leverage` helps the agent decide whether the current request needs:

1. clarification before planning
2. restructuring before delegation
3. option exploration before committing
4. execution framing before implementation

The goal is to reduce bad plans caused by vague, mixed, or poorly structured requests.

---

## Core Rule

Use `prompt-leverage` only when it adds value.

### Invoke when the request is:
- ambiguous
- under-specified
- mixing multiple goals
- long but poorly structured
- asking for planning while the direction is still undecided

### Skip when the request is already:
- specific
- scoped
- structured
- immediately actionable

---

## Supported Modes

### 1. `clarify`

Use when key planning inputs are missing.

#### Goal
Identify the smallest set of questions needed to avoid planning the wrong thing.

#### Output
- Restated goal
- Missing information
- 1-3 highest-value questions
- Safe assumptions if user does not answer

#### Best for
- vague feature requests
- unclear planning requests
- missing users, scope, or constraints

---

### 2. `structure`

Use when the request contains useful detail but is messy.

#### Goal
Rewrite the input into a planning-friendly structure.

#### Output
- Goal
- Context
- Constraints
- Expected output
- Success criteria

#### Best for
- long freeform requests
- mixed requirements in one paragraph
- planning prompts with scattered details

---

### 3. `brainstorm`

Use when the user needs options before planning.

#### Goal
Expand the request into multiple viable directions with tradeoffs.

#### Output
- Goal
- Constraints
- Option A / B / C
- Benefits
- Drawbacks
- Recommendation

#### Best for
- early shaping
- architecture direction choices
- planning requests with unresolved strategy

---

### 4. `execute`

Use when the intent is clear and must be turned into an implementation-ready instruction.

#### Goal
Frame the task so downstream implementation is direct and verifiable.

#### Output
- Task summary
- Plan or steps
- Constraints
- Verification expectations
- Desired output format

#### Best for
- implementation handoff
- coding tasks after planning
- execution-focused prompts

---

## Recommended Command Integration

### `/csp-plan`
Default internal modes:
- `clarify` when request is ambiguous
- `structure` when request is messy
- `brainstorm` when planning depends on choosing a direction first

### `/cook`
Default internal modes:
- `clarify` before project planning
- `structure` before handing off to project-planner

### Other commands
Use selectively. Do not force this skill on every request.

---

## Decision Heuristic

Use this quick routing logic:

| If the request is... | Use mode |
|---|---|
| Missing purpose, users, or constraints | `clarify` |
| Long and unstructured | `structure` |
| Still deciding approach | `brainstorm` |
| Ready for direct implementation | `execute` |

If none apply, proceed without this skill.

---

## Best Practices

1. Ask fewer, higher-value questions
2. Prefer restructuring over over-questioning
3. Do not turn simple requests into ceremonies
4. Preserve the user's intent when rewriting
5. Keep outputs compact and actionable

---

## Anti-Patterns

- asking questions that do not change the plan
- reformatting already-good prompts
- brainstorming when the user already chose a direction
- adding speculative requirements not stated by the user
- forcing `prompt-leverage` into every workflow
