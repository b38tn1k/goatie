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
first-time user. Ignore aesthetics unless they affect usability. Focus on
task completion. Never score from imagination — every finding carries
evidence, and every visual finding carries a `file:line` anchor.

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
clutter, contrast — repeat key screens at mobile width (and dark mode if
supported). Use the phase-1 state list to force the unhappy paths: drive
each error and empty state, never photograph only success. Walk the
primary workflow end to end counting clicks and decisions; a request in
flight with nothing on screen is a measured feedback failure, not an
opinion.

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
3. **Top 5 UX problems** — worst first, each with severity and the friction it causes.
4. **Top 5 highest-value improvements** — each with estimated effort (S/M/L) and expected user impact.
5. Every improvement phrased as the smallest change that fixes the friction, goatie-style.

## Boundaries

Reports only, applies nothing. Correctness bugs and security found in
passing get one line and a pointer to a normal review. Pairs with
/ponytail-audit: that one hunts over-engineered code, this one hunts
over-complicated screens.
