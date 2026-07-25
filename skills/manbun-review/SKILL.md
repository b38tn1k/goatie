---
name: manbun-review
description: >
  UI review focused exclusively on first-time-user friction. Finds what
  confuses: competing CTAs, silent actions, invented patterns, decisions a
  default should make, dead ends, blaming errors. One line per finding:
  location, the friction, the fix. Use when the user says "review the ux",
  "is this confusing", "friction review", "review for first-time users",
  or invokes /manbun-review. Complements correctness review — this one
  only hunts confusion.
---

Review UI changes from the perspective of a first-time user mid-task. One
line per finding: location, the friction, the smallest fix. The diff's best
outcome is fewer decisions.

## Format

`L<line>: <tag> <friction>. <fix>.`, or `<file>:L<line>: ...` for
multi-file diffs.

Tags:

- `cut:` element, field, or step the primary task never needs. Fix: nothing.
- `convention:` invented pattern where a known one exists. Name the standard pattern.
- `default:` decision the app should make for the user. Name the default.
- `hierarchy:` competing CTAs or no obvious next step. Name the one primary action.
- `silent:` action with no feedback state. Name the missing state (loading / success / error / empty).
- `trap:` no undo, back, cancel, or escape. Name the exit.
- `blame:` error or empty-state copy that doesn't teach. Show the rewrite.
- `a11y:` unlabeled control, invisible focus, hue-only signal, contrast below floor, keyboard-unreachable action. Name the missing attribute or the pairing (label, icon, weight) that fixes it.
- `orphan:` the diff removes or reroutes a screen's last inbound UI link. Page-level diffs look clean while doing this — when a diff touches links, nav, or routes, recompute inbound links for the affected screens before signing off. Name the screen stranded and the link that must exist.
- `devbrain:` the machine's mental model leaked into the UI: zero-based numbering, raw enums/ids/timestamps, unrounded precision, jargon copy, implementation-shaped flows. Show the human rewrite.
- `proximity:` a thing and what acts on it live apart: label far from field, error in a global banner instead of at the field, confirm button across the screen from the trigger, feedback outside the user's locus of attention. Name what moves next to what. Intent loss belongs here too — form values wiped by a validation error, a redirect that forgets where the user was going, filters lost on back.
- `parity:` the app degrades across form factors instead of translating: features hidden on mobile with no path, hover-only affordances on touch, a stretched single column on desktop, fixed-width layouts that force panning. Name the capability lost and the rearrangement that restores it.

## Examples

❌ "This modal might present some usability concerns; consider whether the
save flow could be streamlined for newer users."

✅ `L42: hierarchy: three equal buttons on one screen. "Save" is primary, rest are text links.`

✅ `Export.tsx:L18: silent: export runs with no feedback. Add spinner + "Exported 240 rows" toast.`

✅ `L77: default: currency dropdown defaults to empty. Default to the workspace locale, keep the dropdown.`

✅ `L12-30: cut: 4-field "tell us about yourself" step before first task. Nothing replaces it.`

✅ `L55: blame: "Invalid input." → "Email must contain an @".`

✅ `Settings.tsx:L9: trap: modal has no close or escape. Esc + X, keep unsaved values as draft.`

✅ `FlightAssigner.tsx:L565: devbrain: flights labeled "level 0". Humans count from 1 — nobody joins the level-zero flight.`

## Rendered check

Static text can't see hierarchy. If the app can run, map the touched
components to their routes and screenshot just those screens — that
render is the evidence for any `hierarchy:` finding. From code alone,
tag it `hierarchy?:` (suspected) instead. If the diff touches an error
or empty state, force that state in the render; never review a state's
happy-path sibling and call it covered. Render touched screens in every
standard mode — light, dark, and a color-vision check (grayscale at
minimum): a flat canvas-colored container, a second left edge against
the page grid, borderline contrast, or a hue-only signal is a finding
with the measurement quoted. Tab through any touched controls. Phrase
visual fixes as directions — "fatten", "skinny down", "heavier",
"raise contrast a step" — anchored to the measurement, never to a
framework constant or a named product's look.

## Scoring

End with the only metric that matters:
`net: -<N> decisions/clicks for a first-time user.`

If there is nothing to cut, say `First-time user ships. Done.` and stop.

## Boundaries

Friction only — correctness bugs, security, and performance go to a normal
review pass. Loading, empty, and error states are the manbun minimum, never
flag them as clutter. Does not apply the fixes, only lists them.
"stop manbun-review" or "normal mode": revert to verbose review style.
