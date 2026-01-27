---
description: Create new application. Triggers interactive dialogue and orchestrates multiple agents to build complete app.
---

# Create Application

$ARGUMENTS

---

## Task

This command starts a new application creation process.

### Steps:

1. **Request Analysis**
   - Understand what the user wants
   - If information is missing, ask clarifying questions

2. **Project Planning**
   - Use project-planner approach for task breakdown
   - Determine tech stack
   - Plan file structure
   - Create plan file and proceed to building

3. **Application Building (After Approval)**
   - Coordinate expert domains:
     - Database design → Schema
     - Backend development → API
     - Frontend development → UI
     - Testing → Quality assurance

4. **Preview**
   - Start development server when complete
   - Present URL to user

---

## Usage Examples

```
/create blog site
/create e-commerce app with product listing and cart
/create todo app
/create Instagram clone
/create crm system with customer management
```

---

## Before Starting

If request is unclear, ask these questions:
- What type of application?
- What are the basic features?
- Who will use it?
- Any specific tech stack preferences?

Use sensible defaults, add details later.

---

## Tech Stack Decision Tree

| App Type | Recommended Stack |
|----------|------------------|
| Simple landing | HTML + Tailwind |
| Blog/Content | Next.js + MDX |
| Dashboard/SaaS | Next.js + Prisma + PostgreSQL |
| E-commerce | Next.js + Stripe + PostgreSQL |
| Mobile app | React Native + Expo |
| API only | Hono/Fastify + PostgreSQL |

---

## Output

After gathering requirements, create:
1. `docs/PLAN.md` - Implementation plan
2. Project scaffolding
3. Core features
4. Development server running
