# Anime.js v4 Reference Guide for AI Assistants

## CRITICAL: ALWAYS USE ANIME.JS V4 SYNTAX

**This project uses Anime.js v4.x.x - DO NOT use v3 syntax under any circumstances**

**If you're about to write `import anime from 'animejs'` - STOP!**
**That's v3. This project uses v4. Use the correct import below.**

## Quick Start - Essential Setup

### 1. Correct v4 Import (REQUIRED)
```javascript
// CORRECT v4 imports
import { animate, createTimeline, stagger, utils, svg, eases, engine } from 'animejs';

// WRONG v3 import - NEVER USE THIS
// import anime from 'animejs';
```

### 2. Configure Time Units to Seconds (SET ONCE IN APP ENTRY POINT)
```javascript
import { engine } from 'animejs';
engine.timeUnit = 's';
```

### 3. Single-Line Format for Simple Animations (REQUIRED)
```javascript
// GOOD
animate('.element', { x: 250, duration: 1, ease: 'outQuad' });

// BAD - unnecessary multi-line
animate('.element', {
  x: 250,
  duration: 1,
  ease: 'outQuad'
});
```

## Quick Validation Checklist
- Using `import { animate, ... } from 'animejs'` NOT `import anime`
- Set `engine.timeUnit = 's'` ONLY ONCE in app entry point
- Using seconds for all durations
- Simple animations on ONE LINE
- Using `animate()` NOT `anime()`
- Using `createTimeline()` NOT `anime.timeline()`
- Using `ease:` NOT `easing:`
- Using `to:` for values, NOT `value:`
- Using `on` prefix for callbacks
- Using `loop` and `alternate` NOT `direction`
- Using correct v4 stagger syntax with `stagger()`

## Core API

### Basic Animation
```javascript
animate('.element', { x: 250, rotate: 180, duration: 0.8, ease: 'inOutQuad' });
animate('.element', { opacity: [0, 1], y: [20, 0], duration: 0.6, ease: 'outQuad' });
animate('.element', { scale: [0, 1], duration: 0.8, ease: 'outElastic(1, 0.5)' });
animate('.element', { rotate: 360, duration: 2, loop: true, ease: 'linear' });
```

### Timeline Creation
```javascript
const tl = createTimeline({ defaults: { duration: 1, ease: 'outQuad' } });
tl.add('.element1', { x: 250 })
  .add('.element2', { y: 100 }, '+=0.2')
  .add('.element3', { rotate: 180 }, '<');
```

### Stagger Animations
```javascript
animate('.elements', { x: 250, delay: stagger(0.1) });
animate('.elements', { x: 250, delay: stagger(0.1, { from: 'center' }) });
```

## Common Mistakes to Avoid
- Using `import anime from 'animejs'` (v3) instead of `import { animate } from 'animejs'` (v4)
- Using `targets` property (v3) instead of first parameter (v4)
- Using `easing` (v3) instead of `ease` (v4)
- Using `value` (v3) instead of `to` (v4)
- Using `anime.timeline()` (v3) instead of `createTimeline()` (v4)
- Using `direction: 'alternate'` (v3) instead of `alternate: true` (v4)

## Property Syntax (v4)
- Values: `{ to: 0.5 }` not `{ value: 0.5 }`
- Easing: `{ ease: 'inOutQuad' }` not `{ easing: 'easeInOutQuad' }`
- Looping: `{ loop: true, alternate: true }` not `{ direction: 'alternate' }`
- Transforms: `{ x, y, z }` preferred over `{ translateX, translateY, translateZ }`
- Callbacks: `onBegin`, `onUpdate`, `onComplete` (always `on` prefix)

## Advanced: SVG, Scroll, Utilities
```javascript
// SVG morph
animate('#path1', { d: svg.morphTo('#path2'), duration: 1 });

// Scroll observer
createScrollObserver({ target: '.el', play: () => animate('.el', { x: 250 }) });

// Utilities
utils.set('.element', { x: 100, opacity: 0.5 });
utils.get('.element', 'translateX');
utils.remove('.element');
```

## NPM: `npm install animejs`
