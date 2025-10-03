# Documentation Intelligence Tool

AI-powered research and documentation assistant that provides Claude Code with comprehensive access to multiple information sources including Jira, Confluence, Slack, Notion, and code repositories.

## Overview

This tool provides Claude Code with access to multiple information sources through specialized agents:
1. Query Jira for tickets, requirements, and bugs
2. Fetch existing documentation from Confluence
3. Extract team discussions from Slack channels
4. Retrieve knowledge base articles from Notion
5. Scan code repositories for implementation details
6. Verify documentation for accuracy and consistency

Use Claude Code interactively to research, document, and analyze your projects with comprehensive access to all your team's knowledge bases.

## Prerequisites

### 1. Repository Setup
The tool monitors three repositories:
- `backend-main/` - Main backend codebase
- `backend-legacy/` - Legacy backend system
- `web-focal-os/` - Web frontend for Focal OS

### 2. MCP Server Configuration

Five MCP (Model Context Protocol) servers must be configured and authenticated.

#### Quick Setup (Recommended)

MCP servers are already configured in `.mcp.json`. To set them up:

```bash
# Optional: Configure Slack if you have a bot token
make mcp-auth SLACK_BOT_TOKEN=xoxb-your-bot-token

# Or without Slack
make mcp-auth
```

Then complete the OAuth flow:
1. Run `claude`
2. Type `/mcp`
3. Follow the OAuth login prompts for Atlassian, Notion, and Figma

#### Manual Setup (Alternative)

If you prefer to set up servers individually:

##### General Authentication Process

For most MCP servers (Atlassian, Notion), follow this process:

1. **Run Claude Code:**
   ```bash
   claude
   ```

2. **Open MCP menu:**
   ```
   /mcp
   ```

3. **Follow the OAuth login prompts** for each server that requires authentication

##### Atlassian (Jira + Confluence)

Already configured in `.mcp.json`. Run `claude` and use `/mcp` to complete OAuth authentication. This covers both Jira and Confluence.

##### Notion

Already configured in `.mcp.json`. Run `claude` and use `/mcp` to complete OAuth authentication.

##### Figma

Already configured in `.mcp.json`. Run `claude` and use `/mcp` to complete OAuth authentication.

##### Slack

**Use the make command for easy setup:**

```bash
make add-mcp-slack SLACK_BOT_TOKEN=xoxb-your-bot-token
```

To create a Slack bot:
1. Go to https://api.slack.com/apps
2. Create a new app
3. Add bot token scopes: `channels:read`, `channels:history`, `chat:write`, `reactions:write`, `users:read`
4. Install app to workspace
5. Copy the Bot User OAuth Token (starts with `xoxb-`)

##### Code Access

Code access is configured via `.claude/settings.json` with `additionalDirectories` pointing to the three repositories.

### 3. Verify Setup
Check that all MCP servers are healthy:
```bash
make mcp-status
```

All servers should show ✓ status. If any show ⚠ or ❌, complete authentication or check configuration.

## Quick Start

### 1. Sync Repositories
```bash
make sync
```

This clones or updates all three repositories to the latest `develop` branch.

### 2. Use Claude Code with Agents
Use Claude Code directly to query information from multiple sources:

```bash
claude
```

Then interact with the specialized agents defined in the `agents/` directory to:
- Query Jira for tickets and requirements
- Fetch documentation from Confluence
- Extract discussions from Slack
- Retrieve knowledge base articles from Notion
- Scan code repositories for implementation details

## Available Commands

```bash
make help              # Show all available commands
make mcp-auth          # Authenticate all MCP servers (optional: SLACK_BOT_TOKEN=...)
make sync              # Sync repositories to latest develop
make mcp-status        # Check MCP server health
make add-mcp-slack     # Configure Slack MCP (requires SLACK_BOT_TOKEN)
```

## Agent System

The tool uses 6 specialized agents:

### 1. Jira Documentation Agent
- Queries Jira for tickets, requirements, and bugs
- Extracts requirements and acceptance criteria
- Links issues and tracks implementation status
- **Config**: `agents/jira-doc-agent.md`

### 2. Confluence Documentation Agent
- Fetches existing documentation pages
- Provides context and identifies gaps
- Links to related documentation
- **Config**: `agents/confluence-doc-agent.md`

### 3. Slack Documentation Agent
- Extracts relevant channel discussions
- Captures technical decisions
- Documents informal specifications
- **Config**: `agents/slack-doc-agent.md`

### 4. Notion Documentation Agent
- Retrieves knowledge base articles
- Accesses architecture notes and specs
- Provides historical context
- **Config**: `agents/notion-doc-agent.md`

### 5. Code Documentation Agent
- Scans all three repositories
- Extracts function signatures and docstrings
- Identifies API endpoints and models
- Provides file/line references
- **Config**: `agents/code-doc-agent.md`

### 6. Verifier Agent
- Validates markdown formatting
- Checks link validity
- Ensures content consistency
- Flags security issues
- **Config**: `agents/verifier-agent.md`

## Directory Structure

```
documentation/
├── .claude/
│   └── settings.json         # Claude Code configuration
├── .mcp.json                 # MCP server configurations
├── agents/                   # Agent definitions
│   ├── jira-doc-agent.md
│   ├── confluence-doc-agent.md
│   ├── slack-doc-agent.md
│   ├── notion-doc-agent.md
│   ├── code-doc-agent.md
│   └── verifier-agent.md
├── scripts/
│   └── sync-repos.sh         # Repository sync script
├── output/                   # Generated documentation
├── backend-main/             # Synced repository
├── backend-legacy/           # Synced repository
├── web-focal-os/             # Synced repository
├── Makefile                  # Command shortcuts
└── README.md                 # This file
```

## Example Usage

Use Claude Code with the specialized agents to:

### Query API Documentation
Ask Claude to search across Jira, Confluence, and code repositories for payment processing API endpoints.

### Research Architecture
Request Claude to gather architecture documentation from Confluence and analyze the codebase for the checkout system implementation.

### Document Features
Have Claude query Jira for feature requirements, Confluence for specs, Slack for team discussions, and the codebase for implementation details of the guest checkout feature.

### Investigate Issues
Ask Claude to search Jira for bug reports, Slack for related discussions, and the codebase for the authentication timeout issue.

## Working with Agents

The specialized agents can help you gather information from:
- **Jira**: Tickets, requirements, and bug reports
- **Confluence**: Existing documentation pages and specifications
- **Slack**: Team discussions, technical decisions, and context
- **Notion**: Knowledge base articles and architecture notes
- **Code Repositories**: Functions, classes, implementations with file/line references
- **Verifier**: Quality checks for markdown formatting, links, and consistency

## Troubleshooting

### MCP Server Not Authenticated
```bash
claude mcp auth <server-name>
```

### Slack Bot Token Missing
```bash
export SLACK_BOT_TOKEN="xoxb-your-token"
# Add to ~/.bashrc or ~/.zshrc for persistence
```

### Repositories Out of Sync
```bash
make sync
```

## Configuration Files

### `.mcp.json`
Configures all MCP servers (Jira, Confluence, Slack, Notion)

### `.claude/settings.json`
Claude Code settings including repository access permissions

### `agents/*.md`
Individual agent configurations defining their capabilities and output formats

### Configuration File
Settings are stored in `.claude/settings.json` and follow the JSON schema standard for Claude Code settings.

### Benefits
- Seamless access to multiple related repositories from a single documentation workspace
- Streamlined file operations with automatic edit acceptance
- Safety guardrails against destructive operations
- Extended context across all project codebases

---

## Complete Guide: Setting Up MCP Servers in Claude Code

### Table of Contents

1. [Atlassian (Jira + Confluence)](#atlassian-jira--confluence)
2. [Notion](#notion)
3. [Slack](#slack)
4. [Complete Configuration File](#complete-configuration-file)

---

### Atlassian (Jira + Confluence)
**Remote MCP Server with OAuth**

#### Step 1: Add the server
```bash
claude mcp add --transport sse atlassian https://mcp.atlassian.com/v1/sse
```

#### Step 2: Authenticate
```bash
claude
/mcp
```
Follow the OAuth link in your browser, log in to Atlassian, and approve permissions.

**Capabilities:**
- Search and read Jira issues
- Create and update Jira tickets
- Access Confluence pages
- Search across both platforms

---

### Notion
**Remote MCP Server with OAuth**

#### Step 1: Add the server
```bash
claude mcp add --transport http notion https://mcp.notion.com/mcp
```

#### Step 2: Authenticate
```bash
/mcp
```
Follow the OAuth prompt to log in to Notion and approve access.

**Capabilities:**
- Search workspace
- Read and update pages
- Manage databases
- Add comments

---

### Slack
**Setup with Bot Token**

#### Step 1: Create Slack App and get Bot Token

1. **Go to:** https://api.slack.com/apps
2. **Click** "Create New App" → "From scratch"
3. **Name your app** (e.g., "Claude MCP Bot")
4. **Select your workspace**
5. **Add Bot Token Scopes:**
   - Go to "OAuth & Permissions"
   - Scroll to "Scopes" → "Bot Token Scopes"
   - Add these scopes:
     ```
     channels:history     - Read messages from public channels
     channels:read        - View basic channel info
     chat:write          - Send messages
     reactions:write     - Add emoji reactions
     users:read          - List workspace users
     ```

6. **Install the app:**
   - Scroll to top → click "Install to Workspace"
   - Approve permissions

7. **Copy Bot Token:**
   - You'll see "Bot User OAuth Token"
   - Starts with `xoxb-...`
   - Copy it!

8. **Find Team ID:**
   - In Slack → click workspace name → "Settings & administration" → "Workspace settings"
   - Or in your Slack App under "Basic Information" → "Team ID" (starts with `T...`)

9. **Find Channel IDs:**
   - Right-click on channel → "View channel details"
   - At the bottom you'll see Channel ID (starts with `C...`)
   - Collect IDs for all channels you want to access

#### Step 2: Add to Claude Code
```bash
claude mcp add slack \
  --env SLACK_BOT_TOKEN="xoxb-7565575990-9607457910978-aaaaa" \
  --env SLACK_TEAM_ID="T07GMGXV4" \
  --env SLACK_CHANNEL_IDS="CHXT8FTGQ,CGV9RUFFH" \
  -- npx -y @modelcontextprotocol/server-slack
```

#### Step 3: Verify installation
```bash
claude mcp list
```
You should see `slack` in the list.

#### Step 4: Test connection
```bash
claude
/mcp
```
You should see `slack: connected`

**Capabilities:**
- Read messages from channels
- Post messages to channels
- Add reactions
- List channels and users
- Search messages