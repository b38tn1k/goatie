---
name: manbun-bench
description: >
  Measure manbun-audit against the planted-defect fixture apps: spawn
  blind auditor subagents, score recall against truth.json and false
  positives against the clean control, log the run. Use when the user
  says "benchmark manbun", "run the fixtures", "manbun-bench",
  "/manbun-bench", or "what's the recall". Also the regression gate
  after skill changes.
---

Measure the skill, not the apps. The fixtures in `fixtures/` have known
planted defects (`truth.json` per app — the answer key). The auditor
must be blind; the scorer may be spoiled.

## Procedure

1. **Serve** the fixtures statically (any static server on the
   `fixtures/` directory).
2. **Spawn one blind auditor subagent per fixture** — a fresh context
   that has never seen the fixtures built. Its prompt must:
   - fence the spoilers: it may read ONLY the fixture's own page
     sources; `truth.json` and `fixtures/README.md` are answer keys —
     no opening, no listing, no recursive greps over `fixtures/`;
   - point it at the audit skill files to follow (SKILL.md,
     toolkit.md, a11y.md);
   - have it use its own browser tab, exercise interactions freely
     (fixtures are disposable), and return a flat `tag | where | what`
     findings list, symptoms clustered to causes.
3. **Score as the spoiled party.** Diff findings against `truth.json`
   on substance, not wording. Per bad fixture: **recall = matched ÷
   planted**. On the clean control: every high-severity finding is a
   **false positive**; note-level suggestions are fine and worth
   reading — sometimes the fixture is wrong, not the auditor.
4. **Log the run** to `fixtures/runs.md`: date, skill commit, per-app
   recall, false positives, and the missed defects by id.
5. **Close the loop.** Every miss is a candidate check for the audit
   skill; every false positive is a calibration note. When recall is
   embarrassing, the fix goes in the skill, not the fixture. Re-run
   after skill changes — the fixtures are the regression suite.

## Boundaries

Never audit the fixtures yourself in a session that built or read
them — spawn fresh contexts. Never edit fixture pages and truth.json
out of sync (`test.sh` checks the counts). Adding a new fixture:
plant defects that map to review tags, keep ground truth only in
truth.json, verify the mechanical plants register with the toolkit
instruments before trusting the fixture.
