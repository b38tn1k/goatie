# Manbun 💇‍♂️

> A vibe-coded cover song of [ponytail](https://github.com/DietrichGebert/ponytail).
> Same hair, tied differently.

[Ponytail](https://github.com/DietrichGebert/ponytail) is the best
plugin-shaped idea in the Claude Code ecosystem: a lazy senior developer,
riding shotgun in every session, asking *"does this code need to exist at
all?"* before you write it. It is all business. Hair out of the eyes,
hands on the keyboard. This repo is not an improvement on ponytail.
Nothing is. Dietrich Gebert already wrote the last word on not writing
things.

But ponytail only governs what you **build**. Nobody was watching what
the user **sees**. So here's the cover version — recorded in one take,
by an AI, in somebody's garage, with the original playing through
headphones. And the name is the thesis: a ponytail is hair tied back so
*you* can work. A man bun is the same hair, tied up where *everyone
else* can see it. One optimizes for the wearer; the other cares how it
reads from across the room. Ponytail asks *"how little can I build?"*
Manbun asks:

> **How little can the user think?**
>
> Can a first-time user complete the application's primary job with
> minimal effort and no confusion? Everything else is in service of that.

**He says nothing. He removes one field. They finish.**

You know him too. Man bun. Round glasses. A tote bag from a type
foundry. He has stood behind the one-way glass at every usability test
since before the product had its current name, watching a thousand
first-time users hover a cursor and quietly give up. You show him a
screen with five buttons; he looks at it, says nothing, and leaves one.
The next tester finishes without asking anything.

The ponytail guy replaces your fifty lines with one. The man-bun guy
watches someone's mom try your app.

**Manbun puts him inside your AI agent.**

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

## Numbers

Ponytail measured twelve real tasks, four runs each, against a real
repo, and published the tables. We are not going to pretend that
happened here.

| vs your current UI | clicks | decisions | confusion | measured |
|--------------------|--------|-----------|-----------|----------|
| manbun             | fewer  | fewer     | less      | no       |

Every cell in that table is a vibe. The honest instrument ships in the
box instead: `/manbun-audit` is the benchmark, run on *your* app — a
120-point scorecard with screenshots and source both in evidence, and
the one metric the whole thing optimizes: **decisions a first-time user
never had to make.** Current sample size: **n=you**.

## The ladder (you've heard this one before — that's the point)

| Rung | Ponytail (the original) | Manbun (the cover) |
|------|------------------------|--------------------|
| 1 | Does this need to exist at all? | Does the user need to see this at all? |
| 2 | Stdlib does it? | A convention users already know covers it? |
| 3 | Native platform feature? | A default removes the decision? |
| 4 | Existing dependency? | Can it be one step? |
| 5 | The minimum code that works | New UI — next action obvious in 3 seconds |

Stop at the first rung that holds. The ladder is a reflex, not a
research project.

## Evidence, not vibes (the vibes were only for the coding)

The audit runs a three-pass evidence protocol, because code and
screenshots each lie alone:

1. **Static inventory** — the route table is the screen list (coverage
   you can prove), plus corpus greps for missing states, missing exits,
   and every `"Invalid input."` in the building.
2. **Rendered walk** — launch the app, visit every route as a
   first-time user with empty data, capture screenshot **and**
   accessibility tree in every standard mode (light, dark, color-vision
   sims), force the error and empty states, click the primary workflow
   end to end counting decisions.
3. **Associate** — the accessibility tree bridges pixels to source:
   rendered text → grep → `file:line`. Visual findings get anchors,
   static findings get confirmed by the render, or they don't ship.

Missing undo is static-sufficient. Weak hierarchy is visual-sufficient.
Feedback needs both: the handler in the code *and* the spinner on the
screen. Findings are labeled with what confirmed them — `measured`,
`fresh-eyes`, `skeptic`, `static` — and a skipped verification pass
ships visibly as `unverified`, never silently.

## Install

The most effort manbun will ever ask of a first-time user:

```
claude plugin marketplace add b38tn1k/manbun
claude plugin install manbun@manbun
```

(Two separate prompts, in that order.)

Ponytail installs on twenty agents. Manbun installs on one. He noticed
you only ever use one.

That was it. Two steps. He counted, and he thinks it should be one.

## Commands

| Command | What it does |
|---------|--------------|
| `/manbun [lite \| full \| ultra \| off]` | Set the intensity, or turn it off. `ultra` challenges a screen's existence before styling it. |
| `/manbun-review` | Review the current diff for first-time-user friction. Tagged one-liners: `cut:` `convention:` `default:` `hierarchy:` `silent:` `trap:` `blame:` `a11y:` `orphan:` `devbrain:`. Ends with net decisions saved, or `First-time user ships. Done.` |
| `/manbun-audit` | Audit the whole app against the 120-point scorecard: two altitudes (page flow and app flow), every color mode, fresh-eyes subagents, receipts, and a baseline so the next audit reports deltas. |
| `/manbun-help` | Quick reference for the commands above. |

## Ledger

Deliberate UX shortcuts are marked `// manbun: ...` in code, naming the
ceiling and the upgrade path — the same debt ledger ponytail keeps with
`// ponytail: ...`. Hair-adjacent comments accumulate; that's the
system working.

## FAQ

**Can I use it with ponytail?** Yes, and you should. Different halves,
no overlap: ponytail shrinks what the agent builds, manbun shrinks what
the user has to think about. The laziest code behind the clearest
screen. Same hair, both ends of it.

**What if I really need the six-step wizard?** You don't. Insist anyway
and he'll build it. Every step will have a working back button. You'll
meet all of them.

**Does it scale?** The decision the user never faces scales infinitely.
Zero support tickets, zero rage-clicks, 100% task completion since
forever.

**Where's the settings page?** There isn't one. That's the whole
lesson.

**Wasn't this called goatie?** Briefly. Then we remembered the joke is
about the *hair*, not the chin. Cover songs get remastered.

**Why "manbun"?** You know exactly why.

## License

MIT. The default license, so you never had to decide.

---

*Cover songs owe royalties: everything structural here is
[Dietrich Gebert's ponytail](https://github.com/DietrichGebert/ponytail),
transposed from code to screens. This one was vibe-coded with Claude
Code across a handful of field audits, which the man-bun guy would
point out is itself a first-time-user story with exactly one step.*
