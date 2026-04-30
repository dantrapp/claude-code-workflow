# WORKFLOW.md

One page. The full pattern from idea to shipped code.

---

## The Pattern

```
Idea or ticket
      ↓
SPEC_TEMPLATE.md  →  structured plan before any code
      ↓
Claude Code builds  (CLAUDE.md runs automatically)
      ↓
PR_TEMPLATE.md  →  PR description that actually explains the work
      ↓
Review and test
A human reads it. You verify it works in a real environment.
      ↓
Merge
```

### Step by step

1. **Spec first.** Open `SPEC_TEMPLATE.md`. Copy the prompt inside the code block. Paste it into Claude Code with your ticket or idea at the bottom. Read the output. Fix anything wrong before you build.
2. **Build.** Claude Code reads `CLAUDE.md` automatically — your stack, rules, and boundaries are already loaded. You steer. Claude executes.
3. **Document.** Open `PR_TEMPLATE.md`. Copy the prompt inside the code block. Paste it into Claude Code with your completed spec and a summary of what you built. Use the output as your PR description.
4. **Review and test.** Read the PR. Run the tests. Verify it works in a real environment.
5. **Merge.**

---

## The Three Rules

**No code before a spec.**
The most expensive mistake in software is building the wrong thing correctly.
Five minutes of planning prevents hours of rework.

**No PR without a description.**
A PR with no description is a black box.
Future you will thank present you for writing it down.

**No merge without a real test.**
"Works on my machine" is not a test.
Test in a real environment before calling it done.

---

## The Files

**CLAUDE.md** — Claude Code reads this automatically at the start of every session.
It tells Claude about your project: the stack, the structure, the rules, what not to touch.
Without it, Claude guesses. With it, Claude produces code that belongs in your codebase.
Keep it current. It's only useful if it's accurate.

**AGENTS.md** — the agentic layer.
Defines what Claude can decide on its own and what always needs a human.
Optional for solo builders. Essential for teams running agentic workflows.

**SPEC_TEMPLATE.md** — a prompt you run before building anything.
Input: a ticket, an idea, a bug report.
Output: a structured plan with scope, steps, edge cases, and open questions.
The open questions section is the most valuable part. If you can't answer them, don't start building.

**PR_TEMPLATE.md** — a prompt you run after building, before opening a PR.
Input: your completed spec plus what you actually built.
Output: a PR description that explains what changed, what was left out, and how to test it.
The "what's not included" section is the most important part. Be honest about it.

---

## For Solo Builders

You don't have a reviewer. You are the reviewer.

The templates still matter. The spec forces you to think before you build.
The PR description forces you to articulate what you did.
Future you is the person who reads these. Write for that person.

AGENTS.md is still worth filling out. Being explicit about what decisions require
you to stop and think — versus what can run on autopilot — is valuable even alone.

---

## For Teams

Consistency compounds.

One engineer's Claude Code session producing code that looks nothing like another's
creates the same technical debt as any other inconsistency — just faster, because
the volume is higher.

CLAUDE.md is the shared standard. One file, every session, every engineer.
When patterns change, update CLAUDE.md. Everyone's next session reflects it immediately.

AGENTS.md is where agentic workflows become safe at scale. Define the boundaries once.
Every agent, every session, every engineer works inside them.
