---
name: manbun-audit
description: >
  Whole-app UX audit against a 120-point first-time-user scorecard. Like
  manbun-review, but scans the entire application instead of a diff:
  scores ten weighted categories, then ranks the top problems and
  highest-value fixes. Use when the user says "audit the ux", "score the
  app", "ux audit", "how usable is this", "manbun-audit", or
  "/manbun-audit". One-shot report, does not apply fixes.
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

Close phase 1 with two declarations the rest of the audit is bound by:

- **Personas.** Enumerate the distinct users from routes, roles, and
  auth gates (e.g. player / captain / admin / operator). Each persona
  gets its own primary journey walked in phase 2 — an audit that walks
  one persona of four has audited a quarter of the app, and must say so.
- **Calibration.** Name each surface's audience and calibrate
  expectations, not weights: an expert operator console may earn its
  density and lean on training; a consumer surface may not. When the
  app is genuinely several products in one shell, score each surface
  and report both the split and the blend — never average away a
  finding.

**2. Rendered walk — perception.** Launch the app and visit every route
from the inventory. Per screen, capture BOTH a screenshot and the
accessibility tree. The screenshot answers what code cannot: the real
three-second test, visual hierarchy, clutter, contrast. Walk each
persona's primary journey end to end counting clicks and decisions; a
request in flight with nothing on screen is a measured feedback
failure, not an opinion.

The coverage bar is explicit, not "key screens": every distinct layout
template at desktop AND mobile width, every screen in every persona's
primary journey, every forced unhappy state. Anything below that bar is
stated as a percentage in the report, never silently skipped.

- **Walled screens.** An auth wall is not a stopping point, it's a
  ladder: (a) use the repo's own test-auth infra (storage state, test
  users, signing helpers — the e2e directory usually knows); (b) ask
  the user to sign in once in the shared browser and walk on their
  session; (c) seed a disposable test account via the app's own
  fixtures. You never type credentials or create accounts yourself —
  the user or the repo's tooling authenticates, you walk. If no rung
  works, score the static-sufficient categories, mark render-only ones
  "unscored — needs render", and lead the report with the coverage
  number.
- **Forcing states.** "Force the empty and error states" needs a
  method, not a wish: repo fixtures and seed scripts, dev/test-only
  routes, invalid tokens and ids, network throttling or a killed
  backend for error paths, a scratch database for write flows. The
  first-run experience must be walked with genuinely empty data — a
  first-time-user audit against a full production mirror is fiction.
  Never write test data into a shared or prod-mirrored database; if
  feedback-after-write can't be observed safely, score it static and
  say so. A file-backed database (SQLite) is a free scratch
  environment: copy it, point the app at the copy, and walk the write
  paths without touching anything real — check for this before
  declaring mutations unwalkable.
- **Other cameras.** The walk is the same off the web, only the camera
  changes: iOS/Android via simulator screenshot and tap tools, desktop
  apps via OS screenshot control, TUIs via terminal capture. Surface
  levels, one-grid, contrast, modes, and journeys apply unchanged.
  Check for the shortcut first: many desktop shells (Electron, Tauri)
  just load a localhost web server — run the server alone and walk it
  in the browser with the full instrument kit, and score only the
  shell-owned behaviors (window chrome, quit semantics, tray/idle)
  statically.

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
didn't render is a mode you didn't audit. The conformance target is
WCAG 2.2 AA — the 2.2-specific checks, the dual-band contrast policy
(WCAG 2.x gates, APCA advises), the full 2026 mode set (forced-colors,
prefers-contrast, reflow at 320px, 200% zoom, text-spacing override),
and the current legal deadlines live in `a11y.md` next to this skill.
Read it; most 2.1-era checklists are stale (4.1.1 is gone, the ADA
dates moved).

- **Color modes.** Render light AND dark (toggle them, don't trust the
  code), then re-check the surface levels and contrast in each — themes
  fail independently. Simulate the common color-vision deficiencies
  (protanopia, deuteranopia, tritanopia; grayscale is the cheap
  universal check) — paste-ready filter matrices and the injection
  snippet live in `toolkit.md` next to this skill, so this is a paste,
  not a project. Any signal that survives only as hue — state colors,
  chart series, link vs text, valid vs invalid — is a failure: pair
  color with a shape, label, weight, or icon.
- **Keyboard.** Tab through the primary workflow: focus order follows
  visual order, focus is always visible **and never fully obscured by
  sticky chrome** (2.4.11), nothing traps, Escape closes what opened.
  Every action reachable by pointer is reachable by key — including
  hover-revealed controls (`:hover` without `:focus-within` is a
  failure) and anything drag-only (2.5.7 needs a button alternative).
- **Targets & forms.** Hit areas ≥ 24×24 CSS px (2.5.8; bands and
  exceptions in `a11y.md`). Multi-step flows never re-ask for entered
  data (3.3.7). Auth flows: no paste-blocking, no `autocomplete` off
  on credentials, no CAPTCHA without an alternative (3.3.8).
- **Names.** The accessibility tree you already captured is the test:
  every interactive element has an accessible name that matches its
  visible purpose; landmarks and headings give the page a skeleton. An
  input a screen reader announces as "edit text" is unlabeled, full
  stop.
- **Zoom & motion.** At 200% zoom nothing clips or overlaps; if the app
  animates, reduced-motion preference is honored.

**2d. Performance — instrumented, not inferred.** Loading-state presence
in code is a proxy; the category deserves numbers. Audit against a
production build where the repo supports one (`next build && start` or
equivalent) — dev-mode timings are inadmissible as evidence, and a
dev-only walk says so and scores structurally. Sample via page JS
(snippets in `toolkit.md`): first paint and LCP, layout shift, input
delay on the primary workflow's clicks, route-transition time. The
question stays perceptual — was there ever a moment with no feedback? —
but the answer now has milliseconds attached.

**2e. The computer-science-brain check.** Read every number, date,
label, and ordering on the walked screens as someone who has never
programmed. Anything that requires knowing how computers count, store,
sort, or name things is a finding: zero-based numbering shown to users
("level 0"), raw enums, statuses, and internal ids surfacing in
headings or copy, ISO/UTC dates ("2026-07 → 2026-07"), unrounded float
precision, byte-order sorting (Z before a), "1 items" pluralization,
true/false/null rendered as text. The static half greps the usual leak
points — rendered array indexes, `toISOString` in markup, status
fields displayed raw (patterns in `toolkit.md`). The rendered half is
one question per screen: would someone who has never programmed read
every visible value the way the developer meant it? Implementation-
shaped flows belong here too — a UI that makes the user assemble the
data model (create a node, then link it) instead of doing their task.
Locale readiness is this check's sibling: hardcoded date/number
formats, concatenated sentence fragments, and layouts that can't
mirror for RTL are the machine's locale showing through.

**2f. Proximity & intent pass.** What acts on a thing lives on the
thing, and the user's intent survives everything — full reference in
`proximity.md`. Spatial half: labels nearer their own field than any
neighbor (top-aligned on mobile), group spacing exceeds within-group
spacing, item actions inside the item's region, errors DOM-adjacent to
their field (banner-only = finding), trigger→confirm in the same
quadrant, destructive never <8px from primary. Attention half:
headings enable layer-cake scanning; front-load link/heading words;
F/Z reasoning only on sparse pages, never dense app UIs. Intent half —
all mechanical probes: auth deep-links return to the original URL
(params intact), invalid submits preserve every other field, back
restores scroll/filters (state in the URL), mid-form reload offers
recovery. The app forgetting what the user was doing is a `proximity:`
finding. Composition is proximity at page scale: section order is a
frequency claim (daily work above one-time setup — a page that appends
each new feature below the last fails silently), same-task sections
sit within a viewport of each other, and desktop width is information
space — independent panels stacked one-per-viewport in a centered
column on a wide screen is dispersion. Measure column ratio, page
height in viewports, and section positions (toolkit), then phrase the
fix directionally.

**2g. Translation pass — form factors.** One product at every size:
capabilities rearrange, never disappear — full reference in
`translation.md`. Audit at 320/375/768/1024/1280 AND the stylesheet's
own declared breakpoints ±1px: overflow, reflow, and the idiom
switches (nav ≤5 destinations = visible tabs not hamburger; tables
become cards/priority-columns/sticky-scroll, never a squeezed grid;
dialogs become sheets). Thumb zone: primary CTA out of the top
quadrant at phone widths. Scale: inputs ≥16px (never fixed via
user-scalable=no), primaries at 44pt/48dp, hover-revealed actions have
a touch path. Parity both directions: diff text + interactive
inventory between 375px and 1280px (collapsed passes, absent fails);
going UP, desktop must add density, hover, focus, side-by-side — a
stretched phone column on a 1280px viewport is the mobile-first
failure. Findings tag `parity:` or `proximity:`.

**3. Associate & score.** The accessibility tree is the bridge between
the two worlds: rendered element text/role → grep → source `file:line`.
Every visual finding gets an anchor (or it isn't actionable); every
static finding gets confirmed or demoted by the render (an error branch
that exists but renders unreadably is still a failure). A finding stands
when the definitionally sufficient modality confirms it: missing undo is
static-sufficient, weak hierarchy is visual-sufficient, feedback needs
both (handler exists in code AND the spinner actually appears).

- **Fresh eyes.** You cannot administer the three-second test — you've
  read the codebase, so you're the architect squinting, not a
  first-time user. Spawn a context-free subagent per landing and
  journey-entry screen, show it ONLY the screenshot, and ask: what is
  this app, what would you do next, which action is primary? Its answer
  IS the measurement — its confusion is a purpose-clarity or hierarchy
  finding with the quote attached, and its correct guess is the pass.
  Hygiene: tell it nothing about the product, not even the domain;
  prefer the prod build (dev overlays pollute first impressions), and
  discount any dev-only chrome it flags.
- **Skeptic pass.** Perception findings (weight, proportion, hierarchy,
  clutter) are taste calls until challenged. Before the report, hand
  each one plus its evidence to a verifier prompted to REFUTE it. A
  finding that survives ships as confirmed; one that doesn't is demoted
  to a suggestion or dropped. Mechanical findings (contrast ratios,
  missing names, orphans) skip the panel — arithmetic needs no jury.
- **Confirmation labels.** Every finding carries what confirmed it:
  `measured`, `fresh-eyes`, `skeptic`, `static`, or `unverified`. A
  taste call that skipped the skeptic pass ships labeled `unverified`
  — skipping a pass under time pressure is allowed; hiding that it was
  skipped is not.
- **Causes, not symptoms.** Cluster before ranking: 1,500 failing
  labels sharing one token is ONE finding with a count attached, not
  1,500 findings. Top-5 lists rank causes; the count is the severity
  evidence.

**4. Receipts & baseline.** An audit that discards its evidence is an
opinion with a bibliography.

- **Receipts.** Save every capture to an evidence directory
  (`.manbun/evidence/<date>/<route>--<mode>.png`, conventions in
  `toolkit.md`); every finding cites its receipt by name. Offer the
  annotated gallery as a published artifact when the user wants to see,
  not just read. When the harness can't persist pixels, the measurement
  JSON and accessibility trees ARE the receipts — write those, say so
  in coverage, and never let a missing PNG silently downgrade a
  finding.
- **Baseline.** Write the scorecard, coverage numbers, and finding list
  to `.manbun/audit-<date>.json` (schema in `toolkit.md`) — the only
  thing an audit ever writes. When a previous baseline exists, open the
  report with the delta: per-category movement, findings fixed,
  findings new, findings still open. One audit is a snapshot; two are
  an instrument.

Can't run the app? Score the static-sufficient categories, mark the
perceptual ones "unscored — needs render", and lead the report with the
rendered-coverage percentage. Never guess a perception score from
source code.

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

1. **Coverage & calibration**: rendered %, personas walked, modes
   rendered, prod-or-dev build — and the delta vs the previous baseline
   when one exists. This leads; a score without its coverage is
   marketing.
2. Scorecard table with per-category score and one-line justification
   each (split per surface when calibration split them).
3. **Overall score /120** with interpretation band.
4. **App flow**: the journey traces (screens crossed, decisions, dead
   ends) and the orphan list — screens with no inbound UI path.
5. **Top 5 UX problems** — worst first, each with severity, the
   friction it causes, and its receipt.
6. **Top 5 highest-value improvements** — each with estimated effort (S/M/L) and expected user impact.
7. Every improvement phrased as the smallest change that fixes the
   friction, manbun-style — directional where visual ("fatten",
   "skinny down", "raise contrast"), never a hardcoded constant.

## Boundaries

Reports only, applies nothing — the sole writes are `.manbun/` receipts
and the baseline JSON. Never writes to the app's database or submits
its forms against shared data. Correctness bugs and security found in
passing get one line and a pointer to a normal review. Pairs with
/ponytail-audit: that one hunts over-engineered code, this one hunts
over-complicated screens.
