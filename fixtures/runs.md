# Benchmark runs

## 2026-07-24 · skill @ e7030a8

| Fixture | Recall | False positives | Notes |
|---------|--------|-----------------|-------|
| beige-crm | **26/26 planted** | 0 | Blind subagent auditor, own tab, spoilers fenced. Also surfaced **11 unplanted-but-true defects** (fictional row count, Add never inserts, dead nav tabs, settings autosave is a lie, 940px reflow break, modal decline dark-pattern, chart with no values, telemetry opt-out default, th scope, unwired drag, dead CTAs) — the fixture contains more truth than its answer key; extras verified true by the spoiled scorer. |
| plainform | — | pending | |

Auditor-declared coverage gaps (honest): forced-colors / prefers-contrast /
text-spacing / 200% zoom not emulatable in the harness — checks that don't
need emulation ran instead. No dark theme exists in the fixture to test.

Scoring notes: matched on substance. Auditor's root-cause clustering
(one contrast token = findings 7/8/20/28; one icon-button decision =
3/16/17) matched the planted intent almost exactly.
