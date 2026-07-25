# manbun-audit proximity & intent reference

The principle: **what acts on a thing lives on the thing, and the
user's intent survives everything.** Two halves — spatial locality and
intent continuity — both testable.

## Locality (Gestalt proximity, common region, law of locality)

- **Labels.** Top-aligned label + field read in near-one fixation
  (Penzo eye-tracking via Wroblewski); left-aligned forces a zigzag —
  flag it on mobile always, and flag left-aligned-left-justified label
  columns anywhere. A label must sit visibly nearer its own field than
  any neighbor; equidistant = ambiguous = finding. DOM association
  (`for`/`id` or wrapping) is the machine-readable half.
- **Group spacing.** Whitespace between groups must exceed whitespace
  within groups — measurable from sibling gaps. A shared border or
  background (common region) groups harder than proximity; unrelated
  items sharing a card are grouped whether you meant it or not.
- **Controls live where they act** (law of locality): the delete on
  the item it deletes, add at the insertion point, container-wide
  actions at the container top. A control that acts on one item but
  renders outside that item's bounding region is a `proximity:`
  finding.
- **Errors live at the field.** Validation errors render DOM-adjacent
  to the offending field with `aria-describedby` — banner-only or
  toast-only errors force the user to memorize and hunt (NNGroup).
  Validate on blur, not per keystroke.
- **Feedback lands where attention is**: confirmation near the
  triggering control, not only a distant corner toast.

## Fitts costs

- Distance × size: flag frequent pairs where the second target is far
  or small — last field → submit, trigger → confirm (a dialog's
  confirm landing in a different screen quadrant than the click), item
  → its primary action beyond the item's region.
- The inverse problem too: destructive adjacent to primary with < 8px
  gap is a mis-tap trap.
- Desktop edges/corners are infinite targets — **cursor only, never
  touch**. Note missed edge-anchoring as advisory, not failure.

## Attention flow

- F-pattern scanning is what users do to *unformatted* walls of text —
  a symptom, not a target. Enable layer-cake scanning instead:
  descriptive headings every few hundred words; flag >~600 words with
  no h2/h3. Front-load the first two words of headings and links —
  "Learn more" ×5 is a finding.
- Z-reasoning applies to sparse pages (heroes, landings): primary
  action on the top band or the terminal position. Dense app UIs are
  governed by grouping and locality, not letter patterns. Mirror for
  RTL.

## Intent continuity — the tracking half

Every one of these is a mechanical probe:

- **Auth deep-links.** Request a gated URL with query params while
  logged out → sign in → the final URL equals the original, params
  intact (`returnUrl`/`next` pattern). The return URL must reject
  foreign hosts (open-redirect probe — one line, flag to a security
  review if it passes a foreign host).
- **Forms survive errors.** Submit with one bad field → every other
  field keeps its value (W3C G85), focus and scroll move to the first
  error.
- **Back restores state.** Lists restore scroll + filters + page on
  back-navigation; filter/sort state serialized in the URL so it
  survives reload and sharing. Check bfcache eligibility: `unload`
  handlers and `Cache-Control: no-store` on HTML are the blockers.
- **Interruptions resume.** Mid-form reload or tab kill → draft
  restored or a quiet recovery prompt ("resume or start over"), per
  the autosave pattern. "Continue where you left off" for long flows.

Losing any of these is a `proximity:` finding (intent class): the app
forgot what the user was doing.
