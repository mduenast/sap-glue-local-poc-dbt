# sap-glue-local-poc-dbt

Capa mínima de transformación dbt para una prueba de concepto local con datos tipo SAP. Este repositorio contiene únicamente el proyecto dbt que modela tablas raw ya cargadas en una base de datos local DuckDB.

El proyecto es genérico y apto para uso público. No incluye extractor, emulador de AWS, planificador, orquestador ni integración productiva.

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

Copia el perfil de ejemplo y ajusta la ruta del fichero DuckDB si hace falta:

```bash
cp profiles.yml.example profiles.yml
```

Por defecto, el perfil de ejemplo apunta a:

```text
./data/sap_glue_local_poc.duckdb
```

Puedes ejecutar dbt usando el perfil local:

```bash
dbt debug --profiles-dir .
dbt deps --profiles-dir .
dbt parse --profiles-dir .
dbt run --profiles-dir .
dbt test --profiles-dir .
```

También puedes copiar el perfil `sap_glue_local_poc` al directorio estándar de perfiles de dbt.

## Estructura del proyecto

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

## Esquema raw asumido

Los modelos staging asumen nombres de columna habituales en datos tipo SAP:

- `raw_sap_mara`: `matnr`, `mtart`, `matkl`, `meins`, `ersda`
- `raw_sap_kna1`: `kunnr`, `name1`, `land1`, `ort01`
- `raw_sap_vbak`: `vbeln`, `kunnr`, `audat`, `auart`, `vkorg`, `netwr`, `waerk`
- `raw_sap_vbap`: `vbeln`, `posnr`, `matnr`, `kwmeng`, `vrkme`, `netwr`, `waerk`

Ajusta los modelos staging si el extractor raw emite nombres de columna distintos.
