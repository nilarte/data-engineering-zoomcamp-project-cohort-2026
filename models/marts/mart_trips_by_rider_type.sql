{{ config(
    materialized='table',
    cluster_by=['member_casual', 'rideable_type']
) }}

with trips as (
    select * from {{ ref('stg_citibike_tripdata') }}
),

aggregated as (
    select
        member_casual,
        rideable_type,

        -- volume metrics
        COUNT(*)                                as total_rides,
        ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) as pct_of_total_rides,

        -- duration metrics
        ROUND(AVG(trip_duration_minutes), 2)    as avg_trip_duration_minutes
    from trips
    group by 1, 2
)

select * from aggregated