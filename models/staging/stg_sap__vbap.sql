select
    cast(vbeln as varchar) as sales_order_id,
    cast(posnr as varchar) as sales_order_item_id,
    cast(matnr as varchar) as material_id,
    cast(kwmeng as decimal(18, 3)) as order_quantity,
    cast(vrkme as varchar) as sales_unit,
    cast(netwr as decimal(18, 2)) as item_net_amount,
    cast(waerk as varchar) as item_currency
from {{ source('sap_raw', 'raw_sap_vbap') }}
