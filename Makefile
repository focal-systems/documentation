.PHONY: sync mcp-status add-mcp-slack mcp-auth help

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

mcp-auth:
	@echo "MCP Server Authentication Setup"
	@echo "================================"
	@echo ""
	@echo "✓ MCP servers are already configured in .mcp.json:"
	@echo "  • Atlassian (Jira + Confluence)"
	@echo "  • Notion"
	@echo "  • Figma"
	@echo ""
	@if [ -n "$(SLACK_BOT_TOKEN)" ]; then \
		echo "Configuring Slack with provided token..."; \
		claude mcp add slack \
			--env SLACK_BOT_TOKEN="$(SLACK_BOT_TOKEN)" \
			--env SLACK_TEAM_ID="T07GMGXV4" \
			--env SLACK_CHANNEL_IDS="CHXT8FTGQ,CGV9RUFFH" \
			-- npx -y @modelcontextprotocol/server-slack; \
		echo "✓ Slack configured"; \
		echo ""; \
	else \
		echo "⚠ Slack not configured (SLACK_BOT_TOKEN not provided)"; \
		echo "  To configure Slack later, run:"; \
		echo "  make add-mcp-slack SLACK_BOT_TOKEN=xoxb-your-token"; \
		echo ""; \
	fi
	@echo "NEXT STEPS - Complete OAuth Authentication:"
	@echo "================================"
	@echo "1. Run: claude"
	@echo "2. Type: /mcp"
	@echo "3. Follow the OAuth login prompts for:"
	@echo "   • Atlassian (Jira + Confluence)"
	@echo "   • Notion"
	@echo "   • Figma"
	@echo ""
	@echo "After authentication, verify with: make mcp-status"

help:
	@echo "Documentation Intelligence Tool - Available Commands:"
	@echo ""
	@echo "  make sync              - Sync all repositories to latest develop branch"
	@echo "  make mcp-status        - Check status of all MCP servers"
	@echo "  make mcp-auth          - Authenticate all MCP servers (optional: SLACK_BOT_TOKEN=...)"
	@echo "  make add-mcp-slack     - Configure Slack MCP server (requires SLACK_BOT_TOKEN)"
	@echo "  make help              - Show this help message"
	@echo ""
	@echo "Quick Setup:"
	@echo "  1. Authenticate all MCP servers:"
	@echo "     make mcp-auth SLACK_BOT_TOKEN=xoxb-your-token"
	@echo "  2. Complete OAuth in Claude:"
	@echo "     claude → /mcp → follow prompts"
	@echo "  3. Sync repositories:"
	@echo "     make sync"
	@echo "  4. Verify setup:"
	@echo "     make mcp-status"