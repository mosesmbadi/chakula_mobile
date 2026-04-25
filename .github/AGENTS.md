---
name: chakula-agents
---

# Chakula Mobile - Custom Agents

This file documents specialized agents for common Chakula Mobile workflows.

## Available Agents

### Explore
Fast read-only codebase exploration and Q&A subagent. Use this to:
- Understand how a feature works
- Find where something is implemented
- Validate architectural patterns
- Review code organization

No file modifications—just analysis and answers.

**Trigger**: Use when you need to understand existing code before making changes.

---

## Future Agents (Optional)

Consider adding specialized agents for:

### `flutter-migration`
For upgrading Flutter/Dart versions, migrating dependencies, or handling breaking changes.

### `feature-development`
For building complete features from spec to implementation, with tool restrictions to maintain consistency.

### `api-integration`
For adding new API endpoints, repositories, and providers following the HTTP client pattern.

### `performance-profiling`
For debugging performance issues, analyzing frame rates, and optimizing widget rebuilds.

---

## Agent Usage

To invoke an agent from VS Code Copilot Chat:
1. Type `@Explore` in the chat input
2. Describe what you want to explore (thoroughness: quick/medium/thorough)
3. The agent analyzes and returns findings

See the main `copilot-instructions.md` for workspace-level guidance that applies to all agents.
