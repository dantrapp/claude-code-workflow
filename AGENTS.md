# AGENTS.md

This file defines how Claude behaves when operating with more autonomy — making decisions across multiple steps, using tools, and working through tasks without a human approving every action.

Read this alongside CLAUDE.md. CLAUDE.md describes the codebase. This file describes how to work inside it as an agent.

---

## What Claude Can Do Without Asking

These are safe to execute autonomously. No human approval needed.

- Read any file in the codebase
- Search the codebase for patterns, references, or usage
- Run tests and report results
- Generate a spec using SPEC_TEMPLATE.md
- Generate a PR description using PR_TEMPLATE.md
- Create new files that follow existing conventions
- Write or update documentation
- Refactor code inside a single file when the behavior does not change
- Install packages that are already used elsewhere in the project

---

## Always Stop and Ask a Human

These require explicit approval before proceeding. Do not assume. Do not guess. Stop and ask.

- Deleting any file
- Changing the database schema
- Modifying authentication or authorization logic
- Changing anything that touches payments or billing
- Modifying environment variable names or structure
- Changing configuration that affects production behavior
- Making a request to an external API that writes, updates, or deletes data
- Anything in the "Do Not Touch Without Asking" section of CLAUDE.md

When in doubt, stop and ask. A wrong assumption here is more expensive than the interruption.

---

## How to Handle Uncertainty

When the right approach is not clear:

1. Say what you know and what you don't
2. Describe the options and what each one costs
3. Make a recommendation if you have one — but label it as a recommendation, not a decision
4. Wait for direction before proceeding

Do not pick an approach and build it silently. Do not fill uncertainty with assumptions.

---

## How to Handle Errors

When something fails:

1. Stop. Do not retry blindly.
2. Report exactly what failed and what the error says
3. Describe what you were trying to do when it failed
4. Suggest a fix if the cause is clear — but wait for approval before applying it

---

## Tool Use

These are the default tool policies for Claude Code. Adjust them to match your project.

- `read_file` — use freely on any file in the codebase
- `write_file` — use for new files and safe edits. Never use on files listed in "Do Not Touch Without Asking."
- `run_command` — use for test runners (`npm test`, `pytest`, `go test`), build commands, and linters only. Never use for destructive operations (`rm`, `drop`, `truncate`, `git push --force`)
- `web_search` — use to look up documentation and API references. Do not use search results to make architectural decisions — flag those for a human
- `edit_file` — use for targeted changes to existing files. Always verify the edit is within scope before applying

---

## Agentic Task Checklist

Before starting a multi-step task:

- [ ] Is there a spec? If not, generate one with SPEC_TEMPLATE.md first.
- [ ] Are there any steps that require human approval? Flag them before starting.
- [ ] Are there any files in the "Do Not Touch" list involved? Flag them.
- [ ] Is the scope clear enough to complete without guessing? If not, ask.

---

## Escalation

If you reach a point mid-task where you need human input:

- Stop where you are
- Summarize what you've done so far
- Describe exactly what decision or information you need
- Wait

Do not continue past an uncertainty by making assumptions. The cost of getting it wrong mid-task is higher than the cost of pausing.

---

## For Solo Builders

You are both the agent and the human. This file still matters.

It forces you to be explicit about what decisions require you to stop and think versus what can run on autopilot. That distinction is valuable even when there's nobody else in the room.
