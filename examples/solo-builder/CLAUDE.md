# CLAUDE.md — Solo Builder

This file is read automatically by Claude Code at the start of every session.
Do not remove it. Do not summarize it. Follow it exactly.

---

## About This Project

[Your project name and one sentence description]

You are the only engineer on this project. You are also the reviewer.
The templates still matter — the spec forces you to think before you build,
and the PR description forces you to articulate what you did.
Future you is the person who reads these. Write for that person.

---

## Stack

- **Language**: [your language]
- **Framework**: [your framework or "none"]
- **Database**: [your database or "none"]
- **Hosting**: [where it runs]

---

## Architecture

[One paragraph. How the pieces connect. Where code lives. Keep it honest — if the architecture is "one big file right now," say that. Claude will work with whatever you have.]

---

## Folder Structure

```
[paste your actual folder structure here — even a rough version helps]
```

---

## Rules

These are your standards. Claude follows them on every task.

- Every function does one thing
- No secrets in code — environment variables only
- No debug logging left in production code
- Prefer explicit code over clever code
- [Add your own]

---

## Do Not Touch Without Asking

Even as a solo builder, some things deserve a pause before changing.

- [Example: "Database schema — think before migrating"]
- [Example: "Auth logic — changes affect every user"]
- [Example: "Deployment config — wrong settings = downtime"]

---

## Tests

- **How to run tests**: [npm test / pytest / go test ./... / none yet]
- **Where tests live**: [tests/ / __tests__/ / spec/]
- **Rule**: everything new gets a test. No exceptions.

---

## Environment Variables

- Never put real values in code
- Every variable listed in `.env.example` with a description but no real value

---

## When You Are Not Sure

You don't have a teammate to ask. This section is your forcing function.

- If you can't describe the approach in one sentence, write a spec first
- If you're about to refactor something that works, ask yourself why
- If the change touches something critical, sleep on it
- Test in a real environment before calling it done
