.PHONY: sync mcp-status help

sync:
	@./scripts/sync-repos.sh

mcp-status:
	@echo "Checking MCP server status..."
	@claude mcp list

help:
	@echo "Documentation Intelligence Tool - Available Commands:"
	@echo ""
	@echo "  make sync              - Sync all repositories to latest develop branch"
	@echo "  make mcp-status        - Check status of all MCP servers"
	@echo "  make help              - Show this help message"
	@echo ""
	@echo "Setup Instructions:"
	@echo "  1. Authenticate MCP servers:"
	@echo "     claude mcp auth atlassian    # For Jira + Confluence"
	@echo "     claude mcp auth notion"
	@echo "  2. Set SLACK_BOT_TOKEN environment variable"
	@echo "  3. Run: make sync"