with sales_headers as (
    select * from {{ ref('stg_sap__vbak') }}
),

sales_items as (
    select * from {{ ref('stg_sap__vbap') }}
),

customers as (
    select * from {{ ref('stg_sap__kna1') }}
),

materials as (
    select * from {{ ref('stg_sap__mara') }}
)

select
    sales_items.client_id,
    sales_items.sales_order_id,
    sales_items.sales_order_item_id,
    sales_headers.order_date,
    sales_headers.order_type,
    sales_headers.sales_organization,
    sales_headers.customer_id,
    customers.customer_name,
    customers.country_code,
    customers.city,
    sales_items.material_id,
    materials.material_type,
    materials.material_group,
    materials.base_unit,
    sales_items.order_quantity,
    sales_items.sales_unit,
    sales_items.item_net_amount,
    sales_items.item_currency,
    sales_headers.header_net_amount,
    sales_headers.header_currency
from sales_items
left join sales_headers
    on sales_items.sales_order_id = sales_headers.sales_order_id
    and sales_items.client_id = sales_headers.client_id
left join customers
    on sales_headers.customer_id = customers.customer_id
    and sales_headers.client_id = customers.client_id
left join materials
    on sales_items.material_id = materials.material_id
    and sales_items.client_id = materials.client_id
