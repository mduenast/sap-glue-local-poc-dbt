select
    cast(vbeln as varchar) as sales_order_id,
    cast(kunnr as varchar) as customer_id,
    cast(audat as date) as order_date,
    cast(auart as varchar) as order_type,
    cast(vkorg as varchar) as sales_organization,
    cast(netwr as decimal(18, 2)) as header_net_amount,
    cast(waerk as varchar) as header_currency
from {{ source('sap_raw', 'raw_sap_vbak') }}
