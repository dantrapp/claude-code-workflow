# CLAUDE.md — Next.js App

This file is read automatically by Claude Code at the start of every session.
Do not remove it. Do not summarize it. Follow it exactly.

---

## About This Project

[Your project name and one sentence description]

A full-stack Next.js application using the App Router. Server components, client components, API routes, and a database — all in one repo.

---

## Stack

- **Framework**: Next.js (App Router)
- **Language**: TypeScript
- **Styling**: [Tailwind CSS / CSS Modules / other]
- **Database**: [Postgres via Prisma / Supabase / PlanetScale / other]
- **Auth**: [NextAuth / Clerk / Auth.js / custom]
- **Hosting**: [Vercel / Fly.io / other]
- **External services**: [list yours]

---

## Architecture

This project uses the Next.js App Router. Understanding server vs client components is the most important architectural distinction.

**Server components** — the default. Run on the server. Can fetch data directly. Cannot use hooks or browser APIs. Use these for everything that doesn't need interactivity.

**Client components** — marked with `'use client'` at the top. Run in the browser. Can use hooks and handle events. Cannot access the database directly. Use these only when you need interactivity.

**The rule**: push `'use client'` as far down the component tree as possible. The less JavaScript shipped to the browser, the better.

**API routes** live in `app/api/`. Use them for mutations, webhooks, and anything that needs to stay on the server but be called from the client.

**Server actions** are functions marked with `'use server'` that run on the server but can be called directly from client components. Use them for form submissions and mutations.

---

## Folder Structure

```
app/
  (routes)/         # route groups — organize without affecting URLs
  api/              # API route handlers
  layout.tsx        # root layout
  page.tsx          # root page
components/
  ui/               # generic, reusable components (buttons, inputs, etc.)
  [feature]/        # feature-specific components
lib/
  db/               # database client and queries
  auth/             # auth utilities
  utils.ts          # shared helpers
public/             # static assets
```

---

## Naming Rules

- Files: `kebab-case.tsx` for components, `kebab-case.ts` for utilities
- Components: `PascalCase`
- Functions and variables: `camelCase`
- Constants: `UPPER_SNAKE_CASE`
- Route folders: `kebab-case`
- Dynamic segments: `[param]` following Next.js convention

---

## Component Rules

- Default to server components. Add `'use client'` only when required.
- Every `'use client'` component needs a comment explaining why it needs to be a client component.
- No database calls in client components.
- No secrets or private env variables in client components — they get shipped to the browser.
- Keep components focused — one concern per component.

---

## Data Fetching Rules

- Fetch data in server components where possible — no loading states, no waterfalls.
- Use React Suspense with a fallback for async server components.
- Mutations go through server actions or API routes — never mutate data from a server component directly.
- Cache data deliberately — know whether you want `force-cache`, `no-store`, or revalidation.

---

## Environment Variables

Next.js has two types:

- `NEXT_PUBLIC_` prefix — exposed to the browser. Never put secrets here.
- No prefix — server only. Safe for secrets, API keys, database URLs.

```
# Server only — never expose these to the browser
DATABASE_URL=
AUTH_SECRET=

# Browser-safe — no secrets
NEXT_PUBLIC_APP_URL=
NEXT_PUBLIC_ANALYTICS_ID=
```

---

## Do Not Touch Without Asking

- `app/layout.tsx` — changes here affect every page
- Auth configuration — changes affect every user
- Database migrations — irreversible by design
- `next.config.js` — affects build and runtime behavior globally

---

## Performance Rules

- No `'use client'` without a reason
- Images always use `next/image` — never a raw `<img>` tag
- Fonts always use `next/font` — never a `<link>` tag
- Never import a heavy library into a client component if a lighter alternative exists
