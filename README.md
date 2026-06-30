# sap-glue-local-poc-dbt

Minimal dbt transformation layer for a local SAP-like data extraction proof of concept. This repository contains only the dbt project that models raw tables already loaded into a local DuckDB database.

This project is intentionally generic and public-safe. It does not include an extractor, AWS emulator, scheduler, orchestrator, Snowflake configuration, or any production integration.

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

Copy the example profile and adjust the DuckDB path through `DUCKDB_PATH` if needed:

```bash
cp profiles.yml.example profiles.yml
export DUCKDB_PATH=./data/sap_glue_local_poc.duckdb
```

The example profile uses this setting:

```yaml
path: "{{ env_var('DUCKDB_PATH', './data/sap_glue_local_poc.duckdb') }}"
```

`profiles.yml` is a local file and should not be committed. You can also copy the `sap_glue_local_poc` profile into your standard dbt profiles directory instead of keeping a local profile file.

## Run dbt

Assuming the DuckDB file already exists and contains the expected raw tables:

```bash
dbt debug --profiles-dir .
dbt deps --profiles-dir .
dbt parse --profiles-dir .
dbt build --profiles-dir .
```

For separate run and test steps:

```bash
dbt run --profiles-dir .
dbt test --profiles-dir .
```

## Expected raw columns

The DuckDB file is expected to be produced by the lab repository. The staging models expect these raw schemas.

`raw_sap_mara`:

```text
mandt, matnr, mtart, matkl, meins, ersda, erdat, aedat,
_batch_id, _source_table, _loaded_at, _file_name
```

`raw_sap_kna1`:

```text
mandt, kunnr, name1, land1, ort01, erdat, aedat,
_batch_id, _source_table, _loaded_at, _file_name
```

`raw_sap_vbak`:

```text
mandt, vbeln, kunnr, audat, auart, vkorg, erdat, aedat,
waers, waerk, netwr, _batch_id, _source_table, _loaded_at, _file_name
```

`raw_sap_vbap`:

```text
mandt, vbeln, posnr, matnr, kwmeng, vrkme, waerk, netwr,
erdat, aedat, _batch_id, _source_table, _loaded_at, _file_name
```

Adjust the staging models only if the raw table contract changes.
