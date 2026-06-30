# sap-glue-local-poc-dbt

Capa mínima de transformación dbt para una prueba de concepto local con datos tipo SAP. Este repositorio contiene únicamente el proyecto dbt que modela tablas raw ya cargadas en una base de datos local DuckDB.

El proyecto es genérico y apto para uso público. No incluye extractor, emulador compatible con AWS Floci, planificador, orquestador, configuración de Snowflake ni integración productiva.

## Qué hace este proyecto

- Define fuentes raw tipo SAP en DuckDB.
- Construye modelos staging con nombres de columnas más legibles.
- Construye un mart sencillo de pedidos de venta uniendo cabeceras, posiciones, clientes y materiales.

## Limitaciones

- Este repositorio valida únicamente la capa de transformación dbt.
- No valida extracción de datos, servicios cloud, orquestación, autenticación, autorización, red, rendimiento ni comportamiento de despliegue productivo.
- El perfil incluido es un ejemplo local con DuckDB y no contiene credenciales reales ni datos de cuentas privadas.

## Requisitos previos

- Python 3.10 o superior.
- Una base de datos DuckDB generada por el repositorio local de laboratorio.
- Tablas raw disponibles en DuckDB:
  - `raw_sap_mara`
  - `raw_sap_kna1`
  - `raw_sap_vbak`
  - `raw_sap_vbap`

## Instalar dbt con soporte DuckDB

```bash
python -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install dbt-duckdb
```

## Configurar el perfil

Copia el perfil de ejemplo y ajusta la ruta de DuckDB mediante `DUCKDB_PATH` si hace falta:

```bash
cp profiles.yml.example profiles.yml
export DUCKDB_PATH=./data/sap_glue_local_poc.duckdb
```

El perfil de ejemplo usa esta configuración:

```yaml
path: "{{ env_var('DUCKDB_PATH', './data/sap_glue_local_poc.duckdb') }}"
```

`profiles.yml` es un fichero local y no debe versionarse. También puedes copiar el perfil `sap_glue_local_poc` al directorio estándar de perfiles de dbt en vez de mantener un perfil local.

## Ejecutar dbt

Asumiendo que el fichero DuckDB ya existe y contiene las tablas raw esperadas:

```bash
dbt debug --profiles-dir .
dbt deps --profiles-dir .
dbt parse --profiles-dir .
dbt build --profiles-dir .
```

Para separar ejecución y tests:

```bash
dbt run --profiles-dir .
dbt test --profiles-dir .
```

## Columnas raw esperadas

El fichero DuckDB debe ser generado por el repositorio de laboratorio. Los modelos staging esperan estos esquemas raw.

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

Ajusta los modelos staging solo si cambia el contrato de las tablas raw.
