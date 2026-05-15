---
name: qtm-ui
description: Use when designing QTM/IMS-style enterprise UI, table-first workspaces, data consoles, AG Grid pages, column sizing bugs, text overlap, gradient table headers, compact filter/status blocks, Project Grid card editing, operational dashboards, audit/history/log screens, inventory/asset-like modules, or reusable UI/UX structure for internal business applications.
license: UNLICENSED
compatibility: opencode
metadata:
  audience: frontend-developers
  workflow: ui-pattern-reference
---

# QTM UI

## Overview

QTM UI is a reusable enterprise workspace pattern for data-heavy internal systems. The core principle: the table or operational record stream is the product surface; decoration supports scanability, permission clarity, and fast action.

## When to Use

Use for:
- Inventory, asset, borrowing, license, feedback, webhook, audit, history, log, and transaction pages.
- Pages with AG Grid, many rows, status filters, row actions, exports, payloads, or detail inspection.
- Redesigns that need a consistent IMS/QTM look across modules or projects.

Do not use for:
- Marketing pages, landing pages, or consumer flows.
- Small forms where a table/data-console shell would add unnecessary weight.

## Wholesale UI Redesign

When this skill is invoked to redesign an entire product surface (multiple pages, app shell, or "toàn bộ UI"), apply **every section** of this skill across all screens — Layout Rules, Visual Language, Sidebar / Primary Navigation, AG Grid Rules, Card Editing, Detail Pattern, Permission Pattern, and Shared Standard Files. Cross-screen consistency is the deliverable: do not cherry-pick (e.g., apply Visual Language to one page but leave the sidebar untouched, or fix the hero but keep `rounded-xl`/`#6C2888` chrome on buttons). If a section does not apply to a given screen, state that explicitly; do not silently skip it.

## Core Pattern

Default page stack:

| Layer | Purpose | Rules |
|-------|---------|-------|
| Compact hero | Module identity and top metrics | White surface, pastel cloud overlay, dark blue text, short copy |
| Compact status strip | Fast status reading and optional filters | Low-profile button cards, no tall KPI block, optimized above the grid |
| Filter/action bar | Search, tabs, branch/type/status, exports | Attached to data frame, compact, not a distant sidebar |
| AG Grid/table canvas | Primary work surface | Full width, copyable cells, compact action column |
| Card editing grid | Batch-friendly edit surface when records are field-light | Use Project Grid-style cards only when editing benefits outweigh table scan density |
| Selected-row detail panel | Deep inspection without losing table context | Prefer panel over nested rows for logs/audits/feedback |
| Dialogs/workflows | Create/edit/return/retry flows | Keep business logic outside visual shell |

## Layout Rules

- On wide desktop layouts, use the left side for context and passive reading: section label, sub-title, row count, mode, or short operational hints.
- Prioritize the right side of the toolbar for active controls: search, status filters, branch/type filters, and action buttons.
- If there are many controls, keep them attached to the grid in one compact right-biased toolbar or a compact two-row toolbar; do not push them into a sidebar just to fit.
- Keep the page shell wide for table-heavy modules. Avoid narrow centered containers that leave large empty gutters on the left and right.
- The table should consume the useful width of the page. Decorative whitespace must not win over scanability.
- Keep the hero compact so the grid starts high on the page. Preserve above-the-fold visibility for filters and the first portion of the table.
- Prefer scroll efficiency over tall chrome: compact toolbars, compact summary cards, and sticky behavior when it helps operators keep filters visible while scanning.
- Status/filter blocks like `All / Mismatch / Pending / Failed` must be a compact strip: one row at `lg+` for four statuses, `gap-2`/`gap-3`, low padding, label + value only by default, and no oversized KPI-card treatment that pushes the grid down.

## Visual Language

- Canvas: white or near-white, with dark blue `#010120` as the anchor color.
- Hero: full-surface pastel cloud layer using lavender, pale blue, and tiny magenta accents; do not use dark dramatic hero bands for normal data pages.
- Typography: tight display text, medium weight, uppercase mono labels for structure.
- Radius: sharp `4px` for controls/badges, `8px` for larger hero/cards, square table frame where AG Grid is the product surface.
- Shadow: subtle dark-blue-tinted shadow, not generic heavy drop shadow.
- Accents: magenta/orange are decorative only; avoid using them as routine UI chrome.

## AG Grid Rules

- Keep global `.ag-theme-quartz` neutral: black/white/gray baseline, square wrapper, subtle borders.
- For module-specific polish, add a wrapper class and scope CSS: `.borrowing-grid.ag-theme-quartz`, `.license-grid.ag-theme-quartz`, etc.
- Prefer native AG Grid headers. Avoid custom boxed header components unless there is a strong interaction need.
- QTM AG Grid pages must use the `/qtm-ui-example` header treatment: scoped wrapper cells with radial magenta/lavender accents plus a pale blue-white linear gradient. Do not leave QTM module headers flat white or replace them with a simple vertical lavender gradient.
- Apply the same gradient and border language to pinned/action header cells. Frozen columns must not look like a different table.
- Keep columns resizable. Hide the visible resize handle if needed, but preserve an interactive hitbox and `col-resize` cursor.
- Use `enableCellTextSelection` and `ensureDomOrder` when users need to copy table text.
- Action columns should be compact, pinned, icon-only, and have `title`/`aria-label`.
- When theming the AG Grid horizontal scrollbar, style **all three** of `.ag-body-horizontal-scroll-viewport`, `.ag-horizontal-left-spacer`, and `.ag-horizontal-right-spacer`. AG Grid puts `overflow-x: scroll` on each spacer, so each renders its own native scrollbar; styling only the viewport leaves a foreign-colored stripe under the pinned columns. Use neutral `rgba(0,0,0,0.04)` track everywhere, Dark Blue `#010120` thumb with sharp `4px` radius (never pill `999px`), and transparent thumbs inside the spacers (no content to scroll there). Use `alwaysShowHorizontalScroll` prop instead of building a custom sticky scrollbar.

AG Grid sizing/debugging standard:

- If columns stop short and leave empty table width, inspect the shared grid wrapper before changing individual pages. A QTM wrapper should make ordinary data columns fill remaining width while fixed utility columns stay fixed.
- Add `flex: 1` in shared defaults or wrapper-normalized column defs only for columns that do not already define `flex`, `width`, or `pinned`. Do not force flex onto pinned action/status/date columns that intentionally need fixed widths.
- If long text overlaps neighboring columns, treat it as a cell containment bug. Scoped QTM grid cells that use `display: flex` must also constrain overflow and allow flex children to shrink.
- For custom renderers with long labels, add `min-w-0 truncate` or equivalent to the renderer's inner text element. CSS on `.ag-cell-value` cannot constrain a custom child that refuses to shrink.

```tsx
const sizedColumnDefs = columnDefs.map((column) => {
  if (column.flex != null || column.width != null || column.pinned) return column;
  return { ...column, flex: 1 };
});
```

```css
.module-grid.ag-theme-quartz .ag-cell {
  display: flex;
  align-items: center;
  overflow: hidden;
}

.module-grid.ag-theme-quartz .ag-cell-value,
.module-grid.ag-theme-quartz .ag-cell-wrapper {
  min-width: 0;
  max-width: 100%;
}
```

Header gradient standard:

```css
.module-grid.ag-theme-quartz .ag-header-cell,
.module-grid.ag-theme-quartz .ag-header-group-cell {
  background:
    radial-gradient(circle at 8% 0%, rgba(239, 44, 193, 0.07), transparent 34%),
    radial-gradient(circle at 70% -20%, rgba(189, 187, 255, 0.16), transparent 42%),
    linear-gradient(135deg, rgba(255, 255, 255, 0.84) 0%, rgba(250, 247, 255, 0.9) 48%, rgba(239, 247, 255, 0.86) 100%);
  border-top: 1px solid rgba(1, 1, 32, 0.11);
  border-right: 1px solid rgba(1, 1, 32, 0.14);
  border-bottom: 1px solid rgba(1, 1, 32, 0.16);
}

.module-grid.ag-theme-quartz .ag-header-cell:first-child,
.module-grid.ag-theme-quartz .ag-header-group-cell:first-child {
  border-left: 1px solid rgba(1, 1, 32, 0.14);
}
```

## Compact Filter Block

Use this when the page has a top status/filter block like `All / Mismatch / Pending / Failed`.

- Treat it as a filter strip, not a KPI dashboard. The goal is fast filtering and keeping the table high on the page.
- Desktop: four routine status filters must fit in one row at `lg+` with `grid gap-2 lg:grid-cols-4` or equivalent; avoid large `gap-5`, captions, icons, and tall card bodies.
- Card anatomy: uppercase mono label `10px-11px`, value `24px-28px`, compact `px-3 py-2.5` or `h-[72px]`; active state uses soft lavender surface plus Dark Blue border/ring. For `All / Mismatch / Pending / Failed`, omit captions and icons unless the user explicitly asks for them.
- Place the strip directly above or inside the data frame header. Do not separate it from the grid with large vertical whitespace.
- If a module also needs search/source/action controls, use a compact attached `QtmFilterBar` below the strip. Use `QtmControlRail` only when the page has many controls that would make the top block taller than the first table rows.

```tsx
<div className="grid gap-2 sm:grid-cols-2 lg:grid-cols-4">
  {statusCards.map((card) => (
    <button
      key={card.label}
      type="button"
      aria-pressed={activeStatus === card.value}
      className={`h-[76px] rounded-[8px] border px-3 py-2.5 text-left shadow-sm ${
        activeStatus === card.value
          ? 'border-[#010120]/25 bg-[#f6f4ff] ring-1 ring-[#010120]/10'
          : 'border-black/[0.08] bg-white hover:bg-black/[0.02]'
      }`}
    >
      <div className="font-mono text-[10px] font-medium uppercase tracking-[0.12em] text-black/45">{card.label}</div>
      <div className="mt-2 text-[26px] font-medium leading-none tracking-[-0.04em] text-[#010120]">{card.count}</div>
    </button>
  ))}
</div>
```

## Sidebar / Primary Navigation

The sidebar is part of the QTM shell: it must follow the same visual language as the rest of the product (sharp `4px`, Dark Blue `#010120`, neutral borders, mono-uppercase labels). Treat the menu as an information-architecture surface, not as decoration.

Information architecture:
- **One group label maximum**, used only as a divider for the privileged/administrative cluster (e.g., `ADMINISTRATION`). If a collapsible already names itself, an additional `SidebarGroupLabel` above it is duplicate noise — remove it.
- **Collapsible parent name must not match the first child label.** "Assets Manage > Asset Management" reads the same thing twice; rename the parent to a broader category ("Assets > Asset Management"). Same for "Handover" / "Projects".
- **Top-level items keep their icon** (required for collapsed icon-only mode at `w-20`). **Sub-items are text-only**: the left-rail `border-l border-[rgba(0,0,0,0.08)]` + indent already signal nesting. One icon per sub-item turns the expanded collapsible into a spam strip.
- Group order goes operational-first (Dashboard → domain collapsibles → Reports/Tools), then a single divider, then privileged section.

Visual rules:
- Shell: white surface, border-right `rgba(0,0,0,0.08)`, no heavy `shadow-xl`. Widths `w-72` expanded / `w-20` collapsed.
- Logo: keep the brand image at left. Wordmark in Dark Blue `#010120`, weight 500, tracking `-0.4px` (negative). Subtitle uppercase 10–11px with `tracking-[0.08em]` and `text-black/55` (mono-label feel).
- Group label (when used): 11px, weight 500, uppercase, `tracking-[0.08em]`, `text-black/55`. Not `font-bold`, not slate gray.
- **Top-level button active state = Dark Solid CTA**: `bg-[#010120]` + `text-white` + `shadow-[rgba(1,1,32,0.1)_0px_4px_10px]`, sharp `4px`. Hover: `bg-[rgba(0,0,0,0.04)]`.
- **Sub-item active state = Soft Lavender tint**: `bg-[rgba(189,187,255,0.22)]` + `text-[#010120]` + `font-medium`, sharp `4px`. Hover: `bg-[rgba(0,0,0,0.04)]`.
- Never use purple `#6C2888` (legacy Quanterm purple) or any `var(--quanterm-purple-*)` as sidebar chrome. The brand anchor is Dark Blue.
- Radius: `4px` everywhere (button, sub-button, avatar tile, sign-out, trigger). No `rounded-xl` / `rounded-lg` / pill.
- Chevron: `opacity-60` → `opacity-100` on open, no explicit color so it inherits `currentColor` and stays legible on both the Dark Solid active row and the light inactive row.
- Negative tracking: top-level labels `tracking-[-0.16px]`, sub-labels `tracking-[-0.14px]`, wordmark `tracking-[-0.4px]`. Never `tracking-wide` (positive) on QTM label text.
- User card: sharp `4px` border `rgba(0,0,0,0.08)`. Avatar is a 4px **square** Dark Blue tile with white initials — not a yellow/orange gradient circle. Display name in Dark Blue weight 500; email `text-black/55`.
- Sign-out: neutral track `bg-[rgba(0,0,0,0.04)]` + light border `rgba(0,0,0,0.08)` + red text only. Hover flips to `bg-red-500 text-white border-red-500`. Sharp `4px`, not `rounded-xl bg-red-50`.

Portable sidebar snippets and checklists live in `references/qtm-ui-patterns.md` under "Sidebar Standard". Adapt them to the target project's local sidebar primitives.

## Card Editing Pattern

Use a Project Grid-style card editing grid only when users need to edit several field-light records in place. Table-first remains the default for high-volume scan, compare, sort, export, or copy workflows.

Card editing rules:
- Keep the same QTM shell: compact hero, optional summary cards, wide content frame, and right-side `QtmControlRail` for search, filters, view mode, and save actions.
- Make the card grid the primary canvas: `grid-cols-1 sm:grid-cols-2 xl:grid-cols-3 2xl:grid-cols-4`, compact gaps, no decorative masonry.
- Each card starts with identity and status: record name/code, branch or owner, status badge, dirty marker, and permission-aware actions.
- Limit inline fields to the few values operators actually batch edit. Move long text, payloads, history, and rare fields into an expanded card section, detail panel, or dialog.
- Show validation and dirty state per card. Provide per-card save/revert when edits are independent; provide rail-level save all/revert all only when batch commit is explicit.
- For permissions, hide unavailable workflows, render non-editable fields as read-only text, and make locked cards visibly passive without looking broken.
- For validation, place field errors beside the field, summarize invalid/dirty card counts in the rail, and keep partial save failures attached to the affected card.
- Define card-grid edge states: loading skeletons, empty/no-results copy, no-permission passive state, and stale/conflict save feedback. Add duplicate/delete/reorder controls only when the module workflow truly owns those lifecycle actions.
- Keep cards visually QTM: white/near-white surface, `#010120` text, thin black borders, `4px` controls, `8px` card radius, subtle blue shadow, mono uppercase labels.
- Preserve scanability with consistent field order, fixed card actions, compact labels, and no tall hero/chrome above the card grid.
- Preserve accessibility: logical tab order inside each card, visible focus states, `aria-invalid`/error text for fields, and touch-safe controls.
- On mobile, cards can become single-column forms; keep the rail controls above the grid or collapsible, not a competing side panel.

Do not replace AG Grid with cards just to look modern. If records need column comparison, many rows, copyable cells, Excel export, or dense sorting, keep the table and use cards only for selected-row detail, a view toggle, selected-record edit mode, or a separate edit route.

## Detail Pattern

Use selected-row detail panels for operational records:
- Table row shows scan-level fields: status, actor/entity, timestamp, key reference.
- Detail panel shows metadata, timeline, payload/evidence, notes, and contextual actions.
- Raw JSON or technical payloads should be secondary/collapsible where possible.
- Avoid nested expanded table rows when they reduce scanability.

## Permission Pattern

- Hide unauthorized audit counts, trash counts, buttons, and workflows entirely.
- Passive markers must not look clickable.
- Disabled controls are acceptable only when the user benefits from knowing the action exists.

## Reuse Guidance

- Reuse an existing neutral shell before inventing a new abstraction.
- Abstract structure, not domain logic: shell, hero, summary cards, filter bar, grid frame, detail panel.
- Keep statuses, columns, filters, permissions, payload rendering, and workflow actions module-owned until repeated across modules.
- If three pages share the same shape, extract carefully; if one page is unique, keep it local.

Shared layout standards should also include toolbar alignment and width behavior, not only colors and hero styling. If the project decides that filter-heavy AG Grid pages are right-biased and width-maximizing, encode that in shared shell/frame components so new modules inherit it automatically.

## Shared Standard Files

When a UI pattern should become the project standard, create one shared source of truth and make new modules import it instead of copying markup/CSS.

Use this extraction order:
- Tokens first: colors, font stacks, shadows, radius, grid CSS variables.
- Shell second: workspace page wrapper, hero, content frame, metric card.
- Table standard third: AG Grid wrapper, default column definition, common table options, action button shape, empty/loading treatment.
- Module adapters last: module-owned columns, filters, statuses, permission rules, and workflow handlers.

Good shared files:
- `workspaceStyles.ts` for QTM tokens and class strings.
- `WorkspaceShell.tsx` / `WorkspaceHero.tsx` for consistent page headers.
- `DataConsoleFrame.tsx` for summary/filter/grid/detail composition.
- `QtmControlRail.tsx` for the sticky right-side control rail pattern used by filter-heavy AG Grid modules.
- `QtmCardGrid.tsx` / `QtmEditableRecordCard.tsx` for Project Grid-style card editing when multiple modules share the same card edit shell.
- `QtmAgGrid.tsx` or `createQtmGridDefaults.ts` for common AG Grid options.
- `qtm-ag-grid.css` for global neutral table skin plus scoped extension examples.

Do not copy a polished table or a one-off rail into each module. New modules should pass data, columns, filter sections, actions, and detail content into the shared standard.

When a module follows the Project Grid interaction model, prefer a shared sticky right-side `QtmControlRail.tsx` over ad-hoc per-page filter panels.

## Quick Reference

| Need | Choose |
|------|--------|
| 2,000+ records | Table-first workspace with attached filters |
| Logs/history/audit | Data console + selected-row detail panel |
| Special table header polish | Scoped wrapper CSS, not global theme mutation |
| QTM AG Grid header | Use the `/qtm-ui-example` radial + linear gradient on scoped header cells |
| Pinned/action header | Same gradient and borders as the rest of the header row |
| Header alignment across modules | Shared hero language, not one-off icon headers |
| Dense row actions | Pinned compact icon-only action column |
| Table columns leave unused width | Shared grid wrapper gives flex to ordinary non-fixed columns |
| Cell text overlaps adjacent columns | Add scoped overflow containment plus `min-width: 0` on cell value/wrapper and renderer children |
| Themed horizontal scrollbar with pinned columns | Style viewport AND both spacer scrollbars; sharp `4px` thumb, neutral track |
| Scrollbar must stay reachable on long pages | `alwaysShowHorizontalScroll` prop — not a custom sticky bar |
| New module using AG Grid | Shared QTM grid defaults + module-owned columns |
| Batch editing field-light records | Project Grid-style card editing grid + `QtmControlRail` |
| Card edit has many long fields | Use detail panel/dialog for rare fields; keep card compact |
| Need comparison, copy, export, or 2,000+ rows | Keep AG Grid table-first; cards are optional edit mode only |
| Mixed table and card needs | Keep AG Grid as default and expose cards via view toggle, selected edit mode, or separate route |
| Need concrete QTM card examples | Use `references/qtm-ui-patterns.md` as the portable source of truth |
| Many filters matching Project Grid behavior | Shared sticky `QtmControlRail.tsx` |
| `All / Mismatch / Pending / Failed` filter block | Compact status strip: low cards, no captions/icons, table stays high |
| Top filters consume too much height | Remove decorative captions/icons, reduce padding/gaps, attach controls to the data frame |
| Many filters on desktop | Keep passive context left, active controls right |
| Too much empty page gutter | Widen shell and let table consume the useful width |
| Too much scroll before the grid | Shrink hero/chrome and keep filters/table above the fold |
| More visual premium | Better spacing, borders, typography, and scoped gradients; not dark hero drama |
| Sidebar group labels duplicate collapsible names | Drop the group label; keep only one mono divider (`ADMINISTRATION`) at the privileged section |
| Sidebar feels icon-spammed | Icons on top-level only; sub-items inside a collapsible are text-only |
| Sidebar active-state color choice | Top-level = Dark Solid `#010120` + white; sub-item = Soft Lavender tint `rgba(189,187,255,0.22)` + Dark Blue |
| Parent collapsible repeats first child name | Rename parent to broader category (`Assets`, not `Assets Manage` ▸ `Asset Management`) |
| Redesigning the whole product UI | Apply every section of this skill across all pages; don't fix one screen and leave the shell/sidebar untouched |

## Example

```tsx
<NeutralWorkspaceShell
  eyebrow="Operations Console"
  title="Vendor Device Audit"
  description="Review vendor payloads, mismatches, and device readiness without leaving the table."
  metrics={auditMetrics}
  actions={<ExportButton />}
>
  <AuditSummaryCards value={statusFilter} onChange={setStatusFilter} />
  <AuditFilterBar query={query} onQueryChange={setQuery} />
  <AuditGrid
    className="vendor-audit-grid"
    rowData={rows}
    selectedId={selected?.id}
    onSelect={setSelected}
  />
  {selected && <AuditDetailPanel record={selected} />}
</NeutralWorkspaceShell>
```

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| Dark glossy dashboard for normal operations | Use white pastel-cloud hero and table-first layout |
| Generic right drawer for everything | Prefer selected-row detail panel unless drawer preserves context better |
| Global `.ag-theme-quartz` changes for one module | Add a module wrapper class and scope the CSS |
| QTM table header left flat white or simple lavender gradient | Use the `/qtm-ui-example` radial magenta/lavender plus pale blue-white linear header gradient |
| Pinned action column header has different background | Apply the same scoped header gradient and borders to pinned/action headers |
| Columns stop short of table width | Add shared fill-width sizing: ordinary columns get `flex: 1`; fixed/pinned columns keep explicit width |
| Long asset/user text bleeds into next column | Constrain flex cells with `overflow: hidden`, `min-width: 0`, and renderer-level truncation |
| Fixing one page's widths by hand | Put sizing defaults in `QtmAgGrid.tsx`/shared wrapper so all QTM tables inherit the behavior |
| KPI cards that only decorate | Make cards informative, filterable, or remove them |
| Status filter block looks like tall KPI cards | Convert to compact low-profile filter strip with label + value only |
| Filter block pushes the table below the fold | Reduce card height, gaps, captions, icons, and attach controls to the data frame |
| Card grid used for high-volume comparison/export | Keep AG Grid as the primary canvas and offer card edit mode only if needed |
| Editable cards with no dirty/validation state | Show per-card dirty markers, validation, save, and revert affordances |
| Cards stuffed with every field | Keep inline fields field-light; move rare/long fields to detail panel or dialog |
| Invalid cards only shown in local fields | Summarize dirty/invalid counts in the rail and keep partial save failures on affected cards |
| Card grid has no loading/empty/conflict states | Define operational edge states before polishing visuals |
| Filters spread randomly across the toolbar | Bias passive context left and interactive filters/actions right |
| Wide desktop page with big empty side gutters | Use a wider shell and let the table own the width |
| Tall hero pushes grid too far down | Compress hero and toolbar so the table starts higher |
| Rebuilding the rail inside every module page | Extract `QtmControlRail.tsx` and pass module-owned sections/actions |
| Abstracting `OperationalModuleLayout` too early | Reuse existing neutral shell; extract only after repeated behavior |
| Text-heavy action cells | Use compact pinned icon actions with accessible labels |
| Themed horizontal scrollbar shows a colored stripe under pinned columns | Style spacer scrollbars too (`.ag-horizontal-left-spacer`/`-right-spacer`), not just `.ag-body-horizontal-scroll-viewport` |
| Building a custom sticky horizontal scrollbar with portals/observers | Use AG Grid's `alwaysShowHorizontalScroll` prop and theme it; the custom approach is fragile across versions |
| Pill (`border-radius: 999px`) scrollbar thumb on enterprise tables | Use sharp `4px` radius; pills break the QTM sharp-geometry rule |
| Sidebar has a `SidebarGroupLabel` above every group | Drop redundant labels; one mono `ADMINISTRATION` divider is enough |
| Top-level icon AND a sub-item icon for the same row | Keep top-level icons (collapsed mode needs them); sub-items rely on the left-rail border + indent |
| Parent collapsible "Assets Manage" with sub "Asset Management" | Rename parent to broader category so the parent and first child don't read the same |
| Sidebar buttons still use `rounded-xl` or `rounded-lg` | All sidebar surfaces are `rounded-[4px]` per the sharp-geometry rule |
| Legacy `#6C2888` / `var(--quanterm-purple-*)` chrome left on the sidebar | Active state is Dark Solid `#010120`; soft tint uses Soft Lavender, never brand purple |
| Avatar tile is a yellow/orange gradient circle | Square `4px` Dark Blue tile with white initials — matches sharp geometry and Dark Blue anchor |
| Sign-out is a red pill (`rounded-xl bg-red-50`) | Neutral 4px track with red text; hover flips to red bg + white text |
| Module-level visual upgrade ships without updating the app shell/sidebar | Wholesale UI redesigns must touch every section of this skill, including the sidebar |

## Reference

For portable card rules, examples, and reusable constants, see `references/qtm-ui-patterns.md`.
