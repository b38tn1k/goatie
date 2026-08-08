# The capability contract — portable technique

Project-agnostic. Drop this file into any repo or skill directory.

## The problem it solves

"Polish the UX" is unfalsifiable. You click around, find something, fix
it, and have no idea what fraction of the app you just covered.
Persona-based audits find real things but can't tell you when to stop,
and "no findings" never becomes trustworthy — it might mean the app is
good or that the auditor got bored. The contract makes the border
declared, so coverage becomes a number and an audit becomes a check
against a written claim rather than a vibe.

## The shape — two axes, one cell type

**Pillars** — the concentrations the product is actually made of, not
your module names. Each gets:

- a `promise`: the one-sentence guarantee to a user. If you can't write
  it in one sentence, the pillar isn't real yet.
- a `primaryJob`: the single job it exists to do. The Apple-ification
  test — anything in the pillar not serving the job has to justify
  itself, and any feature belonging to no pillar is either a missing
  pillar or a feature without a home. That second list is your "do we
  actually need this?" list.

**Roles** — behavioural, not org-chart. Include a role whenever a group
behaves differently enough that treating them as another role causes
bugs. Include the degenerate ones people forget: signed-out visitor,
someone holding an emailed magic link with no session,
signed-in-but-not-yet-provisioned. Those three are where most dead
ends live.

**Cells** — one statement per (pillar, role), four verdicts:

```
can        — offered and permitted
refuse     — reachable, and the app must decline with a reason a human can act on
invisible  — never offered, and not reachable by guessing a URL or holding a token
open       — undecided; this belongs to the humans, not the code
```

```ts
interface Cell {
  pillar: string;
  role: string;
  value: "can" | "refuse" | "invisible" | "open";
  what: string;      // one line, in the person's own terms — never the code's
  gate?: string;     // for refuse: the function that enforces it
  question?: string; // for open: what the humans actually have to decide
}
```

Two verdicts do the heavy lifting:

- **`refuse` is the point of the whole exercise.** `can` cells get
  exercised by ordinary use — bugs there surface on their own.
  Refusals are proven by nothing until you write them down. Nearly
  every behavioural bug worth finding lives in a "should have refused
  and didn't" cell: a cancelled item still accepting input, an
  archived record still editable, a role rule blocking the wrong role.
- **`open` is the highest-value invention.** It's a cell where the code
  has quietly picked a policy nobody chose. "TBD" is worthless; the
  actual question — with the tension in it, and what today's behaviour
  costs — turns the matrix into a decision inbox. Surface these
  prominently; capture answers durably. Critically: the answer store
  is an inbox, not an authority. Nothing reads it to decide behaviour.
  An answer becomes real only when a human encodes it in the contract
  and the gate — otherwise a note in a textarea silently changes what
  the app does.

## Three layers

1. **Describe.** The matrix as data in the codebase, next to the code —
   not in a wiki that rots.
2. **Pin.** Tests that make a lie fail CI.
3. **Audit against it.** Now coverage is countable and "no findings"
   means something.

## The tests that keep it honest

- Every `refuse` cell names a gate, and that symbol exists in source.
  Catches refusals that were never built.
- Every `open` cell has an answerable question — minimum length and a
  literal `?`. Catches "TBD" laundering.
- No cell is both `invisible` and gated — a contradiction about
  whether the thing is reachable.
- Every pillar has a promise and a primary job above a minimum length.
- **Every written pillar covers every role.** A pillar silently saying
  nothing about one role is exactly the gap audits keep finding —
  make silence impossible.
- Separate guardrail: every page/route is either audited or excluded
  in writing with a reason, read off the filesystem. Coverage that
  depends on someone remembering to add a route decays the day
  someone adds a route.

## Running the audit against it

Fan out one auditor per pillar-group, cell by cell. The question is
never "is this good?" but "does the code keep this statement?":

- `refuse` → does the gate run on every path? Does the message say
  what to do next? Is the action still offered where it will only be
  refused — a dead-end button?
- `can` → can they do it, AND can they find it? A capability with no
  route or link is a dead grant.
- `invisible` → truly unreachable, or merely unlinked? Guess the URL,
  hold a token, stand in a neighbouring role.

Then hand every finding to a skeptic told to refute it, defaulting to
"refuted" when uncertain, reporting any narrower real defect found
while tracing. Expect roughly a third refuted — the refutations are
frequently sharper than the original claims.

**The taxonomy** (each shape needs a different fix):
`broken-refusal` · `dead-grant` · `reachable-invisible` ·
`promise-unmet` · `contract-wrong`

## Failure modes, learned the hard way

- **A wrong contract is worse than no contract**, because it gets
  trusted. "The statement is inaccurate" is a first-class finding,
  equal to a code defect — in one audit the most valuable finds were
  cells where the code was fine and the claim was a lie.
- **Beware green that means "nothing was checked."** An audit over a
  page that rendered a permission-refusal passes cleanly. Assert each
  surface rendered its own content before believing a pass.
- **Don't hand-roll what a mature tool does.** For anything mechanical
  — contrast, a11y — use the standard engine. A hand-written checker
  passed a page on which the real tool found 173 failures.
- **A capability's boundary is often undocumented.** When you write
  "role X can do Y", also write who can't — that adjacent refusal is
  usually the thing nobody had ever stated.
- **The contract catches your own work fast** — but only if cells are
  written honestly about what the code does today, not what you
  intend.
