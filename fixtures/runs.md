# Benchmark runs

## 2026-07-24 · skill @ e7030a8

| Fixture | Recall | False positives | Notes |
|---------|--------|-----------------|-------|
| beige-crm | **26/26 planted** | 0 | Blind subagent, spoilers fenced. Also surfaced **11 unplanted-but-true defects** (fictional row count, Add never inserts, dead nav tabs, settings autosave lie, 940px reflow break, modal decline dark-pattern, chart with no values, telemetry default, th scope, unwired drag, dead CTAs) — extras verified true by the spoiled scorer. |
| plainform | — | **0 fabricated** | Reported 4 defects; skeptical scoring confirmed **all 4 were real bugs in the "clean" fixture** (no aria error wiring, focus lost to body after delete, dialog pinned top-left by the * margin reset, row overflow at 320px). Fixture fixed same day; the auditor also correctly isolated 2 tool artifacts (synthetic-Escape on native dialog) as NOT app bugs by injecting a control dialog. |

Net: recall 26/26, precision 100% (zero fabricated findings across both
runs), and the benchmark's first output was fixing its own control app.

Auditor-declared coverage gaps (honest): forced-colors / prefers-contrast /
text-spacing emulation limited in-harness; no dark theme in beige-crm.

## 2026-07-26 · answer key expanded (field feedback)

Composition/order + screen-space utilization missed in the field
(ShadowLeague club-admin class: daily section below one-time setup,
phone column at desktop width). Pillars encoded in proximity.md +
toolkit; `composition-order-quick-add-buried` planted in beige-crm
(key now 27). Run 1's auditor also missed it — retroactive recall
**26/27**. The number got worse because the key got smarter; next run
gates the new check. Also new: walled screens gained the static-layout-
render rung (markup + real CSS + placeholder data, no auth needed) —
composition findings no longer hide behind login walls.
