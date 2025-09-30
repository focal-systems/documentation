# Create Docs

Generates comprehensive documentation by orchestrating multiple specialized agents to gather information from Jira, Confluence, Slack, Notion, and code repositories.

## Usage

```
/create-docs [question]
```

## Arguments

- `question` (mandatory): Documentation question or topic to research

## Description

This command coordinates 6 specialized agents to create thorough documentation:

1. **jira-doc-query** - Queries Jira for relevant tickets, requirements, acceptance criteria, and bug reports
2. **confluence-doc-fetcher** - Retrieves existing documentation pages to provide context and identify gaps
3. **slack-doc-extractor** - Extracts relevant team discussions, technical decisions, and informal specifications from Slack channels
4. **notion-knowledge-retriever** - Retrieves knowledge base articles, architecture notes, RFCs, and design decisions from Notion
5. **code-documentation-scanner** - Scans all three repositories (backend-main, backend-legacy, web-focal-os) for:
   - Function signatures and docstrings
   - API endpoints and route definitions
   - Database models and schemas
   - Implementation details with file:line references
6. **doc-verifier** - Validates the generated documentation for:
   - Markdown formatting consistency
   - Link validity
   - Content completeness
   - Security issues or sensitive information

The process gathers comprehensive information from all sources, synthesizes it into well-structured markdown documentation, and saves the output to the `output/` directory.

## Examples

```bash
# Document a specific feature
/create-docs "How does the ESL integration work?"

# Research API documentation
/create-docs "Document the product recognition API endpoints"

# Investigate system architecture
/create-docs "Explain the checkout system architecture"

# Document bug fixes
/create-docs "Document the authentication timeout issue and its resolution"
```