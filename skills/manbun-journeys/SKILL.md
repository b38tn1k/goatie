---
name: manbun-journeys
description: >
  Personas and user stories as testable journeys — inferred from the
  artifact when an app exists, hypothesis-labeled when greenfield. Use
  on /manbun-journeys, "who is this app for", "generate personas",
  "user stories for this app", "map the journeys". Never a substitute
  for real user research.
---

A persona document invented without research is fiction with a
headshot. This skill refuses to make posters. What it makes is TEST
CASES: who plausibly uses the app, the one job each hires it for, and
the journey that must therefore be walkable. The story is the test,
not the deliverable.

## Two modes

**Artifact mode — an app exists.** Infer personas from evidence:
routes, roles, auth gates, nav groupings, who the copy addresses.
(This is the audit's phase-1 persona enumeration, made exportable.)
Per persona: name, the ONE job, the primary story — "As <persona>, I
<job>, so <outcome>" — and the acceptance test: *walkable in the
rendered app in ≤N decisions from <entry>, no dead end*. Feed every
story to /manbun-audit's app-flow altitude; an unwalkable story is a
finding, not a shrug.

**Hypothesis mode — greenfield.** From the stated context (say, an app
coordinating in-person TTRPG sessions: the GM who schedules, the flaky
player RSVPing from a phone at work, the host tracking table space,
the shop owner renting it), draft 3–5 personas max, one primary story
each, labeled **HYPOTHESES** — guesses to invalidate with real users,
not research. Their value is direction: each story names the screens,
states, and defaults the build needs before code exists. A story you
can't storyboard in ladder terms (job → default → one step → obvious
next action) is scope — cut it.

## Output

One page total. Per persona: two lines of who/context, the one job,
the primary story, the acceptance test, and the **anti-scope** — what
this persona never needs, which is as load-bearing as what they do.
Close with a journeys × screens table the audit can walk.

## Boundaries

3–5 personas, one story each — more is theater. Hypothesis-mode output
carries the word "hypothesis" visibly. One observed real user outranks
every generated persona; when behavior contradicts the persona, the
persona dies, not the observation.
