.PHONY: sync mcp-status add-mcp-slack help

sync:
	@./scripts/sync-repos.sh

mcp-status:
	@echo "Checking MCP server status..."
	@claude mcp list

add-mcp-slack:
	@if [ -z "$(SLACK_BOT_TOKEN)" ]; then \
		echo "Error: SLACK_BOT_TOKEN is required"; \
		echo "Usage: make add-mcp-slack SLACK_BOT_TOKEN=xoxb-your-token"; \
		exit 1; \
	fi
	@claude mcp add slack \
		--env SLACK_BOT_TOKEN="$(SLACK_BOT_TOKEN)" \
		--env SLACK_TEAM_ID="T07GMGXV4" \
		--env SLACK_CHANNEL_IDS="CHXT8FTGQ,CGV9RUFFH" \
		-- npx -y @modelcontextprotocol/server-slack

help:
	@echo "Documentation Intelligence Tool - Available Commands:"
	@echo ""
	@echo "  make sync              - Sync all repositories to latest develop branch"
	@echo "  make mcp-status        - Check status of all MCP servers"
	@echo "  make add-mcp-slack     - Configure Slack MCP server (requires SLACK_BOT_TOKEN)"
	@echo "  make help              - Show this help message"
	@echo ""
	@echo "Setup Instructions:"
	@echo "  1. Authenticate MCP servers:"
	@echo "     claude mcp auth atlassian    # For Jira + Confluence"
	@echo "     claude mcp auth notion"
	@echo "  2. Configure Slack:"
	@echo "     make add-mcp-slack SLACK_BOT_TOKEN=xoxb-your-token"
	@echo "  3. Run: make sync"