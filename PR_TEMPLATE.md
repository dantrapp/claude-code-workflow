# PR_TEMPLATE.md

Use this after building, before opening a pull request.

Paste your completed spec and a description of what you actually built.
A PR description is a permanent record of why code exists.
Six months from now, someone will read it trying to understand a decision. Write it for that person.

---

## The Prompt

Copy everything inside the box and paste it into Claude Code.
Replace the placeholders with your actual spec and build summary.

---

```
Read CLAUDE.md before responding. Generate a pull request description
using the format below. Be specific. Be honest about what's missing.
Do not pad or summarize vaguely.

---

Original spec:
[PASTE YOUR COMPLETED SPEC HERE]

What I actually built:
[Describe what you implemented. Note anything that changed from the spec,
anything you discovered while building, and any decisions you made that
weren't in the original plan.]

---

Generate a PR description in this exact format:

## What this does
[2-3 sentences. What does this PR add or change? Why does it exist?]

## What changed
[List every file added, modified, or deleted]

## How to test it
[Step by step. Assume the reviewer has never seen this feature.
What do they set up? What do they run? What does passing look like?]

## What's not included
[What will be missing or incomplete until follow-up work is done?
If everything from the spec is done, write: "Complete per spec."]

## Decisions made
[Any choices made during building that weren't obvious from the spec.
Tradeoffs accepted. Alternatives rejected. Things a reviewer might question.]

## Checklist
- [ ] Tested locally
- [ ] Tests written for new code
- [ ] No secrets or credentials in the code
- [ ] .env.example updated if new variables were added
- [ ] Tested in staging (if applicable)
- [ ] Linked to ticket

## Ticket
[Ticket ID or link]
```

---

## After You Get the Output

1. Read it before posting it — if it doesn't match what you built, fix it
2. "What's not included" is the most important section — be honest
3. Go through the checklist for real, not as a formality
4. If you made decisions a reviewer won't understand without context, add them to "Decisions made"
