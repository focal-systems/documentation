# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is a **Documentation Intelligence Tool** that provides AI-powered access to multiple information sources for
comprehensive research and documentation. The tool integrates with Jira, Confluence, Slack, Notion, and three code
repositories to enable thorough documentation workflows.

## Quick Start Commands

```bash
# Sync all repositories to latest develop branch
make sync

# Check MCP server health status
make mcp-status

# Show all available commands
make help
```

## Repository Structure

This repository monitors three synced codebases:

- `backend-main/` - Main Python backend (FastAPI, pytest)
- `backend-legacy/` - Legacy Python backend
- `web-focal-os/` - TypeScript/React frontend (Nx monorepo with apps and shared libraries)

Each synced repository has its own `CLAUDE.md` with specific development guidelines.

## Working Across Repositories

When working with code in the synced repositories:

1. **Backend-main**: Python FastAPI services
2. **Backend-legacy**: Legacy Python services
3. **Web-focal-os**: TypeScript/React Nx monorepo

## MCP Server Integration

Five MCP servers provide access to external data sources:

### 1. Atlassian (Jira + Confluence)

```bash
claude mcp auth atlassian
```

- Query Jira tickets, requirements, bugs
- Fetch Confluence documentation pages
- Search across both platforms

### 2. Slack

Requires `SLACK_BOT_TOKEN` environment variable:

```bash
export SLACK_BOT_TOKEN="xoxb-your-token"
```

- Extract team discussions from channels
- Capture technical decisions and context

### 3. Notion

```bash
claude mcp auth notion
```

- Retrieve knowledge base articles
- Access architecture notes and RFCs

### 4. Code Access

Configured via `.claude/settings.json` with `additionalDirectories` pointing to the three repositories.

### 5. Verification

All MCP servers should show ✓ when running `make mcp-status`.

## Specialized Agents

The tool defines specialized agents for different research tasks. These agents are automatically invoked by Claude Code
based on task requirements:

- **jira-doc-query**: Query Jira for tickets, requirements, bugs
- **confluence-doc-fetcher**: Fetch existing documentation from Confluence
- **slack-doc-extractor**: Extract team discussions from Slack
- **notion-knowledge-retriever**: Retrieve knowledge base articles from Notion
- **code-documentation-scanner**: Scan all three repositories for implementation details
- **doc-verifier**: Validate documentation quality and consistency

## Common Workflows

### Research API Documentation

Use agents to search across Jira, Confluence, and code repositories for specific API endpoints, gathering requirements,
specs, and implementation details.

### Document Features

Combine Jira requirements, Confluence specs, Slack discussions, and codebase implementation to create comprehensive
feature documentation.

### Investigate Issues

Search Jira for bug reports, Slack for related discussions, and repositories for the problematic code sections.

## Output Directory

Generated documentation should be placed in `output/` directory.

## Important Notes

- Repository sync pulls from `develop` branch by default
- All three repositories have their own CLAUDE.md files with detailed coding guidelines
- When making code changes, follow the specific repository's style guide
- MCP servers must be authenticated before use
- Code access is read-only through additional directories configuration