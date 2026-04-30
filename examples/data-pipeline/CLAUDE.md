# CLAUDE.md — Data Pipeline

This file is read automatically by Claude Code at the start of every session.
Do not remove it. Do not summarize it. Follow it exactly.

---

## About This Project

[Your project name and one sentence description]

A data pipeline. Ingests data from external sources, transforms and cleans it, and loads it into a destination for use by other systems.

---

## Stack

- **Language**: [Python / TypeScript / Go]
- **Orchestration**: [Airflow / Prefect / Dagster / cron / none]
- **Database**: [Postgres / BigQuery / Redshift / DuckDB / other]
- **Storage**: [S3 / GCS / local filesystem]
- **Transform**: [dbt / raw SQL / pandas / polars]
- **Hosting**: [AWS / GCP / self-hosted]

---

## Architecture

Every pipeline has three stages and nothing else:

1. **Extract** — pull raw data from the source. No transformation here. Store raw data as-is.
2. **Transform** — clean, validate, and reshape. No I/O here. Pure functions in, pure functions out.
3. **Load** — write to the destination. No transformation here.

Keeping these stages separate makes pipelines testable, debuggable, and restartable.

**Idempotency is required.** Every pipeline must produce the same result when run multiple times on the same data. Use upserts, not inserts. Track what's been processed.

**Failures are expected.** External APIs go down. Data is malformed. Networks time out.
Every stage handles failure explicitly — log what failed, skip or retry, never silently corrupt.

---

## Folder Structure

```
src/
  extract/          # one file per data source
  transform/        # one file per data domain — pure functions
  load/             # one file per destination
  utils/
    db.py           # database connection and helpers
    http.py         # HTTP client with retry logic
    logging.py      # structured logging
  pipeline.py       # orchestrates extract → transform → load
scripts/
  run.py            # entry point — runs the full pipeline or a specific stage
tests/
  test_transform/   # unit tests for transformation logic
  test_pipeline/    # integration tests
.env.example
```

---

## Naming Rules

- Files: `snake_case.py` (Python) / `kebab-case.ts` (TypeScript)
- Functions: `snake_case` (Python) / `camelCase` (TypeScript)
- Classes: `PascalCase`
- Constants: `UPPER_SNAKE_CASE`
- Pipeline stages: `extract_[source]`, `transform_[domain]`, `load_[destination]`

---

## Code Rules

- Extract functions return raw data unchanged — no cleaning, no filtering
- Transform functions are pure — same input always produces same output, no side effects
- Load functions use upserts — running twice must not duplicate data
- Every pipeline run is logged: source, records extracted, records loaded, errors, duration
- Failed records are logged with enough context to debug — never swallowed silently
- All database connections go through `utils/db` — no direct connection strings elsewhere
- All HTTP calls go through `utils/http` with retry logic and timeout

---

## Data Quality Rules

- Validate data after extraction before transformation — catch bad data early
- Log schema mismatches — if the source changes its structure, you need to know
- Never write `NULL` to a column that should always have a value — fail explicitly
- Test transformation logic with real examples of messy data, not just clean examples

---

## Do Not Touch Without Asking

- Production database connection strings and credentials
- Load functions that write to tables used by other teams or systems
- Any function that deletes or overwrites historical data

---

## Environment Variables

```
# Database
DATABASE_URL=           # destination database connection string

# Sources (add one block per source)
SOURCE_API_KEY=         # API key for [source name]
SOURCE_API_BASE_URL=    # Base URL for [source name] API

# Pipeline behavior
BATCH_SIZE=1000         # records per batch (default: 1000)
MAX_RETRIES=3           # HTTP retry attempts (default: 3)
LOG_LEVEL=INFO          # DEBUG / INFO / WARNING / ERROR
```

---

## Running the Pipeline

```bash
# Full pipeline
python scripts/run.py

# Single stage
python scripts/run.py --stage extract
python scripts/run.py --stage transform
python scripts/run.py --stage load

# Specific source
python scripts/run.py --source [source-name]

# Dry run (extract and transform only, no writes)
python scripts/run.py --dry-run
```

---

## Checklist Before Shipping a New Pipeline

- [ ] Runs to completion without errors on a real data sample
- [ ] Running twice produces the same result (idempotency verified)
- [ ] Failures are logged with enough detail to debug
- [ ] Transform logic has unit tests with messy data examples
- [ ] `.env.example` updated with any new variables
- [ ] Dry run mode works correctly
