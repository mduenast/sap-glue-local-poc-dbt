select
    cast(matnr as varchar) as material_id,
    cast(mtart as varchar) as material_type,
    cast(matkl as varchar) as material_group,
    cast(meins as varchar) as base_unit,
    cast(ersda as date) as created_date
from {{ source('sap_raw', 'raw_sap_mara') }}
