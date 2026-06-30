select
    cast(mandt as varchar) as client_id,
    cast(matnr as varchar) as material_id,
    cast(mtart as varchar) as material_type,
    cast(matkl as varchar) as material_group,
    cast(meins as varchar) as base_unit,
    cast(ersda as date) as created_date,
    cast(erdat as date) as record_created_date,
    cast(aedat as date) as record_changed_date,
    cast(_batch_id as varchar) as batch_id,
    cast(_source_table as varchar) as source_table,
    cast(_loaded_at as timestamp) as loaded_at,
    cast(_file_name as varchar) as file_name
from {{ source('sap_raw', 'raw_sap_mara') }}
