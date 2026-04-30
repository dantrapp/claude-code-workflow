# CLAUDE.md — REST API

This file is read automatically by Claude Code at the start of every session.
Do not remove it. Do not summarize it. Follow it exactly.

---

## About This Project

[Your project name and one sentence description]

A REST API. Clients send HTTP requests, the API processes them, persists or retrieves data, and returns JSON responses.

---

## Stack

- **Language**: [TypeScript / Python / Go / Ruby / other]
- **Framework**: [Express / FastAPI / Gin / Rails / other]
- **Database**: [Postgres / MySQL / SQLite / MongoDB / other]
- **Cache**: [Redis / none]
- **Queue**: [BullMQ / Celery / Sidekiq / none]
- **Auth**: [JWT / sessions / API keys / OAuth]
- **Hosting**: [AWS / Fly.io / Railway / Heroku / other]

---

## Architecture

Requests flow through three layers and nothing else:

1. **Route handlers** — receive the request, validate inputs, call a service, return a response. No business logic here.
2. **Services** — all business logic lives here. Services call models. Services call external integrations. Nothing else does.
3. **Models** — database queries only. No logic, no decisions.

All calls to external APIs go through `src/integrations/` with error handling and logging.
Background jobs go through the queue — never block a request for slow work.

---

## Folder Structure

```
src/
  routes/           # route handlers — thin, no logic
  services/         # business logic
  models/           # database queries
  integrations/     # one file per external service
  middleware/       # auth, error handling, request logging
  utils/            # shared helpers
  types.ts          # shared types
tests/
  unit/             # service and model tests
  integration/      # API endpoint tests
.env.example
```

---

## Naming Rules

- Files: `kebab-case.ts` / `snake_case.py` (match your language convention)
- Functions: `camelCase` (JS/TS) / `snake_case` (Python/Ruby/Go)
- Classes and types: `PascalCase`
- Constants: `UPPER_SNAKE_CASE`
- Database tables: `snake_case`, plural
- API routes: `/kebab-case`, RESTful nouns, versioned under `/v1/`

---

## API Design Rules

- Routes are nouns, not verbs: `/users` not `/getUsers`
- Use HTTP verbs correctly: GET (read), POST (create), PUT/PATCH (update), DELETE (delete)
- Return consistent error shapes: `{ error: { code, message } }`
- Always version the API: `/v1/resource`
- Paginate any endpoint that returns a list — never return unbounded results
- Document every new endpoint before building it

---

## Code Rules

- Business logic never lives in route handlers
- Every external API call goes through `src/integrations/` — no direct calls elsewhere
- Database migrations are one-way — never edit an existing migration, always create a new one
- Background jobs must handle being run twice without causing problems
- No secrets in code — environment variables only
- Every new service function gets a unit test

---

## Do Not Touch Without Asking

- Authentication and authorization middleware — changes affect every request
- Database migrations — irreversible by design
- Payment or billing logic — flag for human review
- Rate limiting configuration — changes affect all clients

---

## HTTP Status Codes

Use these correctly. Getting them wrong causes bugs in every client.

- `200` — success with a response body
- `201` — created successfully
- `204` — success with no response body (e.g. DELETE)
- `400` — bad request (client error, invalid input)
- `401` — not authenticated
- `403` — authenticated but not authorized
- `404` — not found
- `409` — conflict (e.g. duplicate resource)
- `422` — validation failed
- `429` — rate limit exceeded
- `500` — server error (never expose internal details)

---

## Environment Variables

Document every variable in `.env.example`:

```
DATABASE_URL=        # Postgres connection string
REDIS_URL=           # Redis connection string (if using cache/queue)
JWT_SECRET=          # Secret for signing tokens — must be long and random
PORT=3000            # Port the server listens on
```
