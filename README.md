# Nexus Intelligence

Enterprise Content Intelligence Platform â€” an open implementation
of content federation, context assembly, and agentic AI.

## What This Is

Nexus Intelligence is a full enterprise intelligence platform built
in Python, implementing the architectural patterns of systems like
Hyland's Content Innovation Cloud:

- **Content Federation Service** â€” connect any data source, no migration
- **Enterprise Context Engine** â€” knowledge graph, dual indexing, context assembly
- **Document Intelligence Service** â€” IDP, extraction, classification
- **Agent Mesh** â€” multi-agent ORDER loop orchestration
- **Governance Service** â€” audit trail, guard rails, observability
- **Human in the Loop** â€” review queue, override capture, learning signals
- **API Gateway** â€” single entry point, auth, routing
- **Dashboard UI** â€” caseworker interface, admin panel, analytics

## Architecture

Data Sources â†’ Federation â†’ Context Engine â†’ Agent Mesh â†’ UI
â†‘                  â”‚
â””â”€â”€ Learning â”€â”€â”€â”€â”€â”€â”€â”˜

## Quick Start

```bash
# Start infrastructure
make infra

# Load seed data
make seed

# Run federation service
make run-federation

# Run tests
make test-federation
```

## Build Status

| Service | Status |
|---|---|
| Federation | í´¨ In Progress |
| Context Engine | í³‹ Planned |
| Document Intel | í³‹ Planned |
| Agent Mesh | í³‹ Planned |
| Governance | í³‹ Planned |
| HITL | í³‹ Planned |
| Gateway | í³‹ Planned |
| Dashboard | í³‹ Planned |

## Tech Stack

- **Language**: Python 3.12
- **API**: FastAPI
- **Database**: PostgreSQL 16 + pgvector
- **Cache**: Redis 7
- **Agent Framework**: LangGraph
- **Protocol**: MCP (Model Context Protocol)
- **UI**: Next.js + TypeScript
