# CLAUDE.md

This file is read automatically by Claude Code at the start of every session.
Do not remove it. Do not summarize it. Follow it exactly.

---

## About This Project

**Project name**: [your project name]
**What it does**: [one sentence — what does this do and for whom]
**Current stage**: [idea / early build / production / scaling]

---

## Stack

- **Language**: [TypeScript / Python / Go / Ruby / other]
- **Framework**: [Express / FastAPI / Rails / Next.js / other / none]
- **Database**: [Postgres / MySQL / MongoDB / SQLite / other / none]
- **Cache**: [Redis / Memcached / none]
- **Queue**: [BullMQ / SQS / Celery / none]
- **Hosting**: [AWS / Vercel / Fly.io / Heroku / Railway / other]
- **External services**: [Stripe / Twilio / SendGrid / OpenAI / other]

---

## How This Project Is Structured

[Describe the architecture in plain language. Where does code live? How do the pieces connect? One paragraph is enough. See examples/ for reference configurations.]

---

## Folder Structure

```
[paste your actual folder structure here]
```

---

## Naming Rules

- Files: [kebab-case / snake_case / PascalCase]
- Functions: [camelCase / snake_case]
- Classes and types: [PascalCase]
- Constants: [UPPER_SNAKE_CASE]
- Database tables: [snake_case, plural]

---

## Rules Claude Must Follow

These are non-negotiable. Follow them on every task, every file, every session.

- Every function does one thing. If the name includes "and", split it into two functions.
- No business logic in route handlers or controllers — that belongs in a service or module layer.
- All calls to external services go through a dedicated wrapper that handles errors and logs failures.
- Never put secrets, API keys, or credentials in code. Use environment variables.
- No debug logging left in production code.
- Prefer explicit code over clever code. The next person reading this should understand it immediately.
- [Add your own rules here]

---

## Do Not Touch Without Asking

- [Example: "Payment and billing logic — flag for human review before changing anything here"]
- [Example: "Database migrations — never edit an existing migration, always create a new one"]
- [Example: "Authentication middleware — changes here affect every user"]

---

## Tests

- **How to run tests**: [npm test / pytest / go test ./... / other]
- **Where tests live**: [tests/ / __tests__/ / spec/]
- **What requires a test**: [example: "Every new function in services/. Every new API endpoint."]

---

## Environment Variables

- Never put secrets, API keys, or passwords in code
- Every variable must be listed in `.env.example` with a description but no real value
- If you add a new variable, add it to `.env.example` in the same change

---

## Before Opening a PR

Every pull request must include:
1. What changed and why
2. How to test it
3. What was deliberately left out

Use `PR_TEMPLATE.md` to generate this description automatically.

---

## When You're Not Sure

- Ask before refactoring something that already works
- Flag anything that touches [your critical areas] before changing it
- If the right approach isn't clear, describe the options and tradeoffs instead of picking one
- Test in a real environment before calling something done
