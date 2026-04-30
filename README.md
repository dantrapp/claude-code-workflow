# claude-code-workflow

Claude Code writes good code. It writes *consistent* code when it knows the rules.

This is an open source workflow system for anyone building with Claude Code — solo builders, small teams, and engineering organizations. Drop it into any project, run the setup script, and get a production-grade AI-assisted development workflow in under 5 minutes.

Works with any language. Any stack. Any project type.

---

## What's included

**`CLAUDE.md`** — your codebase's system prompt. Claude Code reads it automatically at the start of every session. Stack, conventions, architecture, what not to touch. The guardrail that makes every Claude Code session consistent.

**`AGENTS.md`** — the agentic workflow layer. Tells Claude what it can do autonomously, what always needs a human decision, and how to handle uncertainty. For teams moving toward agentic engineering workflows.

**`SPEC_TEMPLATE.md`** — paste a ticket or idea, get a structured implementation plan before a single line of code gets written. Eliminates the most expensive mistake in software: building the wrong thing correctly.

**`PR_TEMPLATE.md`** — paste what you built, get a PR description that explains what changed, what was left out, and how to test it. Makes every decision permanent and every review faster.

**`WORKFLOW.md`** — one page. The full pattern from idea to merged code.

**`setup.sh`** — run it first. Asks 8 questions about your project, generates a custom `CLAUDE.md` ready to use.

---

## Quickstart

```bash
git clone https://github.com/YOUR_USERNAME/claude-code-workflow.git
cd claude-code-workflow
chmod +x setup.sh
./setup.sh
```

Copy the generated `CLAUDE.md` into your project root. Claude Code picks it up automatically. Done.

---

## How it works

```
Idea or ticket
      ↓
SPEC_TEMPLATE.md  →  structured plan before any code
      ↓
Claude Code builds  (CLAUDE.md runs automatically)
      ↓
PR_TEMPLATE.md  →  PR description that actually explains the work
      ↓
Review + test  →  merge
```

---

## Examples

Reference configurations for common project types. Copy the one closest to your project and tune it.

| Example | Use it if you're building |
|---|---|
| [`mcp-server`](examples/mcp-server/) | A Claude tool or MCP server for agentic workflows |
| [`rest-api`](examples/rest-api/) | A backend API — any language, any framework |
| [`nextjs-app`](examples/nextjs-app/) | A full-stack Next.js application |
| [`pseo`](examples/pseo/) | A programmatic SEO content platform |
| [`aeo`](examples/aeo/) | Answer Engine Optimization — schema for AI citation |
| [`data-pipeline`](examples/data-pipeline/) | A data ingestion, transformation, and storage pipeline |
| [`conversational-ai`](examples/conversational-ai/) | A multi-channel AI agent platform |
| [`solo-builder`](examples/solo-builder/) | The minimal setup — one person, one project, no overhead |

---

## Who this is for

**Solo builders** — this is built for you first. Claude Code sessions are inconsistent without a CLAUDE.md. One session produces great code. The next session ignores the conventions from the last one. This fixes that. You don't need a team to benefit from structure. Run `setup.sh`, answer 8 questions, and your Claude Code sessions are consistent from that point forward. See [`examples/solo-builder/`](examples/solo-builder/) for the minimal setup.

**Small teams** — everyone's Claude Code output looks slightly different without shared rules. CLAUDE.md is the shared standard. One file, every session, every engineer.

**Staff engineers** — the AGENTS.md layer is where this gets interesting. Define exactly what Claude can decide autonomously and what escalates to a human. That's the foundation of a real agentic engineering workflow.

---

## License

MIT. Use it, fork it, tune it, ship it.
