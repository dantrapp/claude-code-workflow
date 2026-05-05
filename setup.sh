#!/bin/bash

# claude-code-workflow setup
# Asks 8 questions. Generates a complete CLAUDE.md for your project.

set -e

BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
GRAY='\033[0;37m'
NC='\033[0m'

if [ -n "$TERM" ]; then
  clear || true
fi
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}  claude-code-workflow / setup${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${GRAY}  8 questions. ~3 minutes. Custom CLAUDE.md ready to drop in your repo.${NC}"
echo ""

# Q1
echo -e "${YELLOW}  1/8  Project name and what it does${NC}"
echo -e "${GRAY}       Example: Acme — a REST API for project management${NC}"
echo -e "${GRAY}       Example: StorePulse — a Shopify analytics dashboard${NC}"
read -p "       > " Q_PROJECT
echo ""

# Q2
echo -e "${YELLOW}  2/8  Your stack${NC}"
echo -e "${GRAY}       List the main pieces: language, framework, database, hosting${NC}"
echo -e "${GRAY}       Example: TypeScript, Node.js, Postgres, deployed on Vercel${NC}"
echo -e "${GRAY}       Example: Python, FastAPI, Postgres, Redis, deployed on AWS${NC}"
read -p "       > " Q_STACK
echo ""

# Q3
echo -e "${YELLOW}  3/8  How is your project structured?${NC}"
echo -e "${GRAY}       Describe in one sentence how the pieces connect${NC}"
echo -e "${GRAY}       Example: Route handlers call services, services query the database${NC}"
echo -e "${GRAY}       Example: Pages are generated from a database, schema lives in separate files${NC}"
echo -e "${GRAY}       Example: Each agent has one job, data agents and LLM agents are separate${NC}"
read -p "       > " Q_ARCH
echo ""

# Q4
echo -e "${YELLOW}  4/8  External services and integrations${NC}"
echo -e "${GRAY}       Example: Stripe, SendGrid, Twilio, OpenAI${NC}"
echo -e "${GRAY}       Example: AWS S3, HubSpot, Slack${NC}"
echo -e "${GRAY}       Example: None yet${NC}"
read -p "       > " Q_INTEGRATIONS
echo ""

# Q5
echo -e "${YELLOW}  5/8  What should never be changed without a human reviewing it first?${NC}"
echo -e "${GRAY}       Example: Payment logic, database migrations, auth middleware${NC}"
echo -e "${GRAY}       Example: Sitemap generation, robots.txt, canonical URL logic${NC}"
echo -e "${GRAY}       Example: Not sure yet${NC}"
read -p "       > " Q_NOTOUCH
echo ""

# Q6
echo -e "${YELLOW}  6/8  How do you run tests?${NC}"
echo -e "${GRAY}       Example: npm test${NC}"
echo -e "${GRAY}       Example: pytest${NC}"
echo -e "${GRAY}       Example: go test ./...${NC}"
echo -e "${GRAY}       Example: No tests yet${NC}"
read -p "       > " Q_TESTS
echo ""

# Q7
echo -e "${YELLOW}  7/8  Paste your folder structure (or press Enter to skip)${NC}"
echo -e "${GRAY}       Tip: run 'tree -L 2 -d' in your project to get it${NC}"
echo -e "${GRAY}       Even a rough version helps Claude navigate the codebase${NC}"
echo -e "${GRAY}       Press Enter to skip — you can fill it in later${NC}"
echo -e "${GRAY}       (Paste your structure, then press Enter on an empty line to finish)${NC}"
Q_FOLDERS=""
while IFS= read -r line; do
  [ -z "$line" ] && break
  Q_FOLDERS="${Q_FOLDERS}${line}
"
done
echo ""

# Q8
echo -e "${YELLOW}  8/8  Solo or team?${NC}"
echo -e "${GRAY}       1) Solo builder${NC}"
echo -e "${GRAY}       2) Small team (2–5 people)${NC}"
echo -e "${GRAY}       3) Larger team (5+ people)${NC}"
read -p "       > " Q_TEAM
echo ""

# Handle existing CLAUDE.md
OUTPUT="CLAUDE.md"
if [ -f "$OUTPUT" ]; then
  OUTPUT="CLAUDE.generated.md"
fi

# Set team context
case $Q_TEAM in
  2) TEAM_CONTEXT="Small team. Every engineer's Claude Code output should look consistent. CLAUDE.md is the shared standard — update it when patterns change." ;;
  3) TEAM_CONTEXT="Larger team. Consistency is critical at this scale. Update CLAUDE.md through a PR, not unilaterally. Consider adding AGENTS.md to define agentic workflow boundaries." ;;
  *) TEAM_CONTEXT="Solo builder. You are both the engineer and the reviewer. The spec and PR templates still matter — future you will read them." ;;
esac

# Set test command
if [ -z "$Q_TESTS" ] || [ "$Q_TESTS" = "No tests yet" ] || [ "$Q_TESTS" = "none" ]; then
  TEST_LINE="- **How to run tests**: [not configured yet — add your test command here]"
else
  TEST_LINE="- **How to run tests**: \`$Q_TESTS\`"
fi

# Set folder structure
if [ -z "$Q_FOLDERS" ]; then
  FOLDER_BLOCK='[Add your actual folder structure here — run "tree -L 2 -d" in your project to get it]'
else
  FOLDER_BLOCK="$Q_FOLDERS"
fi

# Write CLAUDE.md
cat > "$OUTPUT" << CLAUDEEOF
# CLAUDE.md

This file is read automatically by Claude Code at the start of every session.
Do not remove it. Do not summarize it. Follow it exactly.

---

## About This Project

$Q_PROJECT

$TEAM_CONTEXT

---

## Stack

$Q_STACK

**External services**: $Q_INTEGRATIONS

---

## Architecture

$Q_ARCH

### Principles to follow in every task

- Every function does one thing. If the name includes "and", split it into two functions.
- No business logic in route handlers or controllers — that belongs in a service or module layer.
- All calls to external services go through a dedicated wrapper that handles errors and logs failures.
- Never put secrets, API keys, or credentials in code. Use environment variables.
- No debug logging left in production code.
- Prefer explicit code over clever code. The next person reading this should understand it immediately.

---

## Folder Structure

\`\`\`
$FOLDER_BLOCK
\`\`\`

---

## Naming Rules

- Files: kebab-case
- Functions: camelCase
- Classes and types: PascalCase
- Constants: UPPER_SNAKE_CASE
- Database tables: snake_case, plural

[Update these to match your actual conventions if different]

---

## Do Not Touch Without Asking

$Q_NOTOUCH

Always stop and flag these for human review before making any changes.

---

## Tests

$TEST_LINE
- **What requires a test**: everything new gets a test. No exceptions.

---

## Environment Variables

- Never put real values in code or commit them to version control
- Every variable must be listed in \`.env.example\` with a description but no real value
- Adding a new variable? Add it to \`.env.example\` in the same change.

---

## Every PR Must Include

1. What changed and why
2. How to test it
3. What was deliberately left out

Use PR_TEMPLATE.md to generate the description automatically.

---

## When You Are Not Sure

- Say what you know and what you don't
- Describe options and tradeoffs instead of picking one silently
- Flag anything touching [your critical areas] before changing it
- Ask before refactoring something that already works
CLAUDEEOF

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}  Done. $OUTPUT is ready.${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "  Next steps:"
echo ""
echo "  1. Open $OUTPUT"
echo "  2. Update the naming rules if yours are different"
echo "  3. Copy it to your project root"
echo "  4. Commit it — Claude Code reads it automatically from that point on"
echo ""
echo "  Optional but recommended:"
echo "  - Copy SPEC_TEMPLATE.md and PR_TEMPLATE.md to your project"
echo "  - Read WORKFLOW.md once — the whole pattern is one page"
echo "  - For agentic workflows: copy AGENTS.md and define your boundaries"
echo ""
