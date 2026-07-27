# manbun failure-mode catalog — the normative sweep

The audit's completeness gate: before reporting, walk this file top to
bottom and mark every category **checked / found / n-a**. The sweep
ships in the report — a skipped class is visible, never silent.
Detection codes: **M** measured (instrument) · **S** static (code) ·
**R** render judgment (screenshot) · **F** fresh-eyes/journey walk.
Coverage names the check that owns it; **GAP** = detect from this row
directly until a dedicated check exists.

## A. App pathways

| # | Failure | Det | Owner |
|---|---------|-----|-------|
| A1 | Orphan screen (no inbound UI link) | S | reachability matrix |
| A2 | Dead end (no back/nav/home) | S/R | app flow |
| A3 | Hamburger at desktop width | R | translation.md |
| A4 | Nav >7 items unclustered / grouped by implementation | S/R | app flow |
| A5 | Inconsistent nav across sections (seams) | R | journey continuity |
| A6 | Error/404 pages with no route home | R | error infra check |
| A7 | Login forgets destination (redirect_url) | M | proximity.md intent |
| A8 | SPA breaks Back (history not pushed) | M | GAP — probe history on nav |
| A9 | Deep state not URL-addressable (filters/tabs unshareable) | M | proximity.md intent |
| A10 | No search once content outgrows nav | S | audit scorecard nav |
| A11 | Cross-surface hardcoded links (wrong portal) | S | corpus grep |
| A12 | Feature reachable only by memory/shortcut, no visible path | S | discoverability (notes field lesson) |

## B. Journeys & tasks

| # | Failure | Det | Owner |
|---|---------|-----|-------|
| B1 | Primary task exceeds decision budget (count it) | F | journey trace |
| B2 | Account/signup demanded before any value shown | F | GAP — first-run walk order |
| B3 | Tutorial/tour wall before the product | F | onboarding |
| B4 | Redundant entry across steps (3.3.7) | M | a11y.md |
| B5 | Interruption loses work (no draft/autosave) | M | proximity.md intent |
| B6 | Multi-step flow w/o progress indicator or step count | R | GAP — wizard check |
| B7 | No resume for long flows ("continue where you left off") | F | proximity.md intent |
| B8 | Permission prompts before context (notifications on load) | F | GAP — first-run walk |
| B9 | Forced detour mid-task (upsell interstitial) | F | dark patterns O |
| B10 | Same data re-fetched from user that app already has | S | default: tag |

## C. Page composition

| # | Failure | Det | Owner |
|---|---------|-----|-------|
| C1 | Section order inverts use frequency (setup above daily work) | R | proximity.md composition |
| C2 | Phone column on desktop viewport (dispersion) | M | composition instrument |
| C3 | >1 primary CTA styled identically | M/R | hierarchy |
| C4 | No primary action at all above the fold | R | 3-second test |
| C5 | Page with five jobs (split test fails) | R | ladder rung 1 |
| C6 | Same-task sections separated by unrelated panels | R | composition |
| C7 | Wall of text, no headings (layer-cake impossible) | S | proximity.md attention |
| C8 | Decorative panel outranks working panel in position/size | R | composition |
| C9 | Key info/action bottom-right of dense page (attention shadow) | R | attention flow |
| C10 | Above-fold is brand/hero only; work starts below | R | composition |

## D. Layout, grid & surface

| # | Failure | Det | Owner |
|---|---------|-----|-------|
| D1 | Multiple left edges (chrome vs content off-grid) | M | one-grid check |
| D2 | Flat: canvas/cards within ~3 L* | M | surface levels |
| D3 | Glare/void canvas (L*>97 or <5 full-bleed) | M | surface levels |
| D4 | Container widths inconsistent across sibling pages | S | corpus |
| D5 | Clipped/overlapping content at any declared breakpoint | M | translation.md seams |
| D6 | Horizontal page scroll at standard widths | M | reflow |
| D7 | Spacing scale chaos (no rhythm; 20 distinct gaps) | S | token corpus |
| D8 | Hierarchy carried by hairlines alone | M | surface levels |
| D9 | Uniform weight — nothing pulls the eye | R | weight & proportion |
| D10 | Content column unconstrained (>90ch measures) | M | translation.md |

## E. Tables & lists

| # | Failure | Det | Owner |
|---|---------|-----|-------|
| E1 | Squeezed full grid at mobile width | R | translation.md tables |
| E2 | Long table, no sticky header/first column | R | GAP — scroll the table |
| E3 | Unlabeled counts/numbers in rows | F | fresh-eyes (brian lesson) |
| E4 | No sort affordance where users compare | R | GAP — table check |
| E5 | Pagination without total/position | R | GAP |
| E6 | Infinite scroll with no way back to position | M | GAP — scroll restore probe |
| E7 | Row actions hover-only (no focus-within) | M | a11y sweep |
| E8 | Icon-only row actions unnamed | M | a11y sweep |
| E9 | Repetitive per-row task with no bulk action | F | GAP — operator loop |
| E10 | Empty list says "No data." | S | empty-state grep |

## F. Forms

| # | Failure | Det | Owner |
|---|---------|-----|-------|
| F1 | Placeholder as only label | M | a11y sweep |
| F2 | Left-aligned labels on mobile | R | proximity.md labels |
| F3 | Unrelated fields sharing a row | R | translation.md forms |
| F4 | Errors banner/toast-only, not at field | M | proximity instrument |
| F5 | Error copy blames, names no fix | S | blame grep |
| F6 | Validation fires per keystroke | R | proximity.md (blur rule) |
| F7 | Submit wipes valid fields on error | M | intent probe |
| F8 | No validation until server round-trip | R | GAP — submit probe |
| F9 | Wrong keyboard (no inputmode/type) | S | translation.md |
| F10 | Missing autocomplete on identity/payment fields | S | a11y.md auth |
| F11 | Confirm-field friction (email twice) | S | default: |
| F12 | Giant flat form, no grouping/whitespace logic | M | group-spacing check |
| F13 | Disabled submit with no stated reason | R | ShadowLeague lesson — disabled-with-reason |
| F14 | Label↔field association ambiguous (equidistant) | M | proximity instrument |

## G. Buttons & controls

| # | Failure | Det | Owner |
|---|---------|-----|-------|
| G1 | Destructive adjacent to primary (<8px) | M | Fitts inverse |
| G2 | Targets under 24px (2.5.8) | M | a11y sweep |
| G3 | Toggle whose current state is ambiguous | R | GAP — toggle check |
| G4 | Button shows no busy state (double-submit possible) | M | GAP — click-twice probe |
| G5 | Link styled as button / button as link (wrong semantics) | S | GAP — semantics grep |
| G6 | Icon-only control with ambiguous glyph | F | fresh-eyes |
| G7 | Same action, different labels across screens | S | terminology corpus |
| G8 | Primary visually indistinct from secondary | M | hierarchy contrast |

## H. Feedback & status

| # | Failure | Det | Owner |
|---|---------|-----|-------|
| H1 | Silent success (refresh-only) | S | silent: sweep |
| H2 | Silent failure (catch swallows; optimistic revert unexplained) | S | AvailabilityCell lesson |
| H3 | Spinner forever — no timeout/failure copy | R | GAP — kill-backend probe |
| H4 | Long op with no progress or time estimate | R | feedback |
| H5 | Critical error delivered as auto-dismissing toast | R | GAP — persistence check |
| H6 | Stale data with no refresh indicator | R | GAP |
| H7 | Background work invisible (no queue/status) | S | feedback |
| H8 | Copy/download/export with no confirmation | M | notes lesson |
| H9 | State change lands outside viewport (no scroll/flash) | R | proximity feedback |
| H10 | aria-live absent on dynamic status | S | a11y sweep |

## I. Modals & overlays

| # | Failure | Det | Owner |
|---|---------|-----|-------|
| I1 | No Escape / no visible close | M | keyboard pass |
| I2 | Focus not moved in / not returned | M | focus probe |
| I3 | Mis-positioned (reset kills UA centering) | R | plainform lesson |
| I4 | Modal stacking (dialog over dialog) | R | GAP |
| I5 | Backdrop click discards unsaved input silently | M | GAP — dirty-dismiss probe |
| I6 | Desktop dialog not translating to sheet idiom | R | translation.md |
| I7 | Cookie banner/sticky chrome obscures focus (2.4.11) | M | a11y.md |
| I8 | Upsell interstitial interrupting a task | F | dark patterns |

## J. Copy & language

| # | Failure | Det | Owner |
|---|---------|-----|-------|
| J1 | Marketing voice inside the product | S/F | blame:/fresh-eyes |
| J2 | Raw enums/ids/statuses rendered | S | devbrain |
| J3 | Zero-based anything user-visible | S | devbrain |
| J4 | ISO/UTC/epoch dates for humans | S | devbrain |
| J5 | Unrounded precision (33.333333%) | S | devbrain |
| J6 | "1 items" pluralization | S | devbrain |
| J7 | "Click here"/"Learn more" link soup | S | attention front-loading |
| J8 | Same concept, different nouns across screens | S | terminology corpus |
| J9 | Jargon requiring insider knowledge, unexplained | F | fresh-eyes |
| J10 | Concatenated sentence fragments (i18n-hostile) | S | CS-brain locale |

## K. Color, theme & modes

| # | Failure | Det | Owner |
|---|---------|-----|-------|
| K1 | Text under AA (4.5/3:1) | M | contrast sweep |
| K2 | Hue-only signal (state/series/link) | M | CVD pass |
| K3 | Dark mode elevation inverted (dialog darker than page) | M | translation.md |
| K4 | Pure #000 scroll surfaces (OLED) | M | translation.md |
| K5 | One theme shipped, other unstyled | M | mode pass |
| K6 | forced-colors kills content/state | R | a11y.md modes |
| K7 | Focus indicator invisible or same-color | M | focus probe |
| K8 | Disabled state illegible (reads broken) | M | contrast sweep |

## L. Motion & time

| # | Failure | Det | Owner |
|---|---------|-----|-------|
| L1 | prefers-reduced-motion ignored | S/M | a11y modes |
| L2 | Infinite attention-seeking animation | R | beige plant |
| L3 | Layout shift on load (CLS) | M | perf sampling |
| L4 | Auto-advancing carousel/content | R | GAP |
| L5 | Skeleton flash on fast loads (<300ms) | R | GAP |
| L6 | Session timeout without warning/recovery | F | GAP |

## M. A11y structure

| # | Failure | Det | Owner |
|---|---------|-----|-------|
| M1 | No h1 / heading order broken | M | names pass |
| M2 | No landmarks/skip link on chrome-heavy pages | S | names pass |
| M3 | Positive tabindex | M | a11y sweep |
| M4 | Unlabeled inputs | M | a11y sweep |
| M5 | Images missing alt | M | a11y sweep |
| M6 | Table th/scope absent | S | plainform run lesson |
| M7 | Zoom blocked (user-scalable=no) | S | translation.md |
| M8 | Reflow broken at 320px | M | mode pass |
| M9 | Text-spacing override clips | M | toolkit |
| M10 | Paste blocked on credential fields | M | a11y sweep |

## N. Mobile & touch

| # | Failure | Det | Owner |
|---|---------|-----|-------|
| N1 | Primary CTA in top quadrant/corners on phone | M | thumb-zone instrument |
| N2 | safe-area violations (home-indicator overlap) | M | translation.md |
| N3 | Inputs <16px (iOS zoom) | M | translation.md |
| N4 | Hover-dependent affordances on touch | M | a11y sweep |
| N5 | Drag-only interactions | M | a11y sweep |
| N6 | Destructive in easy thumb reach | R | thumb zone |
| N7 | Feature present desktop, absent mobile (parity) | M | parity diff |
| N8 | Mobile-lite content (SEO + UX loss) | M | parity diff |

## O. Trust & dark patterns

| # | Failure | Det | Owner |
|---|---------|-----|-------|
| O1 | Decline/close visually buried vs accept | M | beige modal lesson |
| O2 | Preselected opt-ins (telemetry, marketing) | S | beige run lesson |
| O3 | Confirmshaming copy ("No, I hate saving money") | S | GAP — copy grep |
| O4 | Roach motel: one-click in, support-ticket out | F | GAP — cancel-path walk |
| O5 | Fake urgency/scarcity counters | S | GAP |
| O6 | Upsell styled as the primary action | R | beige plant (tab-order lesson) |
| O7 | Consent asymmetry (accept 1 click, refuse 5) | F | GAP — consent walk |
| O8 | Ads/promos disguised as content rows | R | GAP |

## P. Data visualization

| # | Failure | Det | Owner |
|---|---------|-----|-------|
| P1 | Chart with no values/axis (decoration posing as data) | R | beige run lesson |
| P2 | Truncated axis exaggerating change | S/R | GAP — axis check |
| P3 | Hue-only series | M | CVD pass |
| P4 | Legend far from data (match by memory) | R | proximity |
| P5 | 3D/area distortion of linear quantities | R | GAP |
| P6 | Precision theater (6 decimals on estimates) | S | devbrain |

## Q. Performance perception

| # | Failure | Det | Owner |
|---|---------|-----|-------|
| Q1 | Blank first paint (no shell/skeleton) | M | perf pass |
| Q2 | Route transitions with zero feedback | M | loading infra |
| Q3 | CLS during read | M | perf sampling |
| Q4 | Unbounded lists rendering all rows | S | GAP — count check |
| Q5 | Font swap flash / invisible text | M | perf pass |
| Q6 | Interaction latency >100ms with no active state | M | input delay |

**~130 modes.** GAP rows are still findings — this file is their
detection method until a dedicated check exists; cite the row id
(e.g. `E6`, `O4`) in the finding. New GAPs discovered in the field get
a row here THE SAME DAY, and a plant in the fixtures when practical.
