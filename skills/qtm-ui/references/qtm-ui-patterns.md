# QTM UI Patterns Reference

This reference distills reusable QTM UI/UX structure into portable guidance for future projects. It is source material, not a session narrative.

## Brand Tokens

| Token | Value | Use |
|-------|-------|-----|
| Dark Blue | `#010120` | Primary dark text/surface anchor |
| Magenta | `#ef2cc1` | Decorative gradient accent only |
| Orange | `#fc4c02` | Decorative gradient endpoint only |
| Lavender | `#bdbbff` | Soft secondary gradient/highlight |
| Light Border | `rgba(0,0,0,0.08)` | Cards, badges, frame borders |
| Blue Shadow | `rgba(1,1,32,0.1) 0px 4px 10px` | Subtle elevation |

## Typography

- Display: `"The Future", Arial, sans-serif`.
- Mono labels: `"PP Neue Montreal Mono", ui-monospace, SFMono-Regular, monospace`.
- Use medium weights instead of bold-heavy UI.
- Use tight negative tracking for display/title text.
- Use uppercase mono labels for eyebrows, metadata, metric labels, and table signposts.

## Hero Shape

```tsx
<header
  className="relative overflow-hidden rounded-[8px] border border-black/[0.08] bg-white p-4 sm:p-5"
  style={{ boxShadow: 'rgba(1, 1, 32, 0.1) 0px 4px 10px', background: '#ffffff' }}
>
  <div
    aria-hidden
    className="pointer-events-none absolute inset-0"
    style={{
      background: 'radial-gradient(circle at 12% 0%, rgba(189,187,255,0.22), rgba(255,255,255,0) 38%), radial-gradient(circle at 78% 12%, rgba(239,44,193,0.08), rgba(255,255,255,0) 34%), linear-gradient(135deg, rgba(255,255,255,0.96) 0%, rgba(247,246,255,0.82) 58%, rgba(238,244,255,0.72) 100%)',
    }}
  />
  <div className="relative flex flex-col gap-4 xl:flex-row xl:items-end xl:justify-between">
    <div className="min-w-0">
      <p className="font-mono text-[11px] font-medium uppercase leading-none tracking-[0.055px] text-[#010120]/60">Eyebrow</p>
      <h1 className="mt-2 text-[30px] font-medium leading-[1.05] tracking-[-0.8px] text-[#010120] sm:text-[34px] lg:text-[38px]">Page Title</h1>
      <p className="mt-2 max-w-3xl text-sm leading-[1.3] tracking-[-0.14px] text-[#010120]/65">Short operational description.</p>
    </div>
  </div>
</header>
```

## Neutral Workspace Shell

```tsx
export function NeutralWorkspaceShell({ eyebrow, title, description, metrics, actions, children }) {
  return (
    <div className="min-h-screen bg-white text-black">
      <div className="mx-auto flex max-w-[1400px] flex-col gap-6 px-4 py-6 sm:px-6 lg:px-8 lg:py-8">
        <WorkspaceHero eyebrow={eyebrow} title={title} description={description} metrics={metrics} actions={actions} />
        <main className="space-y-6">{children}</main>
      </div>
    </div>
  );
}
```

## Data Console Structure

Use this for logs, audit trails, borrowing records, history, feedback, and webhook pages:

```tsx
<NeutralWorkspaceShell {...heroProps}>
  <SummaryCards activeFilter={filter} onFilterChange={setFilter} />
  <FilterBar query={query} status={status} onChange={updateFilters} />
  <GridFrame>
    <AgGridReact rowData={rows} columnDefs={columns} enableCellTextSelection ensureDomOrder />
  </GridFrame>
  {selectedRow && <DetailPanel record={selectedRow} />}
</NeutralWorkspaceShell>
```

## Operational Card Reference

Use cards only when they improve scanability, filtering, or fast action. These are the four safe variants:

| Variant | Purpose | Rules |
|---------|---------|-------|
| Status filter card | Show a table-backed status count and optional active filter | Clear selected state; clicking must map to a real filter |
| Operational metric card | Summarize a neutral table-backed KPI | White surface, Dark Blue value, concise caption |
| Risk exception card | Highlight records needing attention | Amber/rose only for status meaning, not broad decorative chrome |
| Action prompt card | Offer one contextual workflow entry point | Visible button text or accessible label; no fake inactive controls |

Card rules:
- Every card needs an operational purpose: filter, metric, risk, or action. Remove decorative-only cards.
- Keep cards compact and table-adjacent, usually above the filter/action bar or inside the data frame header area.
- Use white/near-white surfaces, `#010120` primary text, thin borders, `8px` card radius, `4px` controls, mono uppercase labels, and subtle dark-blue shadow.
- Risk accents are status semantics only. Do not turn warning colors into the page chrome.
- If a card looks clickable, it must either perform an action/filter or be made visibly passive.
- Do not replace AG Grid with cards for high-volume comparison, copy, export, or dense sorting.

Portable card section example:

```tsx
const operationalCards = [
  {
    label: 'Status filter',
    title: 'Mismatch queue',
    value: '02',
    caption: 'Applies a real table filter for records that need review.',
    tone: 'active',
    meta: 'Needs review',
    filterValue: 'mismatch',
  },
  {
    label: 'Operational metric',
    title: 'Payload sync',
    value: '98%',
    caption: 'Neutral KPI backed by the current table dataset.',
    tone: 'neutral',
    meta: 'Last 24h',
  },
  {
    label: 'Risk exception',
    title: 'Retry required',
    value: '01',
    caption: 'Warning color is status meaning, not decorative chrome.',
    tone: 'risk',
    meta: 'Webhook',
  },
  {
    label: 'Action prompt',
    title: 'Review exceptions',
    value: 'Batch',
    caption: 'One compact workflow entry point with visible button text.',
    tone: 'action',
    actionLabel: 'Open queue',
  },
] as const;

type OperationalCardItem = (typeof operationalCards)[number];

type OperationalCardSectionProps = {
  activeFilter: string | null;
  onFilterChange: (filterValue: string | null) => void;
  onActionClick: (card: Extract<OperationalCardItem, { actionLabel: string }>) => void;
};

function OperationalCard({ card, activeFilter, onFilterChange, onActionClick }: {
  card: OperationalCardItem;
} & OperationalCardSectionProps) {
  const surface = card.tone === 'active'
    ? 'border-[#010120]/20 bg-[#f7f6ff] shadow-[rgba(1,1,32,0.10)_0px_6px_14px]'
    : card.tone === 'risk'
      ? 'border-amber-200 bg-[#fffaf0] shadow-[rgba(120,53,15,0.08)_0px_6px_14px]'
      : 'border-[#010120]/[0.08] bg-white shadow-[rgba(1,1,32,0.07)_0px_4px_12px]';

  const content = (
    <>
      <div className="pointer-events-none absolute -right-8 -top-8 h-24 w-24 rounded-full bg-[#d9d7ff]/30 blur-2xl" />
      <div className="relative font-mono text-[10px] font-medium uppercase tracking-[0.14em] text-[#010120]/45">
        {card.label}
      </div>
      <h3 className="relative mt-2 text-base font-semibold tracking-[-0.03em] text-[#010120]">
        {card.title}
      </h3>
      <div className="relative mt-5 flex items-end justify-between gap-3">
        <div>
          <div className="text-3xl font-medium leading-none tracking-[-0.06em] text-[#010120]">
            {card.value}
          </div>
          <div className="mt-2 text-xs leading-5 text-black/55">{card.caption}</div>
        </div>
        {'actionLabel' in card ? (
          <button
            type="button"
            onClick={() => onActionClick(card)}
            className="h-8 rounded-[4px] bg-[#010120] px-3 text-xs text-white hover:bg-[#010120]/85"
          >
            {card.actionLabel}
          </button>
        ) : (
          <div className="rounded-[4px] border border-black/[0.08] bg-white/70 px-2 py-1 font-mono text-[10px] uppercase tracking-[0.12em] text-black/45">
            {card.meta}
          </div>
        )}
      </div>
    </>
  );

  if ('filterValue' in card) {
    return (
      <button
        type="button"
        aria-pressed={activeFilter === card.filterValue}
        onClick={() => onFilterChange(activeFilter === card.filterValue ? null : card.filterValue)}
        className={`relative overflow-hidden rounded-[8px] border p-4 text-left ${surface}`}
      >
        {content}
      </button>
    );
  }

  return (
    <article className={`relative overflow-hidden rounded-[8px] border p-4 ${surface}`}>
      {content}
    </article>
  );
}

function OperationalCardSection({ activeFilter, onFilterChange, onActionClick }: OperationalCardSectionProps) {
  return (
    <section className="rounded-[8px] border border-[#010120]/[0.08] bg-[#fbfbff] p-4 shadow-[rgba(1,1,32,0.06)_0px_4px_12px]">
      <div className="mb-4">
        <p className="font-mono text-[11px] font-medium uppercase tracking-[0.16em] text-black/45">
          Card system reference
        </p>
        <h2 className="mt-2 text-xl font-medium tracking-[-0.03em] text-[#010120]">
          QTM operational card variants
        </h2>
      </div>
      <div className="grid gap-3 md:grid-cols-2 xl:grid-cols-4">
        {operationalCards.map((card) => (
          <OperationalCard
            key={card.label}
            card={card}
            activeFilter={activeFilter}
            onFilterChange={onFilterChange}
            onActionClick={onActionClick}
          />
        ))}
      </div>
    </section>
  );
}

type ExampleRow = { status: string };

// Host tables should map each filter card's filterValue to the same field/value
// used by the table filter.
const filteredRows = activeFilter
  ? rows.filter((row: ExampleRow) => row.status === activeFilter)
  : rows;
```

## Shared Standard File Pattern

The QTM approach should be packaged as shared UI files, then reused by feature modules. The standard owns structure and behavior defaults; the module owns business specifics.

Suggested structure:

```text
components/qtm-workspace/
  workspaceStyles.ts
  WorkspaceShell.tsx
  WorkspaceHero.tsx
  MetricCard.tsx
  DataConsoleFrame.tsx
  DetailPanelShell.tsx
  QtmControlRail.tsx
  QtmCardGrid.tsx
  QtmEditableRecordCard.tsx
  QtmAgGrid.tsx
  qtm-ag-grid.css
```

Example shared grid defaults:

```tsx
import type { ColDef, GridOptions } from 'ag-grid-community';
import { AgGridReact } from 'ag-grid-react';

export const qtmDefaultColDef: ColDef = {
  sortable: true,
  resizable: true,
  filter: true,
};

export const qtmGridOptions: GridOptions = {
  animateRows: true,
  enableCellTextSelection: true,
  ensureDomOrder: true,
  suppressCellFocus: false,
};

export function QtmAgGrid<TData>({ className, columnDefs, rowData, loading }) {
  return (
    <div className={`${className ?? ''} ag-theme-quartz h-[62vh] min-h-[460px] w-full`}>
      <AgGridReact<TData>
        theme="legacy"
        rowData={rowData}
        columnDefs={columnDefs}
        defaultColDef={qtmDefaultColDef}
        loading={loading}
        {...qtmGridOptions}
      />
    </div>
  );
}
```

Example module usage:

```tsx
<div className="grid grid-cols-1 gap-5 lg:grid-cols-[minmax(0,1fr)_340px] xl:grid-cols-[minmax(0,1fr)_360px]">
  <DataConsoleFrame
    summary={<BorrowingSummaryCards value={status} onChange={setStatus} />}
    table={
      <QtmAgGrid<Borrowing>
        className="borrowing-grid"
        rowData={rows}
        columnDefs={borrowingColumns}
        loading={loading}
      />
    }
    detail={selected ? <BorrowingDetailPanel record={selected} /> : null}
  />

  <QtmControlRail
    summaryText={`Showing ${visibleRows.length} of ${allRows.length}`}
    searchValue={query}
    onSearchValueChange={setQuery}
    sections={railSections}
  />
</div>
```

Extraction rule: if two modules need the same visual structure, put the structure in shared QTM files. If only one module needs it, keep it local. Never move business-specific columns, statuses, permissions, or workflow transitions into the shared standard just to make the abstraction look complete.

## Project Grid Card Editing

Use this when a module needs to edit several field-light records in place. Keep AG Grid for high-volume comparison, copy, export, and dense scanning.

```tsx
<div className="grid gap-5 lg:grid-cols-[minmax(0,1fr)_340px] xl:grid-cols-[minmax(0,1fr)_360px]">
  <section className="min-w-0 space-y-4">
    <div className="grid grid-cols-1 gap-3 sm:grid-cols-2 xl:grid-cols-3 2xl:grid-cols-4">
      {records.map((record) => (
        <QtmEditableRecordCard
          key={record.id}
          record={record}
          dirty={dirtyIds.has(record.id)}
          errors={errors[record.id]}
          saveError={saveErrors[record.id]}
          canEdit={canEditRecord(record)}
          onChange={updateDraft}
          onSave={saveOne}
          onRevert={revertOne}
        />
      ))}
    </div>
  </section>

  <QtmControlRail
    summaryText={`${visibleRecords.length} visible cards · ${dirtyIds.size} dirty · ${invalidIds.size} invalid`}
    searchValue={query}
    onSearchValueChange={setQuery}
    sections={[
      { label: 'View', content: <ViewModeButtons value="cards" /> },
      { label: 'Filters', content: <CardFilters /> },
      { label: 'Batch actions', borderedTop: true, content: <SaveAllActions /> },
    ]}
  />
</div>
```

Card anatomy:
- Header: record code/name, branch or owner, status badge, dirty marker.
- Body: only the few fields operators batch edit repeatedly.
- Footer: per-card save/revert or permission-aware locked state.
- Overflow: long notes, payloads, history, and rare fields go to detail panel, expanded section, or dialog.

Behavior rules: field errors stay beside the field, partial save failures stay on the affected card, read-only fields render as passive text, unavailable workflows are hidden rather than shown as broken controls, and loading/empty/no-permission/conflict states are designed before visual polish.

Lifecycle controls: duplicate, delete, reorder, and bulk selection are module-owned workflow decisions. Do not add them just because the surface is card-based.

Accessibility rules: keep logical tab order inside each card, visible focus states, `aria-invalid` and error text for invalid fields, and touch-safe controls on mobile.

Visual rules: white/near-white cards, thin black border, `8px` radius, subtle `rgba(1, 1, 32, 0.1)` shadow, mono uppercase labels, compact `4px` controls, consistent field order across all cards.

## Toolbar Alignment Standard

When the module behaves more like Project Grid than a flat toolbar page, use a sticky right-side control rail instead of spreading controls across a horizontal top bar.

Preferred shared component:

```tsx
<QtmControlRail
  summaryText={`Showing ${visibleRows.length} of ${allRows.length}`}
  searchValue={query}
  onSearchValueChange={setQuery}
  sections={[
    { label: 'Source', content: <SourceButtons /> },
    { label: 'Review Tabs', content: <StatusButtons /> },
    { label: 'Actions', borderedTop: true, content: <RailActions /> },
  ]}
/>
```

For wide desktop AG Grid pages, the toolbar should follow a predictable split:

- Left side: passive context only.
  - section label
  - sub-title
  - row count
  - mode/status summary
- Right side: active controls.
  - search
  - status filter
  - branch/type/date filters
  - refresh/export/create actions

Example structure:

```tsx
<div className="flex flex-col gap-3 lg:flex-row lg:items-end lg:justify-between">
  <div className="min-w-0">
    <p className="font-mono text-[11px] uppercase tracking-[0.14em] text-black/45">Audit ledger</p>
    <h2 className="mt-2 text-xl font-medium tracking-[-0.03em] text-[#010120]">Inbound request ledger</h2>
    <p className="mt-1 text-sm text-black/60">Page-local context and row count live on the left.</p>
  </div>

  <div className="flex flex-wrap items-center justify-start gap-2 lg:justify-end">
    <SearchInput />
    <StatusFilter />
    <BranchFilter />
    <RefreshButton />
    <ExportButton />
  </div>
</div>
```

## Width Utilization Standard

- Use wide shells for table-heavy pages: `max-w-[1400px]` minimum, and widen further if the module truly needs more horizontal room.
- Avoid narrow centered page wrappers that create large empty gutters on both sides while the table is cramped.
- If width pressure exists, first remove ornamental spacing and compress low-information columns before accepting avoidable horizontal scroll.
- Sidebars and secondary rails are justified only when their value exceeds the width they steal from the table.

## Scroll Efficiency Standard

- Keep the hero compact and the grid high on the page.
- Above the fold should include:
  - page identity
  - the active toolbar
  - the first visible portion of the table
- Prefer compact summary cards and compact toolbars over tall decorative chrome.
- Use sticky behavior for filter/tool bars when it improves continuous scanning, especially on long operational pages.
- Avoid multiple competing vertical scroll zones unless the workflow clearly benefits from them.

## AG Grid Baseline CSS

```css
.ag-theme-quartz {
  --workspace-navy: #010120;
  --workspace-border: rgba(1, 1, 32, 0.1);
  --workspace-border-strong: rgba(1, 1, 32, 0.2);
  --ag-border-radius: 0;
  --ag-wrapper-border-radius: 0;
  --ag-header-background-color: #fbf9ff;
  --ag-header-foreground-color: var(--workspace-navy);
  --ag-row-hover-color: rgba(0, 0, 0, 0.03);
  --ag-selected-row-background-color: rgba(0, 0, 0, 0.05);
  --ag-primary-color: #000000;
  --ag-accent-color: #000000;
}

.ag-theme-quartz .ag-header,
.ag-theme-quartz .ag-pinned-left-header,
.ag-theme-quartz .ag-pinned-right-header {
  background:
    radial-gradient(circle at 8% 0%, rgba(239, 44, 193, 0.1), transparent 34%),
    radial-gradient(circle at 70% -20%, rgba(189, 187, 255, 0.22), transparent 42%),
    linear-gradient(135deg, rgba(255, 255, 255, 0.96) 0%, rgba(250, 247, 255, 0.98) 48%, rgba(239, 247, 255, 0.96) 100%);
  border-bottom-color: var(--workspace-border-strong);
}

.ag-theme-quartz .ag-header-cell-resize {
  width: 8px !important;
  opacity: 0 !important;
  pointer-events: auto;
  cursor: col-resize;
}

.ag-theme-quartz .ag-header-cell-resize::after {
  display: none !important;
}
```

## Sidebar Standard

The QTM sidebar = white surface + Dark Blue anchor + sharp `4px` + neutral borders + mono group label as a divider. Top-level keeps icons (collapsed mode), sub-items are text-only. The snippets below are portable guidance; adapt them to the target project's local sidebar primitives and composition files.

### Shell + Trigger

```tsx
// sidebar.tsx — primitive shell
const sidebarVariants = cva(
  "flex h-screen shrink-0 flex-col overflow-hidden border-r border-[rgba(0,0,0,0.08)] bg-white transition-all duration-300",
  {
    variants: {
      state: {
        expanded: "w-72",
        collapsed: "w-20",
      },
    },
    defaultVariants: { state: "expanded" },
  }
);

// Trigger button — sharp 4px, neutral hover
<Button
  className="h-9 w-9 shrink-0 rounded-[4px] text-[#010120]/70 hover:bg-[rgba(0,0,0,0.04)] hover:text-[#010120]"
>
  <PanelLeft className="h-5 w-5" />
</Button>
```

### Header (logo + wordmark + mono subtitle)

```tsx
// AppSidebar.tsx — keep the brand image; replace any purple wordmark
<SidebarHeader className="px-4 py-4">
  <div className="flex items-start justify-between gap-3">
    <div className="flex min-w-0 items-center gap-3">
      <img src="<brand-logo-url>" alt="Quanterm Logo" className="h-10 w-10 shrink-0 object-contain" />
      {!isCollapsed && (
        <div className="min-w-0">
          <h1 className="truncate text-lg font-medium tracking-[-0.4px] text-[#010120]">Quanterm</h1>
          <p className="truncate text-[10px] font-medium uppercase tracking-[0.08em] text-black/55">
            Asset &amp; Project Manager
          </p>
        </div>
      )}
    </div>
    <SidebarTrigger className="shrink-0" />
  </div>
</SidebarHeader>
```

### Group label (mono divider, used ONCE)

```tsx
// sidebar.tsx — group label style
function SidebarGroupLabel(props) {
  return (
    <div
      className="px-3 pb-1 text-[11px] font-medium uppercase tracking-[0.08em] text-black/55"
      {...props}
    />
  );
}

// AppSidebar.tsx — only ONE group label survives, above privileged cluster
<SidebarGroup className="mt-2 border-t border-[rgba(0,0,0,0.08)] pt-4">
  {!isCollapsed && <SidebarGroupLabel>Administration</SidebarGroupLabel>}
  <SidebarGroupContent>{/* User Management, Webhook Logs */}</SidebarGroupContent>
</SidebarGroup>
```

### Top-level menu button (Dark Solid active CTA)

```tsx
// sidebar.tsx — variant
const sidebarMenuButtonVariants = cva(
  "group flex w-full items-center gap-3 rounded-[4px] px-3 py-2.5 text-left text-[15px] font-medium tracking-[-0.16px] text-[#010120]/80 transition-all duration-150 hover:bg-[rgba(0,0,0,0.04)] hover:text-[#010120] data-[active=true]:bg-[#010120] data-[active=true]:text-white data-[active=true]:shadow-[rgba(1,1,32,0.1)_0px_4px_10px]",
  {
    variants: {
      collapsed: { true: "justify-center px-0", false: "" },
    },
  }
);
```

### Sub-item button (Soft Lavender active tint, text-only)

```tsx
// sidebar.tsx — sub-button variant
<Comp
  className="flex items-center gap-3 rounded-[4px] px-3 py-2 text-[14px] font-normal tracking-[-0.14px] text-[#010120]/70 transition-all duration-150 hover:bg-[rgba(0,0,0,0.04)] hover:text-[#010120] data-[active=true]:bg-[rgba(189,187,255,0.22)] data-[active=true]:font-medium data-[active=true]:text-[#010120]"
/>

// Sub-list rail
<ul className="ml-4 mt-1 space-y-1 border-l border-[rgba(0,0,0,0.08)] pl-3 pb-1">
  {/* sub-items: text-only, NO icon */}
</ul>

// A sub-item is just <NavLink><span>Label</span></NavLink>
<SidebarMenuSubButton asChild isActive={location.pathname === item.href}>
  <NavLink to={item.href}>
    <span className="tracking-tight">{item.label}</span>
  </NavLink>
</SidebarMenuSubButton>
```

### Collapsible parent — no name duplication with first child

```tsx
// GOOD — parent is a broader category
<SidebarCollapsibleTrigger asChild>
  <SidebarMenuButton tooltip="Assets">
    <Package className="h-5 w-5 shrink-0" />
    <span className="tracking-tight">Assets</span>
    <ChevronDown className="ml-auto h-4 w-4 opacity-60 group-data-[state=open]/collapsible:rotate-180 group-data-[state=open]/collapsible:opacity-100" />
  </SidebarMenuButton>
</SidebarCollapsibleTrigger>
// Children: Asset Management, Inventory Management, IT Asset Borrowing, Asset History

// BAD — parent and first child read the same
// <SidebarMenuButton tooltip="Assets Manage">Assets Manage
//   ▸ Asset Management   ← duplicate noise
```

The chevron uses `opacity-*` (no explicit color) so it inherits `currentColor` and stays legible on both the Dark Solid active row (where `currentColor = white`) and the inactive row (Dark Blue).

### Footer: user card + sign-out

```tsx
<SidebarFooter>
  <div className="space-y-3">
    {!isCollapsed ? (
      <div className="flex items-center gap-3 rounded-[4px] border border-[rgba(0,0,0,0.08)] bg-white p-2.5">
        <div className="flex h-9 w-9 shrink-0 items-center justify-center rounded-[4px] bg-[#010120] text-[11px] font-medium uppercase tracking-[0.04em] text-white">
          {initials}
        </div>
        <div className="min-w-0">
          <p className="truncate text-sm font-medium tracking-[-0.14px] text-[#010120]">{displayName}</p>
          <p className="truncate text-[11px] text-black/55">{email}</p>
        </div>
      </div>
    ) : (
      <div className="flex justify-center">
        <div className="flex h-10 w-10 items-center justify-center rounded-[4px] bg-[#010120] text-[12px] font-medium uppercase tracking-[0.04em] text-white">
          {initials}
        </div>
      </div>
    )}

    <Button
      variant="ghost"
      className={`flex w-full items-center gap-2.5 rounded-[4px] border border-[rgba(0,0,0,0.08)] bg-[rgba(0,0,0,0.04)] py-2 text-sm font-medium tracking-[-0.14px] text-red-600 transition-all duration-150 hover:border-red-500 hover:bg-red-500 hover:text-white ${isCollapsed ? "justify-center px-0" : "justify-start px-3"}`}
      onClick={handleLogout}
    >
      <LogOut className="h-4 w-4" />
      {!isCollapsed && <span>Sign Out</span>}
    </Button>
  </div>
</SidebarFooter>
```

### Information-Architecture Checklist

Before shipping a sidebar change, verify:

| Check | Pass criterion |
|-------|----------------|
| Group labels | ≤ 1 in the entire sidebar (the privileged divider) |
| Parent vs. first child names | Different — parent reads as a broader category |
| Sub-item icons | Zero. Top-level only. |
| Active state | Top-level = `bg-[#010120]` + `text-white`; sub-item = `bg-[rgba(189,187,255,0.22)]` |
| Radius | Every interactive surface = `rounded-[4px]` |
| Brand purple `#6C2888` / `--quanterm-purple-*` | Zero matches in the sidebar files |
| Avatar | 4px square Dark Blue tile, not gradient circle |
| Sign-out | Neutral track + red text, not red pill |
| Collapsed mode (`w-20`) | All top-level rows still have an icon; tooltips set |
| Negative tracking | All label text uses `tracking-tight` / `tracking-[-0.1Xpx]`, never `tracking-wide` |

### Failure Modes

| Symptom | Cause |
|---------|-------|
| Sidebar feels "busy" / icon-spammed | Sub-items kept their icons; the left-rail + indent already signal nesting |
| Reading the same word twice ("Handover" group label + "Handover Minutes" collapsible) | Redundant `SidebarGroupLabel` above a self-labelling collapsible |
| Active item looks pastel/timid on a busy page | Top-level uses soft lavender instead of Dark Solid CTA — swap to `bg-[#010120] text-white` |
| Chevron disappears against the active row | Chevron had an explicit `text-slate-400` instead of inheriting `currentColor` via `opacity-*` |
| Sidebar still feels like the old purple Quanterm | Search for `#6C2888` and `var(--quanterm-purple` in the sidebar files; replace with Dark Blue / Soft Lavender |
| `w-20` collapsed mode shows blank rows | Stripped a top-level icon; only sub-item icons should have been removed |

## Themed Horizontal Scrollbar (Pinned-Spacer Gotcha)

When pinning a column, AG Grid's horizontal scroll row contains three sibling elements, and **each of the two spacers has its own `overflow-x: scroll`** (see `ag-grid.css`, rule `.ag-horizontal-left-spacer, .ag-horizontal-right-spacer { overflow-x: scroll; }`). That means a single grid renders three native scrollbars side by side:

```
[ .ag-horizontal-left-spacer ][ .ag-body-horizontal-scroll-viewport ][ .ag-horizontal-right-spacer ]
       ^ own scrollbar              ^ own scrollbar                       ^ own scrollbar
```

If you style `::-webkit-scrollbar` only on the viewport, the two spacers still render the **OS-default** scrollbar — on Windows that shows up as a foreign-colored stripe (often reading as lavender/purple) directly under the pinned column. The fix is to theme all three scrollbars together: matching neutral track everywhere, real thumb on the viewport, invisible thumb inside the spacers (no content to scroll there).

Pair this with AG Grid's `alwaysShowHorizontalScroll` prop on `<AgGridReact>` so the scrollbar is always reachable, instead of inventing a custom portal-based sticky scrollbar.

```css
/* Scope to a module wrapper class — never globally. */
.module-grid.ag-theme-quartz .ag-body-horizontal-scroll-viewport {
  scrollbar-width: thin;
  scrollbar-color: #010120 transparent;
}

.module-grid.ag-theme-quartz .ag-body-horizontal-scroll-viewport::-webkit-scrollbar {
  height: 12px;
  background: transparent;
}

.module-grid.ag-theme-quartz .ag-body-horizontal-scroll-viewport::-webkit-scrollbar-track {
  background: transparent;
}

.module-grid.ag-theme-quartz .ag-body-horizontal-scroll-viewport::-webkit-scrollbar-thumb {
  background: #010120;
  border-radius: 4px;                /* sharp QTM radius, never 999px */
  border: 3px solid transparent;      /* inset thumb so it doesn't kiss the track edges */
  background-clip: padding-box;
  min-width: 44px;
}

.module-grid.ag-theme-quartz .ag-body-horizontal-scroll-viewport::-webkit-scrollbar-thumb:hover {
  background: #1c1c45;
  background-clip: padding-box;
  box-shadow: inset 0 0 0 1px rgba(189, 187, 255, 0.4); /* Soft Lavender focus ring */
}

.module-grid.ag-theme-quartz .ag-body-horizontal-scroll-viewport::-webkit-scrollbar-thumb:active {
  background: #2a2a5c;
  background-clip: padding-box;
}

/* Unify the whole horizontal scroll row visually: same neutral track tone,
   strip the default header-style gradient/border from the spacers. */
.module-grid.ag-theme-quartz .ag-body-horizontal-scroll,
.module-grid.ag-theme-quartz .ag-body-horizontal-scroll-viewport,
.module-grid.ag-theme-quartz .ag-body-horizontal-scroll-container,
.module-grid.ag-theme-quartz .ag-horizontal-left-spacer,
.module-grid.ag-theme-quartz .ag-horizontal-right-spacer {
  background: rgba(0, 0, 0, 0.04) !important;
  background-image: none !important;
  border: none !important;
  box-shadow: none !important;
}

.module-grid.ag-theme-quartz .ag-body-horizontal-scroll {
  border-top: 1px solid rgba(0, 0, 0, 0.08) !important;
}

/* The spacers each have their own native scrollbar (from AG Grid's
   `overflow-x: scroll`). Theme those tracks to match and hide their
   thumbs — there is no content to scroll inside a spacer. */
.module-grid.ag-theme-quartz .ag-horizontal-left-spacer,
.module-grid.ag-theme-quartz .ag-horizontal-right-spacer {
  scrollbar-width: thin;
  scrollbar-color: transparent rgba(0, 0, 0, 0.04);
}

.module-grid.ag-theme-quartz .ag-horizontal-left-spacer::-webkit-scrollbar,
.module-grid.ag-theme-quartz .ag-horizontal-right-spacer::-webkit-scrollbar {
  height: 12px;
  background: rgba(0, 0, 0, 0.04);
}

.module-grid.ag-theme-quartz .ag-horizontal-left-spacer::-webkit-scrollbar-track,
.module-grid.ag-theme-quartz .ag-horizontal-right-spacer::-webkit-scrollbar-track {
  background: rgba(0, 0, 0, 0.04);
}

.module-grid.ag-theme-quartz .ag-horizontal-left-spacer::-webkit-scrollbar-thumb,
.module-grid.ag-theme-quartz .ag-horizontal-right-spacer::-webkit-scrollbar-thumb {
  background: transparent;
}
```

```tsx
// Pair the CSS with AG Grid's built-in always-visible scroll option,
// instead of building a custom sticky/portal scrollbar.
<AgGridReact
  className="module-grid"
  alwaysShowHorizontalScroll
  /* ...rest */
/>
```

Failure modes to recognize:

| Symptom | Likely cause |
|---------|-------------|
| Colored/lavender stripe under pinned column on the scroll row | Spacers' own native scrollbars are unstyled; theme `.ag-horizontal-left/right-spacer` scrollbars too |
| Scrollbar shows but won't scroll | Custom pill overlay covering the real scrollbar; use `alwaysShowHorizontalScroll` instead |
| Scrollbar disappears when page is scrolled vertically | Don't build a sticky portal; the always-visible scrollbar inside the grid frame keeps the table itself the visual anchor |
| Two visible top borders on the scroll row | Both wrapper and `::-webkit-scrollbar-track` set `border-top`; keep the border on `.ag-body-horizontal-scroll` only and make the track transparent |
| Pill-shaped thumb conflicts with QTM language | Replace `border-radius: 999px` with `4px`; QTM is sharp-geometry |

## Scoped Header Polish

```css
.module-grid.ag-theme-quartz .ag-header-cell,
.module-grid.ag-theme-quartz .ag-header-group-cell {
  background:
    radial-gradient(circle at 8% 0%, rgba(239, 44, 193, 0.08), transparent 34%),
    radial-gradient(circle at 70% -20%, rgba(189, 187, 255, 0.18), transparent 42%),
    linear-gradient(135deg, rgba(255, 255, 255, 0.82) 0%, rgba(250, 247, 255, 0.88) 48%, rgba(239, 247, 255, 0.84) 100%);
  border-top: 1px solid rgba(1, 1, 32, 0.12);
  border-right: 1px solid rgba(1, 1, 32, 0.14);
  border-bottom: 1px solid rgba(1, 1, 32, 0.16);
}
```

## Table-First Lessons

- Wide tables need width more than sidebars; put controls inside the table frame header.
- Context/stats should not look like buttons. Use metadata labels and thin dividers.
- Search remains a real input; actions remain real buttons.
- For identity-heavy rows, combine related fields into one pinned identity column.
- Compress low-information columns before accepting horizontal scroll.
- Centralize AG Grid CSS imports once near app entry. Duplicate theme imports can override custom styling.
- If a grid still looks purple or rounded, inspect global `.ag-theme-quartz`, wrapper radius, import order, pinned containers, and selected/hover tokens.

## Data Console Lessons

- Summary cards can act as quick filters, but remove decorative-only cards.
- Detail information belongs in a selected-row panel when users need to inspect many records quickly.
- Keep raw payloads secondary to structured summaries.
- Webhook/log pages should be honest about scope: page-local search if backend-wide search does not exist.
- Pagination should match the backend contract; do not fake page-number UI if the API only supports previous/next.

## Do Not Abstract Too Early

Avoid generic names like `OperationalModuleLayout` until repeated behavior is proven. Safe early abstractions: shell, hero, metric card, filter bar shape, grid frame, detail panel shell. Keep columns, permissions, statuses, payload schemas, workflow transitions, and validation module-owned.
