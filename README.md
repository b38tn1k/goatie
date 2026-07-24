<p align="center">
  <img src="assets/manbun.png" alt="Manbun" width="260">
</p>

<h1 align="center">Manbun</h1>

<p align="center"><em>He says nothing. He removes one field. They finish.</em></p>

<p align="center">
  <img alt="works with 1 agent" src="https://img.shields.io/badge/works%20with-1%20agent-333333">
  <img alt="benchmarks n=you" src="https://img.shields.io/badge/benchmarks-n%3Dyou-333333">
  <img alt="cover of ponytail" src="https://img.shields.io/badge/cover%20of-ponytail-333333">
  <img alt="MIT license" src="https://img.shields.io/badge/license-MIT-333333">
</p>

<p align="center"><strong>fewer clicks · fewer decisions · less confusion · measured: no</strong></p>

<p align="center">
No benchmarks. <a href="https://github.com/DietrichGebert/ponytail">Ponytail</a> measured twelve
real tasks and published the tables; this is the cover version, so it ships the instrument
instead — <code>/manbun-audit</code> scores <em>your</em> app against a 120-point scorecard with
screenshots and source both in evidence. Sample size to date: <strong>n=you</strong>.
</p>

---

Ponytail is a lazy senior dev riding shotgun in your agent, asking *"does
this need to exist at all?"* before code gets written. It covers what you
build. Nobody was covering what the user sees.

Manbun is the same idea pointed at the screen. A ponytail is hair tied
back so you can work; a man bun is the same hair, tied where everyone
else can see it. One optimizes for the wearer, the other cares how it
reads from across the room.

> **How little can the user think?**
>
> Can a first-time user complete the application's primary job with
> minimal effort and no confusion? Everything else is in service of that.

You know the guy. Man bun, round glasses, tote bag from a type foundry.
He's watched a thousand usability tests through the one-way glass. You
show him a screen with five buttons; he looks at it, says nothing, and
leaves one. The next tester finishes without asking anything.

Manbun puts him inside your AI agent.

## Before / after

You ask for onboarding. Your agent installs a product-tour library,
writes a six-step wizard, adds a progress bar, and starts a discussion
about confetti.

With manbun:

```html
<!-- manbun: the empty state is the onboarding -->
<p>No invoices yet. Your first one takes about a minute.</p>
<button>Create your first invoice</button>
```

## The ladder

| Rung | Ponytail | Manbun |
|------|----------|--------|
| 1 | Does this need to exist at all? | Does the user need to see this at all? |
| 2 | Stdlib does it? | A convention users already know covers it? |
| 3 | Native platform feature? | A default removes the decision? |
| 4 | Existing dependency? | Can it be one step? |
| 5 | The minimum code that works | New UI — next action obvious in 3 seconds |

Stop at the first rung that holds.

## Evidence, not vibes

The audit runs three passes, because code and screenshots each lie
alone:

1. **Static inventory** — the route table is the screen list (coverage
   you can prove), plus corpus greps for missing states, missing exits,
   and every `"Invalid input."` in the building.
2. **Rendered walk** — every route, every standard mode (light, dark,
   color-vision sims), error and empty states forced, the primary
   workflow clicked end to end with decisions counted.
3. **Associate** — the accessibility tree bridges pixels to source:
   rendered text → grep → `file:line`. Visual findings get anchors,
   static findings get confirmed by the render, or they don't ship.

Missing undo is static-sufficient. Weak hierarchy is visual-sufficient.
Feedback needs both. Findings carry what confirmed them (`measured`,
`fresh-eyes`, `skeptic`, `static`) and a skipped pass ships labeled
`unverified` rather than silently.

## Install

```
claude plugin marketplace add b38tn1k/manbun
claude plugin install manbun@manbun
```

(Two separate prompts, in that order.)

Ponytail installs on twenty agents. Manbun installs on one. He noticed
you only ever use one.

## Commands

| Command | What it does |
|---------|--------------|
| `/manbun [lite \| full \| ultra \| off]` | Set the intensity, or turn it off. `ultra` challenges a screen's existence before styling it. |
| `/manbun-review` | Friction review of the current diff. Tagged one-liners: `cut:` `convention:` `default:` `hierarchy:` `silent:` `trap:` `blame:` `a11y:` `orphan:` `devbrain:`. Ends with net decisions saved, or `First-time user ships. Done.` |
| `/manbun-audit` | Whole-app audit: 120-point scorecard, two altitudes (page flow and app flow), every color mode, fresh-eyes subagents, receipts, and a baseline so the next run reports deltas. |
| `/manbun-help` | Quick reference. |

## Ledger

Deliberate UX shortcuts get marked `// manbun: ...` in code, naming the
ceiling and the upgrade path — same discipline as ponytail's
`// ponytail: ...` marker.

## FAQ

**Can I use it with ponytail?** Yes. No overlap: ponytail shrinks what
the agent builds, manbun shrinks what the user has to think about. Same
hair, both ends of it.

**What if I really need the six-step wizard?** You don't. Insist anyway
and he'll build it. Every step will have a working back button. You'll
meet all of them.

**Does it scale?** The decision the user never faces scales infinitely.

**Where's the settings page?** There isn't one. That's the whole
lesson.

**Wasn't this called goatie?** Briefly. The joke is about the hair, not
the chin.

**Why "manbun"?** You know exactly why.

## License

MIT. The default, so you never had to decide.

---

*Everything structural here is
[Dietrich Gebert's ponytail](https://github.com/DietrichGebert/ponytail),
transposed from code to screens. Vibe-coded with Claude Code across a
handful of field audits.*
