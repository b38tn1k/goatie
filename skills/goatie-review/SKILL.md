---
name: goatie-review
description: >
  UI review focused exclusively on first-time-user friction. Finds what
  confuses: competing CTAs, silent actions, invented patterns, decisions a
  default should make, dead ends, blaming errors. One line per finding:
  location, the friction, the fix. Use when the user says "review the ux",
  "is this confusing", "friction review", "review for first-time users",
  or invokes /goatie-review. Complements correctness review — this one
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

## Examples

❌ "This modal might present some usability concerns; consider whether the
save flow could be streamlined for newer users."

✅ `L42: hierarchy: three equal buttons on one screen. "Save" is primary, rest are text links.`

✅ `Export.tsx:L18: silent: export runs with no feedback. Add spinner + "Exported 240 rows" toast.`

✅ `L77: default: currency dropdown defaults to empty. Default to the workspace locale, keep the dropdown.`

✅ `L12-30: cut: 4-field "tell us about yourself" step before first task. Nothing replaces it.`

✅ `L55: blame: "Invalid input." → "Email must contain an @".`

✅ `Settings.tsx:L9: trap: modal has no close or escape. Esc + X, keep unsaved values as draft.`

## Rendered check

Static text can't see hierarchy. If the app can run, map the touched
components to their routes and screenshot just those screens — that
render is the evidence for any `hierarchy:` finding. From code alone,
tag it `hierarchy?:` (suspected) instead. If the diff touches an error
or empty state, force that state in the render; never review a state's
happy-path sibling and call it covered.

## Scoring

End with the only metric that matters:
`net: -<N> decisions/clicks for a first-time user.`

If there is nothing to cut, say `First-time user ships. Done.` and stop.

## Boundaries

Friction only — correctness bugs, security, and performance go to a normal
review pass. Loading, empty, and error states are the goatie minimum, never
flag them as clutter. Does not apply the fixes, only lists them.
"stop goatie-review" or "normal mode": revert to verbose review style.
