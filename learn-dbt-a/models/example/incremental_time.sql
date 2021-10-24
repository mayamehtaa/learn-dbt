{{ config(materialized='incremental') }}

SELECT
    *
FROM snowflake_sample_data.tpcds_sf10tcl.time_dim
WHERE to_time(concat(T_HOUR::varchar, ':', T_MINUTE, ':', T_SECOND)) <= current_time

{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  and to_time(concat(T_HOUR::varchar, ':', T_MINUTE, ':', T_SECOND)) > (select max(to_time(concat(T_HOUR::varchar, ':', T_MINUTE, ':', T_SECOND))) from {{ this }})

{% endif %}
