# CLAUDE.md — Answer Engine Optimization (AEO)

This file is read automatically by Claude Code at the start of every session.
Do not remove it. Do not summarize it. Follow it exactly.

---

## About This Project

[Your project name and one sentence description]

An AEO-optimized content platform. Structured to be cited by AI answer engines — Claude, Perplexity, ChatGPT, Google AI Overviews — not just ranked in traditional search.

The goal: when someone asks an AI a question your content answers, the AI cites you.

---

## What AEO Schema Engineering Covers

This project focuses on the schema layer — structured data that makes content machine-readable and citation-ready. It does not cover content strategy, editorial decisions, or E-E-A-T signals (those require cross-functional sign-off).

**In scope**:
- FAQ schema — the primary citation driver for AI answer engines
- HowTo schema — procedural content that answer engines surface directly
- Article and NewsArticle schema — authorship and publication signals
- Speakable schema — marks content as answer-engine-friendly
- Entity disambiguation via `sameAs` — linking to Wikidata, Wikipedia, official sources
- Structured `@context` and `@graph` patterns that AI crawlers parse correctly

**Out of scope** (requires editorial/legal sign-off):
- Content tone and structure
- Author credential signals
- Internal linking strategy
- E-E-A-T content decisions

---

## Stack

- **Framework**: [Next.js / Nuxt / Astro / other]
- **Language**: TypeScript
- **Schema format**: JSON-LD (only supported format for AEO — do not use Microdata or RDFa)
- **Validation**: Google Rich Results Test, Schema.org validator

---

## Architecture

Schema markup is generated in dedicated files — never written inline in page components. Each content type has its own schema generator.

Schema is injected into the page `<head>` as a `<script type="application/ld+json">` tag. Next.js: use the `metadata` API or a `<Script>` component. Never render schema in the visible page body.

Entity linking via `sameAs` connects your content to authoritative external sources. This is how AI systems confirm an entity's identity and trustworthiness.

---

## Folder Structure

```
lib/
  schema/
    faq-schema.ts           # FAQ and Q&A schema generator
    howto-schema.ts         # HowTo procedural schema generator
    article-schema.ts       # Article and NewsArticle schema generator
    speakable-schema.ts     # Speakable markup generator
    entity-schema.ts        # Organization, Person, Product entity schemas
    graph-schema.ts         # @graph wrapper for combining multiple schemas
    index.ts                # exports all generators
components/
  SchemaScript.tsx          # renders JSON-LD in <head>
```

---

## Schema Design Rules

**Use JSON-LD only.**
Microdata and RDFa are not supported by most AI crawlers. JSON-LD is the standard. No exceptions.

**Every schema must be valid.**
Test with Google's Rich Results Test and Schema.org validator before shipping.
Invalid schema is ignored by crawlers — it does not degrade gracefully.

**FAQ schema is the highest-priority citation driver.**
AI answer engines frequently pull from FAQ schema to answer direct questions.
Structure: one `FAQPage` with multiple `Question` and `acceptedAnswer` pairs.
Answers must be self-contained — the AI may surface the answer without the surrounding page.

**Speakable schema marks the most citable content.**
Use `SpeakableSpecification` with `cssSelector` to point to the specific page sections
that contain the best, most direct answers. Do not mark entire page bodies as speakable.

**`sameAs` is how AI systems verify entity identity.**
For any Organization, Person, or Product entity:
- Link to the Wikipedia article if one exists
- Link to the Wikidata entry
- Link to official social profiles (LinkedIn for organizations, Twitter/X if active)
- Link to official government or registry entries where applicable

**`@graph` combines multiple schemas cleanly.**
Instead of multiple `<script>` tags, use a single `@graph` array.
This is the pattern AI crawlers prefer and is less likely to cause parsing errors.

---

## Schema Templates

### FAQ Schema
```json
{
  "@context": "https://schema.org",
  "@type": "FAQPage",
  "mainEntity": [
    {
      "@type": "Question",
      "name": "The exact question as a user would ask it",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "A complete, standalone answer. Does not reference 'above' or 'below' — it must make sense on its own."
      }
    }
  ]
}
```

### HowTo Schema
```json
{
  "@context": "https://schema.org",
  "@type": "HowTo",
  "name": "How to [accomplish the task]",
  "description": "A complete description of the outcome",
  "step": [
    {
      "@type": "HowToStep",
      "name": "Step name",
      "text": "Complete instruction for this step. Self-contained."
    }
  ]
}
```

### Article with Entity
```json
{
  "@context": "https://schema.org",
  "@graph": [
    {
      "@type": "Article",
      "headline": "Article title",
      "datePublished": "2024-01-01",
      "dateModified": "2024-06-01",
      "author": {
        "@type": "Person",
        "name": "Author Name",
        "sameAs": [
          "https://en.wikipedia.org/wiki/Author_Name",
          "https://www.wikidata.org/wiki/Q12345"
        ]
      },
      "publisher": {
        "@type": "Organization",
        "name": "Publisher Name",
        "sameAs": [
          "https://en.wikipedia.org/wiki/Publisher_Name",
          "https://www.wikidata.org/wiki/Q67890"
        ]
      }
    }
  ]
}
```

---

## Naming Rules

- Schema generator files: `[type]-schema.ts` (e.g. `faq-schema.ts`, `howto-schema.ts`)
- Generator functions: `generate[Type]Schema` (e.g. `generateFAQSchema`)
- Output type: always `WithContext<Thing>` from `schema-dts` or a typed interface
- Constants: `UPPER_SNAKE_CASE`

---

## Do Not Touch Without Asking

- `sameAs` links — these establish entity identity. Wrong links cause AI systems to associate your entity with the wrong thing.
- Speakable selectors — if the CSS selectors stop matching page content, speakable markup silently breaks.
- `datePublished` values on existing articles — changing publication dates can affect content freshness signals.

---

## Validation Checklist

Before shipping any schema change:

- [ ] Validated in Google Rich Results Test
- [ ] Validated in Schema.org validator
- [ ] FAQ answers are self-contained — no references to "above" or "below"
- [ ] `sameAs` links resolve and point to the correct entities
- [ ] No duplicate `@type` conflicts within a `@graph`
- [ ] JSON is valid (run through a JSON linter)
- [ ] Schema renders in `<head>`, not in the visible page body

---

## Dependencies

```bash
# Schema types (optional but recommended for TypeScript safety)
npm install schema-dts

# Validation (run locally or in CI)
# Use Google Rich Results Test: https://search.google.com/test/rich-results
# Use Schema.org validator: https://validator.schema.org
```
