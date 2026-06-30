select
    cast(kunnr as varchar) as customer_id,
    cast(name1 as varchar) as customer_name,
    cast(land1 as varchar) as country_code,
    cast(ort01 as varchar) as city
from {{ source('sap_raw', 'raw_sap_kna1') }}
