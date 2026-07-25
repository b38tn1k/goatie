# Fixtures — known-failure test apps

Small static apps with **planted defects** for testing `/manbun-audit`
against ground truth. No build step: serve a directory with any static
server and audit it.

```
npx serve fixtures/beige-crm     # or: python3 -m http.server -d fixtures/beige-crm
```

| App | What it is | Planted |
|-----|-----------|---------|
| `beige-crm` | A beige SaaS dashboard written by nobody's best self. Failures span every review tag: hierarchy, silent, trap, blame, a11y (incl. WCAG 2.2 plants: target size, dragging, redundant entry), devbrain, grid. | 26 |
| `plainform` | The clean control — a small invoice app built the way manbun says to build. Zero planted defects. | 0 |

## Scoring a run

1. **Audit first, peek second.** `truth.json` is a spoiler file — an
   auditing agent must not read it before the audit. Audit the served
   app cold, then diff.
2. **Recall** = planted defects the audit surfaced ÷ planted total
   (beige-crm: n/26). Match on substance, not wording.
3. **Precision** = findings on `plainform`. High-severity findings there
   are false positives; note-level suggestions are acceptable and worth
   reading — sometimes the fixture is wrong, not the auditor.
4. Log the run's numbers in the audit report. When the recall number is
   embarrassing, the fix goes in the skill, not the fixture.

The fixtures are also the regression suite for skill changes: a check
added to the skill should move recall on the class it targets.
