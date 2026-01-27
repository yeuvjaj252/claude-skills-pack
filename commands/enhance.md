---
description: Add or update features in existing application. Used for iterative development.
---

# Enhance Application

$ARGUMENTS

---

## Task

This command adds features or makes updates to existing application.

### Steps:

1. **Understand Current State**
   - Explore existing codebase
   - Understand existing features, tech stack

2. **Plan Changes**
   - Determine what will be added/changed
   - Detect affected files
   - Check dependencies

3. **Present Plan to User** (for major changes)
   ```
   "To add admin panel:
   - I'll create 15 new files
   - Update 8 files

   Should I start?"
   ```

4. **Apply**
   - Make changes using appropriate expertise
   - Test changes

5. **Update Preview**
   - Hot reload or restart server

---

## Usage Examples

```
/enhance add dark mode
/enhance build admin panel
/enhance integrate payment system
/enhance add search feature
/enhance edit profile page
/enhance make responsive
/enhance add authentication
/enhance optimize performance
```

---

## Change Categories

| Category | Scope | Approval |
|----------|-------|----------|
| **Minor** | 1-3 files, simple logic | Proceed directly |
| **Medium** | 4-10 files, new feature | Brief summary, then proceed |
| **Major** | 10+ files, architecture change | Detailed plan, wait for approval |

---

## Enhancement Checklist

Before enhancing:
- [ ] Understand existing architecture
- [ ] Identify all affected files
- [ ] Check for breaking changes
- [ ] Plan rollback strategy

After enhancing:
- [ ] Changes work as expected
- [ ] No regressions introduced
- [ ] Tests pass (if applicable)
- [ ] Code follows existing patterns

---

## Caution

- Get approval for major changes
- Warn on conflicting requests (e.g., "use Firebase" when project uses PostgreSQL)
- Maintain consistency with existing code style
- Don't refactor unrelated code
