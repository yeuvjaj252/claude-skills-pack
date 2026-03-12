---
description: 👨‍🍳 Tạo ứng dụng mới. Kích hoạt App Builder skill và bắt đầu luồng trao đổi tương tác với user.
---

# /cook - Create Application

$ARGUMENTS

---

## Task

This command starts a new application creation process.

Before starting, do a lightweight input check with `prompt-leverage`:

- Use `clarify` if the app type, target users, or must-have features are missing
- Use `structure` if the request is long or mixed together without clear priorities
- Use `execute` once the request is clear enough to hand off cleanly to planning and building

Keep this preflight short. Ask only the questions that materially affect planning or implementation.

### Steps:

1. **Request Analysis**
    - Understand what the user wants
    - If information is missing, use `prompt-leverage` first, then ask only the highest-value follow-up questions

2. **Project Planning**
    - Use `project-planner` agent for task breakdown
    - Determine tech stack
    - Plan file structure
    - Pass the clarified/structured request forward if `prompt-leverage` was used
    - Create plan file and proceed to building

3. **Application Building (After Approval)**
   - Orchestrate with `app-builder` skill
   - Coordinate expert agents:
     - `database-architect` → Schema
     - `backend-specialist` → API
     - `frontend-specialist` → UI

4. **Preview**
   - Start with `auto_preview.py` when complete
   - Present URL to user

---

## Usage Examples

```
/cook blog site
/cook e-commerce app with product listing and cart
/cook todo app
/cook Instagram clone
/cook crm system with customer management
```

---

## Before Starting

If request is unclear, ask these questions:
- What type of application?
- What are the basic features?
- Who will use it?

Use defaults, add details later.

Prefer `prompt-leverage` to tighten the request before escalating into deeper planning.
