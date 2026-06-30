select
    cast(mandt as varchar) as client_id,
    cast(kunnr as varchar) as customer_id,
    cast(name1 as varchar) as customer_name,
    cast(land1 as varchar) as country_code,
    cast(ort01 as varchar) as city,
    cast(erdat as date) as record_created_date,
    cast(aedat as date) as record_changed_date,
    cast(_batch_id as varchar) as batch_id,
    cast(_source_table as varchar) as source_table,
    cast(_loaded_at as timestamp) as loaded_at,
    cast(_file_name as varchar) as file_name
from {{ source('sap_raw', 'raw_sap_kna1') }}
