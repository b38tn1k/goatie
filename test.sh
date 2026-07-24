#!/bin/sh
# goatie: smallest check that fails if the plugin breaks — JSON parses, files exist, hook path resolves.
set -e
cd "$(dirname "$0")"
node -e 'JSON.parse(require("fs").readFileSync(".claude-plugin/plugin.json"))'
node -e 'JSON.parse(require("fs").readFileSync(".claude-plugin/marketplace.json"))'
node -e 'const h=JSON.parse(require("fs").readFileSync("hooks/hooks.json")); if(!h.hooks.SessionStart[0].hooks[0].command.includes("skills/goatie/SKILL.md")) throw new Error("hook does not load the skill")'
for f in skills/goatie/SKILL.md skills/goatie-review/SKILL.md skills/goatie-audit/SKILL.md skills/goatie-help/SKILL.md \
         commands/goatie.toml commands/goatie-review.toml commands/goatie-audit.toml commands/goatie-help.toml; do
  [ -s "$f" ] || { echo "missing: $f"; exit 1; }
done
grep -q "120" skills/goatie-audit/SKILL.md || { echo "audit lost its scorecard"; exit 1; }
grep -q "Evidence protocol" skills/goatie-audit/SKILL.md || { echo "audit lost its evidence protocol"; exit 1; }
grep -q "Rendered check" skills/goatie-review/SKILL.md || { echo "review lost its rendered check"; exit 1; }
echo "goatie OK"
