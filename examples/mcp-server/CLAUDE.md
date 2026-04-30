# CLAUDE.md — MCP Server

This file is read automatically by Claude Code at the start of every session.
Do not remove it. Do not summarize it. Follow it exactly.

---

## About This Project

An MCP (Model Context Protocol) server. Exposes tools that Claude and other AI agents can call during a conversation. Published as an npm package.

MCP servers are the building blocks of agentic workflows — they give AI models the ability to take real actions: read files, call APIs, query databases, trigger automations.

---

## Stack

- **Language**: TypeScript
- **Runtime**: Node.js
- **Protocol**: MCP (Model Context Protocol) via `@anthropic-ai/sdk` or `@modelcontextprotocol/sdk`
- **Published to**: npm
- **Entry point**: `src/index.ts`

---

## Architecture

Each tool is a self-contained function with:
- A name (what Claude calls it)
- A description (how Claude decides when to use it)
- An input schema (what parameters it accepts, validated with Zod)
- A handler (what it actually does)

Tools are registered in `src/index.ts`. Implementation lives in `src/tools/`. One file per tool.

The description is as important as the implementation. If Claude doesn't understand when to use a tool, it won't use it correctly. Write descriptions for Claude, not for humans.

---

## Folder Structure

```
src/
  index.ts          # server entry point, tool registration
  tools/            # one file per tool
    [tool-name].ts
  utils/            # shared helpers (HTTP clients, formatters, error handlers)
  types.ts          # shared types and interfaces
tests/
  tools/            # one test file per tool
.env.example        # all required environment variables documented
package.json
tsconfig.json
README.md           # how to install, configure, and use this server
```

---

## Naming Rules

- Files: `kebab-case.ts`
- Tool names: `snake_case` (MCP convention — what Claude sees)
- Functions: `camelCase`
- Types and interfaces: `PascalCase`
- Constants: `UPPER_SNAKE_CASE`
- Tool files: match the tool name exactly — `search_repos` lives in `search-repos.ts`

---

## Tool Design Rules

**Descriptions must be written for Claude, not humans.**
Claude reads the description to decide when and how to use the tool.
Be explicit about: what the tool does, when to use it, what the output looks like, and any important limits.

Bad: `"Search GitHub"`
Good: `"Search GitHub repositories by keyword. Returns repo name, description, stars, and URL. Use this when the user wants to find a repository by topic or name. Limit: 10 results per call."`

**Input schemas must be explicit.**
Use Zod to validate every input. Every field needs a description. Optional fields need a default or a clear note about what happens when they're omitted.

**Every tool must handle failure gracefully.**
External APIs fail. Rate limits get hit. Credentials expire.
Return a clear error message rather than throwing. Claude should be able to tell the user what went wrong.

**Tools must be idempotent where possible.**
Calling the same tool twice with the same inputs should produce the same result.
If a tool has side effects (writes, deletes, sends), document them explicitly in the description.

---

## Code Rules

- TypeScript strict mode. No `any`.
- Every tool has a unit test that covers the happy path and at least one failure case.
- All HTTP calls go through a wrapper in `src/utils/` with error handling and timeout.
- No secrets in code. API keys and credentials go in environment variables.
- No `console.log` in production. Use `console.error` for errors only — MCP servers communicate via stdout, so console output can break the protocol.

---

## Do Not Touch Without Asking

- `src/index.ts` tool registration — adding tools is fine, but changing how the server initializes can break all connected clients
- Published tool names and input schema field names — these are breaking changes for anyone already using the server

---

## Publishing Checklist

Before publishing a new version to npm:

- [ ] All tools have tests
- [ ] README documents every tool with an example
- [ ] `.env.example` lists every required variable
- [ ] Version bumped in `package.json` (patch for fixes, minor for new tools, major for breaking changes)
- [ ] `npm run build` passes with no errors
- [ ] Tested locally with Claude Desktop or an MCP client
- [ ] CHANGELOG updated

---

## Testing Locally

Connect to Claude Desktop by adding to your config:

```json
{
  "mcpServers": {
    "your-server-name": {
      "command": "node",
      "args": ["/absolute/path/to/your/build/index.js"],
      "env": {
        "YOUR_API_KEY": "your-key-here"
      }
    }
  }
}
```

Restart Claude Desktop after config changes.

---

## Environment Variables

Document every variable in `.env.example`:

```
# Required
YOUR_API_KEY=        # API key for [service name] — get one at [URL]

# Optional
TIMEOUT_MS=5000      # Request timeout in milliseconds (default: 5000)
MAX_RESULTS=10       # Maximum results per tool call (default: 10)
```
