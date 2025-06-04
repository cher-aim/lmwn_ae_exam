{{
  config(
    materialized = 'table',
    schema = 'data_mart_fleet_management'
    )
}}

SELECT 
	dm.driver_id,
	dm.vehicle_type,
	dm.region AS driver_region,
	r.city,
	dm.active_status,
	dm.driver_rating,
	ot.order_id,
	ot.order_datetime,
	ot.pickup_datetime,
	ot.delivery_datetime,
	ot.order_status,
	ot.delivery_zone,
	ot.total_amount,
	ot.is_late_delivery,
	ot.delivery_distance_km,
    DATEDIFF('minute', pickup_datetime, delivery_datetime) AS delivery_minutes
FROM {{ ref('model_transaction_orders') }} ot 
LEFT JOIN {{ ref('model_dim_drivers') }} dm 
ON ot.driver_id = dm.driver_id
LEFT JOIN {{ ref('model_dim_restaurants') }} r 
ON r.restaurant_id = ot.restaurant_id