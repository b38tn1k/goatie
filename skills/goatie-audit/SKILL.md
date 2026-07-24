---
name: goatie-audit
description: >
  Whole-app UX audit against a 120-point first-time-user scorecard. Like
  goatie-review, but scans the entire application instead of a diff:
  scores ten weighted categories, then ranks the top problems and
  highest-value fixes. Use when the user says "audit the ux", "score the
  app", "ux audit", "how usable is this", "goatie-audit", or
  "/goatie-audit". One-shot report, does not apply fixes.
---

Act as a senior SaaS UX reviewer evaluating the application as a
first-time user. Ignore decoration, but treat color, weight, and
proportion as usability — they carry hierarchy. Focus on task
completion. Never score from imagination — every finding carries
evidence, and every visual finding carries a `file:line` anchor.

Audit at two altitudes, and score both:

- **Page flow** — each screen as its own small product: one job, obvious
  next action, honest states, sound weight.
- **App flow** — the product as a graph. From the static route table,
  build a reachability matrix: screen × inbound UI links. A screen
  reachable only by URL, email link, or memory is an orphan — a great
  page nobody can reach is app-level friction, and it never shows up
  judging pages one at a time. Walk the core journeys end to end
  (first run → first success; the daily/weekly loop) counting screens
  crossed, decisions made, and dead ends hit; check that nav,
  terminology, and layout stay continuous across the seams. An app is a
  product made of smaller products — it has to be great at every level,
  and pages can each score well while the app fails between them.

For every issue found: the problem, why it adds friction, severity, and
the smallest practical fix.

## Evidence protocol

Code and screenshots catch disjoint failure classes, and each alone lies:
a screenshot shows one state at a time (almost always the happy path);
static code can't perceive hierarchy, contrast, or clutter. Run three
passes, each feeding the next:

**1. Static inventory — coverage.** The route table IS the screen list;
screenshots can't prove you visited every screen, the router can. Per
screen, extract: states present (loading / empty / error branches), exits
(cancel, undo, escape, back), CTA count, copy strings. Across screens,
grep the corpus: button variants, terminology, spacing tokens, and every
blaming error string ("Invalid input.") — consistency and error-copy are
corpus properties, score them here, they are nearly free statically and
absurdly expensive by screenshot.

**2. Rendered walk — perception.** Launch the app and visit every route
from the inventory as a first-time user with empty data. Per screen,
capture BOTH a screenshot and the accessibility tree. The screenshot
answers what code cannot: the real three-second test, visual hierarchy,
clutter, contrast — repeat key screens at mobile width. Use the phase-1
state list to force the unhappy paths: drive each error and empty state,
never photograph only success. Walk the primary workflow end to end
counting clicks and decisions; a request in flight with nothing on
screen is a measured feedback failure, not an opinion.

**2b. Surface & weight pass — measured, never vibed.** Run on every key
screen. The rule here is: measure what is, judge the proportion, phrase
the fix as a direction. Never encode a framework constant, a pixel
value, or a named product's look as the standard — the measurement is
the evidence, the direction ("fatten up", "skinny down", "heavier",
"quieter", "raise contrast a step") is the finding, and the exact value
belongs to the implementer.

- **Surface levels.** Sample computed backgrounds of canvas, header/nav,
  and cards via page JS. If canvas and its containers sit within ~3 L*
  of each other, the page is flat — hierarchy is being carried by
  hairline borders and font sizes alone. The blur test: with the text
  illegible, the screenshot should still read as regions. A full-bleed
  near-white or near-black canvas with content floating directly on it
  is glare/void — content sits on surfaces a step off the canvas.
- **One-grid check.** Collect `getBoundingClientRect().left` for the
  header's inner container, any tab/toolbar rows, and the main content
  column at desktop width. More than one distinct left edge means the
  chrome and the content don't share a grid — this is what users report
  as "the nav looks weird" without being able to say why. The static
  giveaway: mismatched width constraints on header vs page containers.
- **Weight & proportion.** From the screenshot, judge the balance:
  chrome weight vs content weight, heading scale vs body, column width
  vs what fills it, control size vs its importance. An action that
  matters rendered at the same weight as one that doesn't, a content
  column swimming in a container built for something wider, a toolbar
  heavier than the work below it — all findings, phrased directionally.
- **Contrast.** Sample body text, secondary text, nav links, and button
  labels (including disabled) against their real backgrounds: 4.5:1
  body, 3:1 large text, and treat borderline secondary text as a
  finding, not a pass. A disabled button whose label is illegible reads
  as broken, not disabled.
- **Token corpus (static half).** Grep for a design-token layer (CSS
  variables, theme config) versus hand-rolled palette classes; count
  distinct background/border/button recipes like any other consistency
  metric. Twenty-five button recipes and no primitives is the measured
  form of "it doesn't look professional".

**2c. Mode & access pass — every mode, every key screen.** A mode you
didn't render is a mode you didn't audit.

- **Color modes.** Render light AND dark (toggle them, don't trust the
  code), then re-check the surface levels and contrast in each — themes
  fail independently. Simulate the common color-vision deficiencies
  (protanopia, deuteranopia, tritanopia — CSS/SVG filter matrices or
  devtools emulation; grayscale is the cheap universal check). Any
  signal that survives only as hue — state colors, chart series, link
  vs text, valid vs invalid — is a failure: pair color with a shape,
  label, weight, or icon.
- **Keyboard.** Tab through the primary workflow: focus order follows
  visual order, focus is always visible, nothing traps, Escape closes
  what opened. Every action reachable by pointer is reachable by key.
- **Names.** The accessibility tree you already captured is the test:
  every interactive element has an accessible name that matches its
  visible purpose; landmarks and headings give the page a skeleton. An
  input a screen reader announces as "edit text" is unlabeled, full
  stop.
- **Zoom & motion.** At 200% zoom nothing clips or overlaps; if the app
  animates, reduced-motion preference is honored.

**3. Associate & score.** The accessibility tree is the bridge between
the two worlds: rendered element text/role → grep → source `file:line`.
Every visual finding gets an anchor (or it isn't actionable); every
static finding gets confirmed or demoted by the render (an error branch
that exists but renders unreadably is still a failure). A finding stands
when the definitionally sufficient modality confirms it: missing undo is
static-sufficient, weak hierarchy is visual-sufficient, feedback needs
both (handler exists in code AND the spinner actually appears).

Can't run the app? Score the static-sufficient categories, mark the
perceptual ones "unscored — needs render", and say so in the overall
score. Never guess a perception score from source code.

## Scorecard

| Category | Max | What to check |
|----------|-----|---------------|
| Purpose clarity | 10 | What it does, who it's for, what to do first, what success looks like — obvious without exploration. Red flags: marketing copy, competing CTAs, no starting point. |
| Primary workflow | 15 | A brand-new user finishes the primary task: minimal clicks, obvious next step, no dead ends, no unnecessary decisions. |
| Navigation & IA | 10 | Where am I, where can I go, how do I return. Consistent nav, predictable menus, grouping by task not implementation, search once content grows. |
| Cognitive load | 15 | Unnecessary options, giant forms, clutter, modal overload, hidden functionality. Complexity revealed gradually, never dumped. |
| Visual hierarchy | 10 | Within three seconds: primary action, secondary actions, current status, warnings, content. Spacing, contrast, button hierarchy pull the eye to the next action. |
| Feedback & status | 15 | Every action answers back: loading, saving, deleting, processing, errors, success, background work. Never "did anything happen?" |
| Onboarding | 10 | Empty states that teach, templates, sensible defaults, progressive disclosure. No tutorial walls. |
| Error handling | 10 | Errors teach: what happened, why, how to fix, whether anything was lost. Never blame. |
| User control | 10 | Undo, cancel, back, autosave, drafts, filters, sorting — the user always has an exit. |
| Performance feel | 15 | Perceived speed: initial load, navigation, input latency, visible progress while waiting. |

**Total: 120.** Interpretation: 110–120 production quality · 95–109 strong
· 80–94 usable but rough · 60–79 needs redesign · <60 major UX problems.

Evidence per category — perception (screenshot): purpose clarity, visual
hierarchy, cognitive load, onboarding. Interaction (live walk): primary
workflow, feedback & status, performance feel. Corpus (static): error
handling, user control, consistency and coverage. Both: navigation & IA
(structure statically, orientation rendered).

Also sweep, folding findings into the categories above: forms, tables,
dashboards, search, filtering, empty states, accessibility, mobile
responsiveness, keyboard usability, overall consistency.

## Output

1. Scorecard table with per-category score and one-line justification each.
2. **Overall score /120** with interpretation band.
3. **App flow**: the journey traces (screens crossed, decisions, dead
   ends) and the orphan list — screens with no inbound UI path.
4. **Top 5 UX problems** — worst first, each with severity and the friction it causes.
5. **Top 5 highest-value improvements** — each with estimated effort (S/M/L) and expected user impact.
6. Every improvement phrased as the smallest change that fixes the
   friction, goatie-style — directional where visual ("fatten",
   "skinny down", "raise contrast"), never a hardcoded constant.

## Boundaries

Reports only, applies nothing. Correctness bugs and security found in
passing get one line and a pointer to a normal review. Pairs with
/ponytail-audit: that one hunts over-engineered code, this one hunts
over-complicated screens.
