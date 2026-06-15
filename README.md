# Nexus Intelligence

Enterprise Content Intelligence Platform — an open implementation
of content federation, context assembly, and agentic AI.

## What This Is

Nexus Intelligence is an enterprise-grade intelligence platform
that federates data from any source, builds institutional context,
and powers autonomous AI agents — without moving or migrating data.

Built for organizations that need:
- AI that reasons with institutional memory, not just retrieved documents
- Data that stays where it is, accessed not copied
- Agents that learn from every human decision
- Full auditability of every AI action

## Architecture

Data Sources → Federation → Context Engine → Agent Mesh → UI

↑                                           │

└── Learning ───────┘

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
| Federation | 🔨 In Progress |
| Context Engine | 📋 Planned |
| Document Intel | 📋 Planned |
| Agent Mesh | 📋 Planned |
| Governance | 📋 Planned |
| HITL | 📋 Planned |
| Gateway | 📋 Planned |
| Dashboard | 📋 Planned |

## Tech Stack

- **Language**: Python 3.12
- **API**: FastAPI
- **Database**: PostgreSQL 16 + pgvector
- **Cache**: Redis 7
- **Agent Framework**: LangGraph
- **Protocol**: MCP (Model Context Protocol)
- **UI**: Next.js + TypeScript
