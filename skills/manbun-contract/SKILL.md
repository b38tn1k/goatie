---
name: manbun-contract
description: >
  Synthesise or reconcile a capability contract — pillars with promises
  and primary jobs, roles, and a can/refuse/invisible/open cell matrix
  — so feature gaps become countable and audits check written claims
  instead of vibes. Use on /manbun-contract, "synthesise the pillars",
  "capability contract", "what features are missing", "find feature
  gaps", "what does this app promise". Runs before or alongside
  /manbun-audit; the full portable technique is in
  capability-contract.md next to this skill.
---

Read `capability-contract.md` in this directory first — it is the
doctrine; this file is only the manbun wiring. The contract finds a
different class of gap than the audit: the audit finds what's built
badly, the contract finds **what's missing or was never decided**.

## Mode is decided by what exists

Look for a contract first: `capability-contract.{json,md,ts}` at repo
root, `docs/`, or `.manbun/`. Found → **reconcile**. Absent →
**synthesise**. Never overwrite a human-ratified contract with an
inferred one.

## Synthesise (no contract exists)

1. **Evidence before invention.** Pillars come from the artifact:
   routes, nav groupings, schema concentrations, the copy's own nouns.
   **A skeleton is a declaration of intent** — a stubbed route, a
   disabled button, an empty panel, an unused table, a TODO'd flow all
   say the dev wants that capability. For each skeleton ask, in order:
   what would the *ideal* version of this promise a user? what exists
   today? the difference is a **capability gap**, logged as such.
2. Write pillars with one-sentence `promise` + `primaryJob`. Features
   serving no pillar go on the "do we actually need this?" list
   (ponytail gets a say). Missing pillars implied by skeletons get
   drafted with the ideal-version statement.
3. Enumerate roles behaviourally, always including the degenerate
   three (signed-out, tokened-no-session, signed-in-unprovisioned).
   Reuse /manbun-journeys personas where they exist — same axis.
4. Fill every (pillar × role) cell. Unknown policy = `open` with the
   real question and what today's accidental behaviour costs. Where
   the code silently picked a policy nobody chose, that IS an `open`
   cell plus a finding.
5. **Ratification is mandatory.** An inferred contract is a
   hypothesis: mark every unconfirmed cell `"inferred": true`, present
   the matrix and the open-question inbox to the developer, and only
   drop the inferred flag on cells they confirm. A wrong contract is
   worse than none — never let inference masquerade as decision.
6. Write the contract as data next to the code (default:
   `capability-contract.json` in the repo, matching the Cell interface
   in the doctrine) and offer the pin layer: one small check script
   enforcing the honesty invariants (gate symbols exist, questions end
   in `?`, no invisible+gated cells, full pillar × role coverage,
   routes audited-or-excluded off the filesystem).

## Reconcile (contract exists)

Diff the contract against the current artifact, both directions:
- code drifted → cells now false, gates renamed/deleted, new routes
  belonging to no pillar, new roles the pillars are silent on;
- contract lies → `contract-wrong`, a first-class finding equal to a
  code defect.
Re-present the `open` inbox: unanswered questions age, and answered
ones must have been encoded in contract + gate — an answer living
only in a note is itself a finding. Update cells, keep the diff in
the report.

## Feeding the audit

/manbun-audit checks for a contract in phase 1. Present → every cell
is a claim to verify cell-by-cell (`refuse`: gate on every path,
actionable message, no dead-end button; `can`: doable AND findable;
`invisible`: probe URLs/tokens/neighbouring roles), findings go
through the skeptic pass expecting ~a third refuted, and the report
gains a **Capability gaps** section — ranked by promise impact,
separate from defect findings. Absent → the audit proceeds unchanged
and notes that /manbun-contract is available; the contract supports
the audit, never gates it. Contract failure shapes map to catalog
section R rows.

## Boundaries

The contract states what the code does today, not what anyone intends
— intent lives in `open` questions and capability gaps. The answer
inbox is never an authority: behaviour changes only when a human
encodes the answer in contract + gate. Reports and the contract file
are the only writes; ratification is the developer's, always.
