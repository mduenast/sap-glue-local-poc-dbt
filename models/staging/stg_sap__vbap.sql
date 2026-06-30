select
    cast(mandt as varchar) as client_id,
    cast(vbeln as varchar) as sales_order_id,
    cast(posnr as varchar) as sales_order_item_id,
    cast(matnr as varchar) as material_id,
    cast(kwmeng as decimal(18, 3)) as order_quantity,
    cast(vrkme as varchar) as sales_unit,
    cast(netwr as decimal(18, 2)) as item_net_amount,
    cast(waerk as varchar) as item_currency,
    cast(erdat as date) as record_created_date,
    cast(aedat as date) as record_changed_date,
    cast(_batch_id as varchar) as batch_id,
    cast(_source_table as varchar) as source_table,
    cast(_loaded_at as timestamp) as loaded_at,
    cast(_file_name as varchar) as file_name
from {{ source('sap_raw', 'raw_sap_vbap') }}
