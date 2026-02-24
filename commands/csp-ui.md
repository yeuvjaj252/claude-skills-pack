---
description: 🎯 Professional UI/UX design and implementation. Comprehensive design system with styles, colors, typography, and best practices.
---

# UI/UX Pro Max

$ARGUMENTS

---

## Purpose

Comprehensive design guide for web and mobile applications. Contains design systems, color palettes, font pairings, UX guidelines, and implementation patterns.

---

## How to Use

When user requests UI/UX work (design, build, create, implement, review, fix, improve), follow this workflow:

### Step 1: Analyze User Requirements

Extract key information from user request:
- **Product type**: SaaS, e-commerce, portfolio, dashboard, landing page, etc.
- **Style keywords**: minimal, playful, professional, elegant, dark mode, etc.
- **Industry**: healthcare, fintech, gaming, education, beauty, etc.
- **Stack**: React, Vue, Next.js, or default to HTML + Tailwind

### Step 2: Design System Selection

Based on analysis, select appropriate:
- **UI Pattern**: Dashboard, landing, e-commerce, portfolio
- **Style**: Minimalist, glassmorphism, brutalist, neo-retro
- **Color Palette**: Based on industry and emotion
- **Typography**: Font pairing for headers and body
- **Effects**: Shadows, gradients, animations

### Step 3: Implementation

Apply design system with stack-specific best practices.

---

## Design System Reference

### UI Patterns by Product Type

| Product | Pattern | Key Elements |
|---------|---------|--------------|
| **SaaS** | Dashboard + Landing | Stats cards, data tables, CTA sections |
| **E-commerce** | Product Grid + Cart | Product cards, filters, checkout flow |
| **Portfolio** | Hero + Gallery | Large images, project showcase |
| **Blog** | Content + Sidebar | Article layout, navigation |
| **Landing** | Hero + Features | CTA, testimonials, pricing |

### Style Guide

| Style | Characteristics | Best For |
|-------|-----------------|----------|
| **Minimalist** | Clean, whitespace, subtle | Professional, luxury |
| **Glassmorphism** | Blur, transparency, depth | Modern, tech |
| **Brutalist** | Raw, bold, unconventional | Creative, standout |
| **Neo-retro** | Vintage + modern mix | Unique, memorable |
| **Corporate** | Professional, structured | Enterprise, B2B |

### Color Palettes by Industry

| Industry | Primary | Accent | Emotion |
|----------|---------|--------|---------|
| **Fintech** | Deep blue, Navy | Gold, Green | Trust, stability |
| **Healthcare** | Teal, Soft blue | White, Green | Calm, professional |
| **E-commerce** | Brand-specific | Orange, Red | Action, urgency |
| **Beauty/Spa** | Rose, Cream | Gold | Luxury, relaxation |
| **Tech/SaaS** | Electric blue | Purple, Cyan | Innovation |
| **Food** | Warm orange, Red | Yellow | Appetite, energy |

### Typography Pairings

| Style | Heading | Body | Use Case |
|-------|---------|------|----------|
| **Modern Clean** | Inter | Inter | SaaS, dashboards |
| **Elegant** | Playfair Display | Lato | Luxury, beauty |
| **Friendly** | Poppins | Open Sans | Consumer apps |
| **Professional** | Montserrat | Source Sans Pro | Corporate |
| **Bold Statement** | Bebas Neue | Roboto | Marketing, landing |

---

## Common Rules for Professional UI

### Icons & Visual Elements

| Rule | Do | Don't |
|------|----|----- |
| **No emoji icons** | Use SVG icons (Heroicons, Lucide) | Use emojis as UI icons |
| **Stable hover** | Use color/opacity transitions | Use scale transforms that shift layout |
| **Correct logos** | Use official SVG from Simple Icons | Guess or use incorrect logos |

### Interaction & Cursor

| Rule | Do | Don't |
|------|----|----- |
| **Cursor pointer** | Add `cursor-pointer` to clickable elements | Leave default cursor |
| **Hover feedback** | Provide visual feedback | No indication element is interactive |
| **Smooth transitions** | Use `transition-colors duration-200` | Instant or too slow (>500ms) |

### Light/Dark Mode Contrast

| Rule | Do | Don't |
|------|----|----- |
| **Light mode cards** | Use `bg-white/80` or higher | Use `bg-white/10` (too transparent) |
| **Text contrast** | Use slate-900 for body | Use gray-400 for body text |
| **Border visibility** | Use `border-gray-200` in light | Use `border-white/10` (invisible) |

### Layout & Spacing

| Rule | Do | Don't |
|------|----|----- |
| **Floating navbar** | Add `top-4 left-4 right-4` | Stick to `top-0 left-0 right-0` |
| **Content padding** | Account for fixed navbar | Let content hide behind fixed elements |
| **Consistent width** | Use same `max-w-6xl` | Mix different container widths |

---

## Pre-Delivery Checklist

Before delivering UI code, verify:

### Visual Quality
- [ ] No emojis used as icons (use SVG instead)
- [ ] All icons from consistent set (Heroicons/Lucide)
- [ ] Hover states don't cause layout shift

### Interaction
- [ ] All clickable elements have `cursor-pointer`
- [ ] Transitions are smooth (150-300ms)
- [ ] Focus states visible for keyboard navigation

### Light/Dark Mode
- [ ] Light mode text has sufficient contrast (4.5:1 minimum)
- [ ] Glass/transparent elements visible in light mode
- [ ] Test both modes before delivery

### Layout
- [ ] Responsive at 375px, 768px, 1024px, 1440px
- [ ] No horizontal scroll on mobile
- [ ] No content hidden behind fixed elements

### Accessibility
- [ ] All images have alt text
- [ ] Form inputs have labels
- [ ] `prefers-reduced-motion` respected
