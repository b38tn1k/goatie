# Goatie 🐐

> A vibe-coded cover song of [ponytail](https://github.com/DietrichGebert/ponytail).
> Same chords, different chin.

[Ponytail](https://github.com/DietrichGebert/ponytail) is the best
plugin-shaped idea in the Claude Code ecosystem: a lazy senior developer,
riding shotgun in every session, asking *"does this code need to exist at
all?"* before you write it. It is all business. No fuss. Hair out of the
eyes, hands on the keyboard. This repo is not an improvement on ponytail.
Nothing is. Dietrich Gebert already wrote the last word on not writing
things.

But ponytail only governs what you **build**. Nobody was watching what
the user **sees**. So this is the cover version — recorded in one take,
by an AI, in somebody's garage, with the original playing through
headphones. Ponytail asks *"how little can I build?"* Goatie asks:

> **How little can the user think?**
>
> Can a first-time user complete the application's primary job with
> minimal effort and no confusion? Everything else is in service of that.

A ponytail keeps the hair out of *your* eyes. A goatee is the part other
people have to look at. Hence: domain.

## Install

```
claude plugin marketplace add b38tn1k/goatie
claude plugin install goatie@goatie
```

## The ladder (you've heard this one before, that's the point)

| Rung | Ponytail (the original) | Goatie (the cover) |
|------|------------------------|--------------------|
| 1 | Does this need to exist at all? | Does the user need to see this at all? |
| 2 | Stdlib does it? | A convention users already know covers it? |
| 3 | Native platform feature? | A default removes the decision? |
| 4 | Existing dependency? | Can it be one step? |
| 5 | The minimum code that works | New UI — next action obvious in 3 seconds |

Stop at the first rung that holds. The ladder is a reflex, not a
research project.

## What you get

| Piece | What it does |
|-------|--------------|
| **goatie mode** | Injected at session start. Every screen goes down the ladder. One primary action per screen, every action answers back, empty states and errors teach, never trap the user. Levels: lite / full / ultra. |
| `/goatie` | Switch level (`lite`, `full`, `ultra`) or reactivate. |
| `/goatie-review` | Friction review of a diff. Tagged one-liners: `cut:` `convention:` `default:` `hierarchy:` `silent:` `trap:` `blame:`. Ends with net decisions saved for a first-time user, or `First-time user ships. Done.` |
| `/goatie-audit` | Whole-app audit against a 120-point scorecard: purpose, workflow, navigation, cognitive load, hierarchy, feedback, onboarding, errors, control, performance feel. Top 5 problems, top 5 fixes with effort and impact. |
| `/goatie-help` | Reference card. |

## Evidence, not vibes (the vibes were only for the coding)

The audit runs a three-pass evidence protocol, because code and
screenshots each lie alone:

1. **Static inventory** — the route table is the screen list (coverage
   you can prove), plus corpus greps for missing states, missing exits,
   and every `"Invalid input."` in the building.
2. **Rendered walk** — launch the app, visit every route as a first-time
   user with empty data, capture screenshot **and** accessibility tree,
   force the error/empty states, click the primary workflow end to end
   counting decisions.
3. **Associate** — the accessibility tree bridges pixels to source:
   rendered text → grep → `file:line`. Visual findings get anchors,
   static findings get confirmed by the render, or they don't ship.

Missing undo is static-sufficient. Weak hierarchy is visual-sufficient.
Feedback needs both: the handler in the code *and* the spinner on the
screen.

## Ledger

Deliberate UX shortcuts are marked `// goatie: ...` in code, naming the
ceiling and the upgrade path — the same debt ledger ponytail keeps with
`// ponytail: ...`. Facial-hair comments accumulate; that's the system
working.

## Never cut

Loading/empty/error states, undo on destructive actions, accessibility
basics, validation messages. Minimal means fewer decisions for the user,
not fewer states in the UI.

## Stacking

They're better as a duet: **the laziest code behind the clearest
screen.** Ponytail deletes the abstraction; goatie deletes the decision.
Run both and ship something a first-time user finishes before their
coffee needs a `// ponytail:` comment.

---

*Cover songs owe royalties: all credit for the idea, the ladder, the
intensity levels, the debt-comment ledger, and the general hairstyle to
[Dietrich Gebert's ponytail](https://github.com/DietrichGebert/ponytail).
This one was vibe-coded with Claude Code in an afternoon. MIT, like the
original.*
