---
description: 📋 Lập kế hoạch dự án bằng project-planner agent. Chỉ tạo plan file, không viết code.
---

# /csp-plan - Project Planning Mode

$ARGUMENTS

---

## 🔴 CRITICAL RULES

1. **NO CODE WRITING** - This command creates plan file only
2. **Use project-planner agent** - NOT Antigravity Agent's native Plan mode
3. **Socratic Gate** - Use `prompt-leverage` when clarification or restructuring is needed before planning
4. **Dynamic Naming** - Plan file named based on task

---

## Task

Before invoking `project-planner`, do a quick input quality check:

- If the request is ambiguous or under-specified, apply `prompt-leverage` in `clarify` mode
- If the request is detailed but messy, apply `prompt-leverage` in `structure` mode
- If the request needs option comparison before planning, apply `prompt-leverage` in `brainstorm` mode
- If the request is already clear, skip `prompt-leverage` and continue directly

Keep this preflight lightweight. Do not block planning with unnecessary questions.

Use the `project-planner` agent with this context:

```
CONTEXT:
- User Request: $ARGUMENTS
- Mode: PLANNING ONLY (no code)
- Output: docs/PLAN-{task-slug}.md (dynamic naming)

NAMING RULES:
1. Extract 2-3 key words from request
2. Lowercase, hyphen-separated
3. Max 30 characters
4. Example: "e-commerce cart" → PLAN-ecommerce-cart.md

RULES:
1. Follow project-planner.md Phase -1 (Context Check)
2. Follow project-planner.md Phase 0 (Socratic Gate)
3. If `prompt-leverage` was used, pass the clarified or structured request forward
4. Create PLAN-{slug}.md with task breakdown
5. DO NOT write any code files
6. REPORT the exact file name created
```

---

## Expected Output

| Deliverable | Location |
|-------------|----------|
| Project Plan | `docs/PLAN-{task-slug}.md` |
| Task Breakdown | Inside plan file |
| Agent Assignments | Inside plan file |
| Verification Checklist | Phase X in plan file |

---

## After Planning

Tell user:
```
[OK] Plan created: docs/PLAN-{slug}.md

Next steps:
- Review the plan
- Run `/cook` to start implementation
- Or modify plan manually
```

---

## Naming Examples

| Request | Plan File |
|---------|-----------|
| `/csp-plan e-commerce site with cart` | `docs/PLAN-ecommerce-cart.md` |
| `/csp-plan mobile app for fitness` | `docs/PLAN-fitness-app.md` |
| `/csp-plan add dark mode feature` | `docs/PLAN-dark-mode.md` |
| `/csp-plan fix authentication bug` | `docs/PLAN-auth-fix.md` |
| `/csp-plan SaaS dashboard` | `docs/PLAN-saas-dashboard.md` |

---

## Usage

```
/csp-plan e-commerce site with cart
/csp-plan mobile app for fitness tracking
/csp-plan SaaS dashboard with analytics
```
