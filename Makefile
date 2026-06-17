.PHONY: up down infra seed reset test lint build

# ── Infrastructure ──────────────────────────────────────────

infra:
	docker compose up postgres mysql redis -d
	@echo "Waiting for databases..."
	@sleep 5
	@echo "Infrastructure ready"

up:
	docker compose up -d

down:
	docker compose down

reset:
	docker compose down -v
	docker compose up postgres mysql redis -d
	@sleep 5
	$(MAKE) seed

# ── Data ────────────────────────────────────────────────────

seed:
	./scripts/dev/seed.sh

# ── Services ────────────────────────────────────────────────

run-federation:
	cd services/federation && \
	uvicorn src.federation.api.main:app --reload --port 8001

run-context:
	cd services/context-engine && \
	uvicorn src.context.api.main:app --reload --port 8002

run-agents:
	cd services/agent-mesh && \
	uvicorn src.agents.api.main:app --reload --port 8003

# ── Testing ─────────────────────────────────────────────────

test:
	pytest services/ packages/ -v

test-federation:
	pytest services/federation/ -v

test-unit:
	pytest services/ packages/ -v -m unit

test-integration:
	pytest services/ packages/ -v -m integration

# ── Code Quality ────────────────────────────────────────────

lint:
	ruff check services/ packages/
	mypy services/ packages/ --ignore-missing-imports

format:
	ruff format services/ packages/

# ── Docker ──────────────────────────────────────────────────

build:
	docker compose build

build-federation:
	docker compose build federation

logs:
	docker compose logs -f $(service)

# ── Setup ───────────────────────────────────────────────────

setup:
	./scripts/dev/setup.sh