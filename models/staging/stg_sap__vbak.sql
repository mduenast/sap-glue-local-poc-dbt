select
    cast(mandt as varchar) as client_id,
    cast(vbeln as varchar) as sales_order_id,
    cast(kunnr as varchar) as customer_id,
    cast(audat as date) as order_date,
    cast(auart as varchar) as order_type,
    cast(vkorg as varchar) as sales_organization,
    cast(erdat as date) as record_created_date,
    cast(aedat as date) as record_changed_date,
    cast(waers as varchar) as document_currency,
    cast(netwr as decimal(18, 2)) as header_net_amount,
    cast(waerk as varchar) as header_currency,
    cast(_batch_id as varchar) as batch_id,
    cast(_source_table as varchar) as source_table,
    cast(_loaded_at as timestamp) as loaded_at,
    cast(_file_name as varchar) as file_name
from {{ source('sap_raw', 'raw_sap_vbak') }}
