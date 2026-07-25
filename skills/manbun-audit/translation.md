# manbun-audit form-factor translation reference

The principle: **one product at every size — capabilities rearrange,
never disappear.** Judge the translation in BOTH directions: web→mobile
(rearrange, scale, de-hover) and mobile→desktop (add density, hover,
keyboard — not a stretched phone layout).

## Where to audit

At minimum 320 / 375 / 768 / 1024 / 1280 px, plus **every breakpoint
declared in the app's own stylesheets ±1px** (audit at the CSS's own
seams, not arbitrary devices — the Polypane method). At each: no
horizontal page overflow, reflow holds (WCAG 1.4.10 at 320px), and the
idiom switches happen (nav pattern, table strategy, dialog↔sheet).
Reference vocab for "what should change at this width": Material
window size classes (compact <600dp / medium / expanded / large) and
their canonical layouts (list-detail, supporting pane, feed); Apple
size classes for the iOS idiom.

## Spatial rearrangement

- **Navigation.** Hiding main nav roughly halves content discovery
  (NNGroup). ≤4–5 destinations at mobile → visible bottom tab bar, not
  a hamburger; hamburger tolerable only >5–6 or browse-mostly.
  Priority+ (expose what fits, overflow the rest) beats hiding
  everything. A hamburger at desktop widths is a finding on its own.
- **Tables.** Never a squeezed full grid. Acceptable translations:
  column-priority hiding, rows→cards when all columns matter, or
  deliberate horizontal scroll for true comparison data WITH sticky
  first column/header.
- **Forms.** Single column on mobile, and per Baymard mostly on
  desktop too; only tightly-related fields share a row (city/state/
  zip). Multi-column desktop forms must collapse.
- **Dialogs.** Centered dialog (desktop) ↔ bottom sheet / action
  sheet (mobile) is the expected idiom switch.
- **Thumb zone** (Hoober: ~75% of touches are thumbs; accuracy and
  attention concentrate mid-screen and degrade at edges/corners).
  Primary actions bottom/center-reachable at phone widths — flag a
  primary CTA in the top quadrant or corners at 375px. Destructive and
  rare actions belong OUT of the easy zone.

## Scaling

- Targets: 24px is the WCAG fail floor, not a design target — primary
  touch controls want 44pt/48dp, ≥8px between adjacent targets.
- Inputs ≥16px font at mobile widths (else iOS zooms); the fix is
  never `user-scalable=no` (that's a 1.4.4 failure — flag the meta).
- Body 16–20px; fluid type via clamp() must keep a rem component;
  desktop measure capped ~75ch — unconstrained full-width text is a
  finding.
- **Hover is a loan, not a foundation.** Every `:hover`-revealed
  action needs a non-hover path on touch (always-visible, overflow
  menu); hover rules guarded by `@media (hover)/(pointer)`. Tooltips
  are enhancement — a UI that needs them is a finding.

## Color & rendering on small screens

- Dark themes: no pure `#000` scroll surfaces (OLED smear, halation) —
  the Material baseline is `#121212`, elevation communicated by
  LIGHTENING surfaces (a dialog darker than its page is upside-down);
  accents desaturate on dark.
- Outdoor legibility: 4.5:1 stays the floor, but primary/critical
  mobile text earns an advisory below 7:1 — sunlight collapses
  perceived contrast.
- Hardcoded hex that bypasses the platform's semantic colors (iOS
  dynamic colors, Material roles) is the token-discipline finding at
  the platform level.
- `viewport-fit=cover` demands `env(safe-area-inset-*)` on fixed
  chrome; nothing interactive in the home-indicator band.

## Simplification vs parity

- **Parity is the default.** Mobile-first indexing means the mobile
  DOM IS the site; content collapsed-but-present (accordion,
  expander) passes, content absent fails — diff the extracted text and
  interactive inventory between 375px and 1280px, expect ≈ empty.
  Never cut on mobile: core tasks, prices, contact, help, account
  functions. Legitimately adaptive: hover previews, bulk/keyboard
  chrome, decorative imagery, density.
- **The reverse direction has its own failure**: mobile-first scaled
  up = content dispersion — stretched single column occupying a
  1280px viewport, oversized heroes, low density, excess scrolling.
  Going up you must ADD: visible focus + hover states, keyboard
  shortcuts, side-by-side layouts (list-detail), line-length caps.

Findings from this file tag `parity:` (capability or idiom lost in
translation) or `hierarchy:`/`a11y:` where they land in those classes.
