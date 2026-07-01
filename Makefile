PYTHON ?= python3
VENV := .venv
DBT := $(VENV)/bin/dbt
PIP := $(VENV)/bin/python -m pip

.PHONY: setup doctor parse build test clean

setup:
	$(PYTHON) -m venv $(VENV)
	$(PIP) install --upgrade pip
	$(PIP) install -r requirements.txt

doctor:
	@status=0; \
	if command -v $(PYTHON) >/dev/null 2>&1; then \
		echo "OK: Python 3 is available: $$($(PYTHON) --version)"; \
	else \
		echo "ERROR: Python 3 was not found. Install Python 3 and rerun make setup."; \
		status=1; \
	fi; \
	if [ -x "$(DBT)" ]; then \
		echo "OK: local dbt is available at $(DBT)"; \
	else \
		echo "ERROR: local dbt was not found at $(DBT). Run: make setup"; \
		status=1; \
	fi; \
	if [ -f profiles.yml ]; then \
		echo "OK: profiles.yml exists"; \
	else \
		echo "ERROR: profiles.yml is missing. Run: cp profiles.yml.example profiles.yml"; \
		status=1; \
	fi; \
	if [ -n "$$DUCKDB_PATH" ]; then \
		echo "OK: DUCKDB_PATH is set to $$DUCKDB_PATH"; \
	else \
		echo "WARN: DUCKDB_PATH is not set. The default profile path will be used."; \
	fi; \
	exit $$status

parse:
	$(DBT) parse --profiles-dir .

build:
	$(DBT) build --profiles-dir .

test:
	$(DBT) test --profiles-dir .

clean:
	rm -rf target logs dbt_packages
