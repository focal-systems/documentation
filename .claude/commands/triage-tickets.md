# Triage Tickets

Triages Jira tickets based on multiple sources of information (Jira, Confluence, Notion) and
source code repositories, all available via MCP.

## Usage

```
/triage-tickets [tickets]
```

## Arguments

- `tickets` (mandatory): List of Jira ticket URLs to triage, separated by commas.

## Description

This command uses a separate instance of **ticket-triager** agent to triage each Jira ticket separately, 
ensuring they are in the right format and have all the comprehensive information within them. 

## Examples

```bash
# Triage a single ticket
/triage-tickets "https://focalsystems.atlassian.net/browse/BIF-2939"

# Triage multiple tickets
/triage-tickets "https://focalsystems.atlassian.net/browse/BIF-2939, https://focalsystems.atlassian.net/browse/BIF-2940"
```