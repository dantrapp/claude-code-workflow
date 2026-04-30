# CLAUDE.md — Programmatic SEO

This file is read automatically by Claude Code at the start of every session.
Do not remove it. Do not summarize it. Follow it exactly.

---

## About This Project

[Your project name and one sentence description]

A programmatic SEO platform. Generates thousands of search-optimized pages from structured data. Built to rank, built to scale, built to be defensible.

---

## Stack

- **Framework**: Next.js (App Router) with ISR (Incremental Static Regeneration)
- **Language**: TypeScript
- **Database**: Postgres — primary data store for all page content
- **Cache**: Cloudflare (edge caching), Redis (server-side)
- **Sitemaps**: Static XML files stored on Cloudflare R2 — not served dynamically
- **Hosting**: Vercel (application), Cloudflare R2 (sitemaps and large static assets)
- **Data sources**: [list your data sources — APIs, databases, scrapers, CSV imports]

---

## Architecture

Pages are generated from structured data in Postgres. The rendering layer reads from the database. The data pipeline is separate and writes to the database.

**Two systems, one database**:
1. **Data pipeline** — ingests, cleans, and writes data to Postgres. Runs on a schedule or on demand. Lives in `scripts/` or a separate service.
2. **Web application** — reads from Postgres and renders pages. Never writes data.

**Sitemap generation** runs at build time as a script. Output is static XML uploaded to Cloudflare R2. Never serve sitemaps dynamically — search engines need them to be fast and reliable.

**Schema markup** is generated per page type in dedicated files. It is never written inline in page components. Each page type has its own schema generator.

**SEO signals are first-class**, not afterthoughts. Every page has explicit: title tag, meta description, canonical URL, Open Graph tags, and schema markup.

---

## Folder Structure

```
app/
  [page-type]/
    [slug]/
      page.tsx        # renders the page, imports schema generator
lib/
  data/               # database queries — one file per data domain
  schema/             # schema.org generators — one file per page type
  seo/                # metadata generation, canonical URLs
  db/                 # database client
scripts/
  generate-sitemaps.ts  # builds and uploads XML sitemaps to R2
  [data-pipeline].ts    # data ingestion scripts
public/
```

---

## Naming Rules

- Files: `kebab-case.tsx` / `kebab-case.ts`
- Components: `PascalCase`
- Schema generators: `[page-type]-schema.ts` (e.g. `product-schema.ts`, `location-schema.ts`)
- Database query files: `[domain]-queries.ts` (e.g. `trial-queries.ts`)
- Functions: `camelCase`
- Constants: `UPPER_SNAKE_CASE`

---

## SEO Rules — Follow These on Every Page

- Every page must have a unique, descriptive `<title>` tag — no duplicates
- Every page must have a unique meta description — no duplicates
- Every page must have a canonical URL — self-referencing
- Every page must have Open Graph tags (`og:title`, `og:description`, `og:url`, `og:type`)
- Every page type must have schema markup generated from `lib/schema/`
- Internal links must use descriptive anchor text — no "click here"
- Images must have descriptive `alt` text — no empty alts on content images
- Never block crawlers in `robots.txt` without explicit sign-off

---

## Schema Rules

- Schema markup lives in `lib/schema/` — never inline in page components
- One schema generator file per page type
- Every generator returns valid JSON-LD
- Test schema with Google's Rich Results Test before shipping
- Use `@type` values from schema.org exactly — no custom types

---

## Sitemap Rules

- Sitemaps are static XML files on R2, not dynamic Next.js routes
- The generation script runs at build time or on a schedule — not on each request
- Every page type has its own sitemap file — do not put everything in one file
- Maximum 50,000 URLs per sitemap file
- Submit sitemap index to Google Search Console after deploy
- Never remove a URL from a sitemap without checking if it's indexed first

---

## Data Pipeline Rules

- The web application never writes to the database — read only
- All data ingestion happens in `scripts/`
- Every data source has its own ingestion script
- Validate and clean data before writing — bad data produces bad pages
- Log every run: records processed, records written, errors

---

## Do Not Touch Without Asking

- `robots.txt` — affects what search engines crawl
- `next.config.js` crawler and redirect settings — affects indexing
- Canonical URL generation logic — wrong canonicals cause indexing disasters
- Sitemap generation script — affects crawlability for all pages
- Database schema for core content tables — changing these affects every page

---

## Dependencies

```bash
# Core
npx create-next-app@latest --typescript --app

# Database
npm install prisma @prisma/client
# or
npm install drizzle-orm postgres

# Sitemap generation
npm install @aws-sdk/client-s3  # for R2 upload
npm install fast-xml-parser     # for XML generation

# Validation
npm install zod
```

---

## Checking Your Work

Before shipping any SEO-related change:

- [ ] Page has unique title, meta description, and canonical URL
- [ ] Schema markup validates in Google's Rich Results Test
- [ ] New page type has a sitemap entry
- [ ] No new `noindex` or `nofollow` tags added unintentionally
- [ ] Internal links from related pages added
- [ ] Cloudflare cache rules account for this page type
