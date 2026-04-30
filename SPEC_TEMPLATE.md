# SPEC_TEMPLATE.md

Use this before writing any code.

Paste your ticket, idea, or feature description into Claude Code with the prompt below.
A clear spec before you build is the single highest-leverage thing you can do.
Building the wrong thing correctly is the most expensive mistake in software.

---

## The Prompt

Copy everything inside the box and paste it into Claude Code.
Replace the placeholder at the bottom with your actual ticket or idea.

---

```
Read CLAUDE.md before responding. Everything you produce must be consistent
with the stack, structure, and rules defined there.

Do not write any code yet. Produce a structured plan for the following:

[PASTE YOUR TICKET, IDEA, OR FEATURE DESCRIPTION HERE]

---

Answer each section below. Be specific. Say what you don't know.

## Summary
What does this do, in plain English? One or two sentences. No technical jargon.

## What This Touches
List every file, folder, service, or component this adds, changes, or removes.
Use actual file paths where possible.

## How It Works
Walk through what happens step by step:
- What starts this? (a user action, a scheduled job, an API call, etc.)
- What data comes in and where does it come from?
- What decisions get made and how?
- What happens at the end? Where does output go?

## Dependencies
- What already needs to exist for this to work?
- What needs to be built or changed first?
- Any external services, APIs, or packages involved?

## Edge Cases
List at least three things that could go wrong or behave unexpectedly.
For each one: what happens, and what should the system do?

## Done When
List the exact conditions that make this complete.
Write each one so it could become a test.
If you cannot write a test for it, rewrite it until you can.

## Not Included
What are you explicitly not building here?
Name it. Ambiguous scope is how small tickets become disasters.

## Questions
What needs to be answered before building starts?
If nothing, write: "Ready to build."

## Complexity
Simple / Medium / Complex — and one sentence explaining why.
If Complex, suggest how to split it into smaller pieces.
```

---

## After You Get the Output

1. Read it before accepting it
2. Fix anything that's wrong before building starts — not after
3. Answer every open question before writing code
4. If it's Complex, break it up first
5. Save the completed spec — you'll paste it into PR_TEMPLATE.md when you're done
