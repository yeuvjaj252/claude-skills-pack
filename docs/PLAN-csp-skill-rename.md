# PLAN: Rename CSP Skills to Avoid Conflicts with Superpowers

## Goal
Rename all 47 skill directories in `claude-skills-pack/skills/` to use prefix `skill-csp-` (e.g., `brainstorming` → `skill-csp-brainstorming`) to avoid naming conflicts with the Superpowers plugin.

## Scope

### What gets renamed
- **47 skill directories** under `skills/`
- **10 game-development sub-skills** (nested under `skill-csp-game-development/`)

### What gets updated (references)
| Location | Count | Reference Pattern |
|----------|-------|-------------------|
| `agents/*.md` (YAML `skills:` field) | 20 files | `skills: skill-csp-xxx, skill-csp-yyy` |
| `agents/*.md` (path refs) | ~5 files | `../skills/skill-csp-xxx/file.md` |
| `skills/*/SKILL.md` (cross-refs) | ~5 files | `@[skills/skill-csp-xxx]` |
| `skills/*/SKILL.md` (script paths) | ~6 files | `python .agent/skills/skill-csp-xxx/scripts/...` |
| `commands/*.md` (script paths) | ~4 files | `python .agent/skills/skill-csp-xxx/scripts/...` |
| `skills/doc.md` | 1 file | `.agent/skills/skill-csp-xxx/` |
| `README.md` | 1 file | Skill listing |
| `install.sh` / `update.sh` | 2 files | Check if skill names are hardcoded |

### What does NOT change
- **Command names** (`/csp-*`, `/cook`) - already namespaced
- **Agent filenames** (`agents/*.md`) - already unique
- **Script filenames** inside skills - only parent dir changes

---

## Phases

### Phase 1: Rename skill directories
```
skills/api-patterns          → skills/skill-csp-api-patterns
skills/app-builder           → skills/skill-csp-app-builder
skills/architecture          → skills/skill-csp-architecture
skills/bash-linux            → skills/skill-csp-bash-linux
skills/behavioral-modes      → skills/skill-csp-behavioral-modes
skills/brainstorming         → skills/skill-csp-brainstorming
skills/clean-code            → skills/skill-csp-clean-code
skills/cloudflare-expert     → skills/skill-csp-cloudflare-expert
skills/code-review-checklist → skills/skill-csp-code-review-checklist
skills/database-design       → skills/skill-csp-database-design
skills/deployment-procedures → skills/skill-csp-deployment-procedures
skills/docker-expert         → skills/skill-csp-docker-expert
skills/documentation-templates → skills/skill-csp-documentation-templates
skills/frontend-design       → skills/skill-csp-frontend-design
skills/game-development      → skills/skill-csp-game-development
skills/geo-fundamentals      → skills/skill-csp-geo-fundamentals
skills/i18n-localization     → skills/skill-csp-i18n-localization
skills/intelligent-routing   → skills/skill-csp-intelligent-routing
skills/lint-and-validate     → skills/skill-csp-lint-and-validate
skills/mcp-builder           → skills/skill-csp-mcp-builder
skills/mobile-design         → skills/skill-csp-mobile-design
skills/nestjs-expert         → skills/skill-csp-nestjs-expert
skills/nextjs-best-practices → skills/skill-csp-nextjs-best-practices
skills/nextjs-react-expert   → skills/skill-csp-nextjs-react-expert
skills/nodejs-best-practices → skills/skill-csp-nodejs-best-practices
skills/parallel-agents       → skills/skill-csp-parallel-agents
skills/performance-profiling → skills/skill-csp-performance-profiling
skills/plan-writing          → skills/skill-csp-plan-writing
skills/powershell-windows    → skills/skill-csp-powershell-windows
skills/prisma-expert         → skills/skill-csp-prisma-expert
skills/prompt-leverage       → skills/skill-csp-prompt-leverage
skills/python-patterns       → skills/skill-csp-python-patterns
skills/react-patterns        → skills/skill-csp-react-patterns
skills/red-team-tactics      → skills/skill-csp-red-team-tactics
skills/rust-pro              → skills/skill-csp-rust-pro
skills/seo-fundamentals      → skills/skill-csp-seo-fundamentals
skills/server-management     → skills/skill-csp-server-management
skills/systematic-debugging  → skills/skill-csp-systematic-debugging
skills/tailwind-patterns     → skills/skill-csp-tailwind-patterns
skills/tdd-workflow          → skills/skill-csp-tdd-workflow
skills/testing-patterns      → skills/skill-csp-testing-patterns
skills/typescript-expert     → skills/skill-csp-typescript-expert
skills/ui-ux-pro-max         → skills/skill-csp-ui-ux-pro-max
skills/vue-expert            → skills/skill-csp-vue-expert
skills/vulnerability-scanner → skills/skill-csp-vulnerability-scanner
skills/web-design-guidelines → skills/skill-csp-web-design-guidelines
skills/webapp-testing        → skills/skill-csp-webapp-testing
```

**Agent:** general-purpose (bash rename script)

### Phase 2: Update all references in agents/*.md
Update YAML `skills:` frontmatter field in all 20 agent files.
Update inline path references (e.g., `../skills/mobile-design/` → `../skills/skill-csp-mobile-design/`).

**Agent:** backend-specialist or general-purpose

### Phase 3: Update cross-skill references in skills/*/SKILL.md
Update `@[skills/xxx]` patterns and `python .agent/skills/xxx/scripts/` paths.

**Agent:** general-purpose

### Phase 4: Update commands/*.md
Update script paths in commands that reference skill directories.

**Agent:** general-purpose

### Phase 5: Update doc.md, README.md, install/update scripts
Update remaining references.

**Agent:** general-purpose

### Phase 6: Verification
- [ ] All 47 skill dirs renamed with `skill-csp-` prefix
- [ ] No broken references: `grep -r "skills/" --include="*.md" | grep -v "skill-csp-"` should only show non-CSP refs
- [ ] `skills/doc.md` updated
- [ ] All `agents/*.md` YAML `skills:` fields updated
- [ ] All script paths in commands and skills updated
- [ ] README skill listing updated
- [ ] Git diff review

---

## Risk
- **Low risk** - purely renaming, no logic changes
- **Reversible** via git

## Estimated Impact
- ~80+ files modified
- 47 directories renamed
