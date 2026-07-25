#!/bin/sh
# manbun: smallest check that fails if the plugin breaks — JSON parses, files exist, hook path resolves.
set -e
cd "$(dirname "$0")"
node -e 'JSON.parse(require("fs").readFileSync(".claude-plugin/plugin.json"))'
node -e 'JSON.parse(require("fs").readFileSync(".claude-plugin/marketplace.json"))'
node -e 'const h=JSON.parse(require("fs").readFileSync("hooks/hooks.json")); if(!h.hooks.SessionStart[0].hooks[0].command.includes("skills/manbun/SKILL.md")) throw new Error("hook does not load the skill")'
for f in skills/manbun/SKILL.md skills/manbun-review/SKILL.md skills/manbun-audit/SKILL.md skills/manbun-help/SKILL.md \
         commands/manbun.toml commands/manbun-review.toml commands/manbun-audit.toml commands/manbun-help.toml; do
  [ -s "$f" ] || { echo "missing: $f"; exit 1; }
done
grep -q "120" skills/manbun-audit/SKILL.md || { echo "audit lost its scorecard"; exit 1; }
grep -q "Evidence protocol" skills/manbun-audit/SKILL.md || { echo "audit lost its evidence protocol"; exit 1; }
grep -q "Rendered check" skills/manbun-review/SKILL.md || { echo "review lost its rendered check"; exit 1; }
[ -s skills/manbun-audit/toolkit.md ] || { echo "missing toolkit"; exit 1; }
grep -q "toolkit.md" skills/manbun-audit/SKILL.md || { echo "audit lost its toolkit reference"; exit 1; }
grep -q "Fresh eyes" skills/manbun-audit/SKILL.md || { echo "audit lost fresh eyes"; exit 1; }
grep -q "orphan:" skills/manbun-review/SKILL.md || { echo "review lost orphan tag"; exit 1; }
grep -q "devbrain:" skills/manbun-review/SKILL.md || { echo "review lost devbrain tag"; exit 1; }
grep -q "computer-science-brain" skills/manbun-audit/SKILL.md || { echo "audit lost CS-brain check"; exit 1; }
[ -s skills/manbun-bench/SKILL.md ] && [ -s commands/manbun-bench.toml ] || { echo "missing bench skill"; exit 1; }
[ -s skills/manbun-audit/a11y.md ] || { echo "missing a11y reference"; exit 1; }
grep -q "2.5.8" skills/manbun-audit/a11y.md || { echo "a11y lost WCAG 2.2 checks"; exit 1; }
[ -s skills/manbun-audit/proximity.md ] && [ -s skills/manbun-audit/translation.md ] || { echo "missing proximity/translation refs"; exit 1; }
grep -q "proximity:" skills/manbun-review/SKILL.md && grep -q "parity:" skills/manbun-review/SKILL.md || { echo "review lost proximity/parity tags"; exit 1; }
node -e 'const t=JSON.parse(require("fs").readFileSync("fixtures/beige-crm/truth.json")); if(t.defects.length!==t.plantedTotal) throw new Error("beige-crm truth count mismatch")'
node -e 'JSON.parse(require("fs").readFileSync("fixtures/plainform/truth.json"))'
echo "manbun OK"
