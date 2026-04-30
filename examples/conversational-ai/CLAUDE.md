# CLAUDE.md — Conversational AI Platform

This file is read automatically by Claude Code at the start of every session.
Do not remove it. Do not summarize it. Follow it exactly.

---

## About This Project

[Your project name and one sentence description]

A multi-channel conversational AI platform. AI agents handle customer interactions across web, SMS, and voice — automatically, at any hour.

---

## Stack

- **Backend**: Node.js + TypeScript
- **Frontend**: React + TypeScript
- **Database**: Postgres
- **Queue**: Redis + BullMQ (background jobs)
- **Channels**: [Web chat / SMS via Twilio / Voice via Twilio / other]
- **LLM**: [Anthropic Claude / OpenAI / other]
- **Hosting**: [AWS / Vercel / other]
- **Integrations**: [CRM / helpdesk / data systems / other]

---

## The Most Important Architectural Rule

Every feature must be classified before it is built:

**Rule-based** — inventory lookups, billing amounts, access codes, opt-out flags, compliance checks, send/don't-send decisions. These use structured data and logic only. They must never produce unpredictable output. An agent that makes up a price or an access code is a liability.

**AI-generated** — conversation tone, empathetic responses, recommendations phrased in natural language, open-ended questions. These use an LLM. Variability is acceptable and expected here.

These two types never share a function. The boundary between them is always explicit — in the spec, in the code, and in the PR.

---

## Architecture

Agents are discrete modules — one module per responsibility. They are composable. They do not share state or bleed into each other's scope.

Channel-specific logic lives in `src/channels/[channel]/`. Shared conversation logic lives in `src/conversation/`. Never put channel-specific assumptions in shared code.

All external system calls (CRM, data platforms, SMS/voice providers) go through `src/integrations/`. No agent calls an external system directly.

---

## Folder Structure

```
src/
  channels/
    web/              # web chat specific logic
    sms/              # SMS specific logic
    voice/            # voice specific logic
  conversation/       # shared conversation logic — no channel assumptions
  agents/             # agent modules — one file per agent
  integrations/       # one file per external system
  services/           # business logic
  routes/             # HTTP handlers only
  utils/
tests/
  unit/
  integration/
```

---

## Naming Rules

- Files: `kebab-case.ts`
- Agent modules: `[channel]-[action]-agent.ts`
  - Examples: `sms-collections-agent.ts`, `web-unit-recommendation-agent.ts`
  - Use `shared` as the channel prefix for agents that work across channels
- Functions: `camelCase`
- Types and interfaces: `PascalCase`
- Constants: `UPPER_SNAKE_CASE`

---

## Code Rules

- Classify every feature as rule-based or AI-generated before writing code
- Rule-based logic and AI-generated logic never share a function
- No external system calls outside `src/integrations/`
- No channel-specific code in `src/conversation/`
- Every agent module has a unit test
- No `console.log` — use the logger

---

## Do Not Touch Without Asking

- Opt-out and compliance logic — legal exposure if this breaks
- Billing and payment logic — flag for human review
- `src/integrations/` — integration code is fragile; do not refactor without explicit instruction

---

## Conversation Design Rules

- AI-generated responses must never include pricing, access codes, or account-specific data — pull those from rule-based lookups and inject them
- Every outbound message channel (SMS, email, voice) must check opt-out status before sending
- Failed sends must be logged with enough detail to retry or escalate manually

---

## Dependencies

```bash
# Core
npm install express typescript @types/node

# LLM
npm install @anthropic-ai/sdk
# or
npm install openai

# SMS / Voice
npm install twilio

# Queue
npm install bullmq ioredis

# Database
npm install pg drizzle-orm
# or
npm install @prisma/client prisma

# Validation
npm install zod
```
