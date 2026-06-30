# sap-glue-local-poc-dbt

Minimal dbt transformation layer for a local SAP-like data extraction proof of concept. This repository contains only the dbt project that models raw tables already loaded into a local DuckDB database.

This project is intentionally generic and public-safe. It does not include an extractor, AWS emulator, scheduler, orchestrator, or any production integration.

## What this project does

- Defines SAP-like raw DuckDB sources.
- Builds staging models with readable column names.
- Builds a simple sales order mart by joining headers, items, customers, and materials.

## Limitations

- This repository validates only the dbt transformation layer.
- It does not validate data extraction, cloud services, orchestration, authentication, authorization, networking, performance, or production deployment behavior.
- The included profile is a local DuckDB example and does not contain real credentials or private account details.

## Prerequisites

- Python 3.10 or newer.
- A DuckDB database produced by the companion local lab repository.
- Raw tables available in DuckDB:
  - `raw_sap_mara`
  - `raw_sap_kna1`
  - `raw_sap_vbak`
  - `raw_sap_vbap`

## Install dbt with DuckDB support

```bash
python -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install dbt-duckdb
```

## Configure the profile

Copy the example profile and adjust the DuckDB file path if needed:

```bash
cp profiles.yml.example profiles.yml
```

By default, the example profile points to:

```text
./data/sap_glue_local_poc.duckdb
```

You can run dbt with the local profile file:

```bash
dbt debug --profiles-dir .
dbt deps --profiles-dir .
dbt parse --profiles-dir .
dbt run --profiles-dir .
dbt test --profiles-dir .
```

Alternatively, copy the `sap_glue_local_poc` profile into your standard dbt profiles directory.

## Project layout

```text
models/
  sources.yml
  staging/
    stg_sap__mara.sql
    stg_sap__kna1.sql
    stg_sap__vbak.sql
    stg_sap__vbap.sql
  marts/
    mart_sales_orders.sql
```

## Assumed raw schema

The staging models assume common SAP-like column names:

- `raw_sap_mara`: `matnr`, `mtart`, `matkl`, `meins`, `ersda`
- `raw_sap_kna1`: `kunnr`, `name1`, `land1`, `ort01`
- `raw_sap_vbak`: `vbeln`, `kunnr`, `audat`, `auart`, `vkorg`, `netwr`, `waerk`
- `raw_sap_vbap`: `vbeln`, `posnr`, `matnr`, `kwmeng`, `vrkme`, `netwr`, `waerk`

Adjust the staging models if the raw extractor emits different column names.
