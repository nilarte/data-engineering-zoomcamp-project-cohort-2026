{{ config(
    materialized='table',
    partition_by={
      "field": "trip_date",
      "data_type": "date",
      "granularity": "month"
    },
    cluster_by=['member_casual', 'rideable_type']
) }}

with trips as (
    select * from {{ ref('stg_citibike_tripdata') }}
),

aggregated as (
    select
        year_month,
        DATE_TRUNC(trip_date, MONTH)            as trip_date,
        trip_year,
        trip_month,
        member_casual,
        rideable_type,

        -- volume metrics
        COUNT(*)                                as total_rides,
        -- duration metrics
        ROUND(AVG(trip_duration_minutes), 2)    as avg_trip_duration_minutes,
        ROUND(MAX(trip_duration_minutes), 2)    as max_trip_duration_minutes
    from trips
    group by 1, 2, 3, 4, 5, 6
)

select * from aggregated