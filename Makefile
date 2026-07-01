PYTHON ?= python3
VENV := .venv
DBT := $(VENV)/bin/dbt
PIP := $(VENV)/bin/python -m pip

.PHONY: setup parse build test clean

setup:
	$(PYTHON) -m venv $(VENV)
	$(PIP) install --upgrade pip
	$(PIP) install -r requirements.txt

parse:
	$(DBT) parse --profiles-dir .

build:
	$(DBT) build --profiles-dir .

test:
	$(DBT) test --profiles-dir .

clean:
	rm -rf target logs dbt_packages
