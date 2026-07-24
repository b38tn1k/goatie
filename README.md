# Goatie 🐐

> A vibe-coded cover song of [ponytail](https://github.com/DietrichGebert/ponytail).
> Same chords, different chin. All credit for the idea, the ladder, the
> levels, and the general hairstyle to Dietrich Gebert's original —
> nothing improves on ponytail, this just plays it in a different key.

**He says nothing. He removes one field. They finish.**

You know him too. Goatee. Thick-rimmed glasses. A notebook he writes one
word in per meeting. He has stood behind the one-way glass at every
usability test since before the product had its current name, watching a
thousand first-time users hover a cursor and quietly give up. You show
him a screen with five buttons; he looks at it, says nothing, and leaves
one. The next tester finishes without asking anything.

The guy with the ponytail replaces your fifty lines with one. The guy
with the goatee watches someone's mom try your app.

**Goatie puts him inside your AI agent.**

## Before / after

You ask for onboarding. Your agent installs a product-tour library,
writes a six-step wizard, adds a progress bar, and starts a discussion
about confetti.

With goatie:

```html
<!-- goatie: the empty state is the onboarding -->
<p>No invoices yet. Your first one takes about a minute.</p>
<button>Create your first invoice</button>
```

## Numbers

Ponytail measured twelve real tasks, four runs each, against a real
repo, and published the tables. We are not going to pretend that
happened here.

| vs your current UI | clicks | decisions | confusion | measured |
|--------------------|--------|-----------|-----------|----------|
| goatie             | fewer  | fewer     | less      | no       |

Every cell in that table is a vibe. The honest instrument ships in the
box instead: `/goatie-audit` is the benchmark, run on *your* app — a
120-point scorecard with screenshots and source both in evidence, and
the one metric the whole thing optimizes: **decisions a first-time user
never had to make.** Current sample size: **n=you**.

## How it works

Before drawing UI, the agent stops at the first rung that holds:

```
1. Does the user need to see this at all?  → no: cut it
2. A convention users already know?        → use it, don't invent
3. A default can make the decision?        → make it, don't ask
4. Can it be one step?                     → one step
5. Only then: new UI — next action obvious in 3 seconds
```

The ladder runs after it understands the task, not instead of it: it
reads the flow the screen lives in before picking a rung. Minimal for
the user, never at the user's expense — loading, empty, and error
states, undo on destructive actions, accessibility basics, and
validation messages are never on the chopping block. Minimal means
fewer decisions, not fewer states.

Deliberate shortcuts get marked `// goatie: ...` with the ceiling and
the upgrade path, same ledger discipline as `// ponytail: ...`. Facial-
hair comments accumulate; that's the system working.

## Evidence, not vibes (the vibes were only for the coding)

The audit runs a three-pass evidence protocol, because code and
screenshots each lie alone:

1. **Static inventory** — the route table is the screen list (coverage
   you can prove), plus corpus greps for missing states, missing exits,
   and every `"Invalid input."` in the building.
2. **Rendered walk** — launch the app, visit every route as a
   first-time user with empty data, capture screenshot **and**
   accessibility tree, force the error and empty states, click the
   primary workflow end to end counting decisions.
3. **Associate** — the accessibility tree bridges pixels to source:
   rendered text → grep → `file:line`. Visual findings get anchors,
   static findings get confirmed by the render, or they don't ship.

Missing undo is static-sufficient. Weak hierarchy is visual-sufficient.
Feedback needs both: the handler in the code *and* the spinner on the
screen.

## Install

The most effort goatie will ever ask of a first-time user:

```
claude plugin marketplace add b38tn1k/goatie
claude plugin install goatie@goatie
```

(Two separate prompts, in that order.)

Ponytail installs on twenty agents. Goatie installs on one. He noticed
you only ever use one.

That was it. Two steps. He counted, and he thinks it should be one.

## Commands

| Command | What it does |
|---------|--------------|
| `/goatie [lite \| full \| ultra \| off]` | Set the intensity, or turn it off. `ultra` challenges a screen's existence before styling it. |
| `/goatie-review` | Review the current diff for first-time-user friction. Tagged one-liners: `cut:` `convention:` `default:` `hierarchy:` `silent:` `trap:` `blame:`. Ends with net decisions saved, or `First-time user ships. Done.` |
| `/goatie-audit` | Audit the whole app against the 120-point scorecard, evidence protocol and all. Top 5 problems, top 5 fixes with effort and impact. |
| `/goatie-help` | Quick reference for the commands above. |

## FAQ

**Can I use it with ponytail?** Yes, and you should. Different halves,
no overlap: ponytail shrinks what the agent builds, goatie shrinks what
the user has to think about. The laziest code behind the clearest
screen.

**What if I really need the six-step wizard?** You don't. Insist anyway
and he'll build it. Every step will have a working back button. You'll
meet all of them.

**Does it scale?** The decision the user never faces scales infinitely.
Zero support tickets, zero rage-clicks, 100% task completion since
forever.

**Where's the settings page?** There isn't one. That's the whole
lesson.

**Why "goatie"?** You know exactly why.

## License

MIT. The default license, so you never had to decide.

---

*Cover songs owe royalties: everything structural here is
[Dietrich Gebert's ponytail](https://github.com/DietrichGebert/ponytail),
transposed from code to screens. This one was vibe-coded with Claude
Code in an afternoon, which the goatee guy would point out is itself a
first-time-user story with exactly one step.*
