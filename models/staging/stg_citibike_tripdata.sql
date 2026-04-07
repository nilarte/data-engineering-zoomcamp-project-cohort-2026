{{ config(
    materialized='view'
) }}

with source as (
    select * from {{ source('raw', 'citibike_tripdata') }}
),

staged as (
    select
        -- identifiers
        unique_row_id,
        filename,
        ride_id,

        -- trip info
        rideable_type,
        member_casual,

        -- timestamps
        started_at,
        ended_at,

        -- derived
        TIMESTAMP_DIFF(ended_at, started_at, MINUTE)    as trip_duration_minutes,
        DATE(started_at)                                 as trip_date,
        EXTRACT(YEAR FROM started_at)                   as trip_year,
        EXTRACT(MONTH FROM started_at)                  as trip_month,
        FORMAT_TIMESTAMP('%Y-%m', started_at)           as year_month,

        -- stations
        start_station_name,
        start_station_id,
        end_station_name,
        end_station_id,

        -- coordinates
        start_lat,
        start_lng,
        end_lat,
        end_lng

    from source
    where
        -- remove rides with missing critical fields
        ride_id is not null
        and started_at is not null
        and ended_at is not null
        -- remove negative or zero duration trips
        and TIMESTAMP_DIFF(ended_at, started_at, MINUTE) > 0
        -- remove unrealistically long trips (over 24 hours)
        and TIMESTAMP_DIFF(ended_at, started_at, MINUTE) < 1440
)

select * from staged