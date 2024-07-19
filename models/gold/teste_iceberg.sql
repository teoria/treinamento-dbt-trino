-- Use the `ref` function to select from other models

{{ config(
    enabled = False,
    materialized='table',
    table_type='iceberg',
    properties= {
      "format": "'PARQUET'",
      "partitioning": "ARRAY['user_id']",
    }
) }}

select
    'A' as user_id,
    'pi' as name,
    'active' as status,
    17.89 as cost,
    1 as quantity,
    100000000 as quantity_big,
    '2020-01-01' as my_date
union 
select
    'B' as user_id,
    'pi' as name,
    'active' as status,
    17.89 as cost,
    1 as quantity,
    100000000 as quantity_big,
    '2020-01-01' as my_date