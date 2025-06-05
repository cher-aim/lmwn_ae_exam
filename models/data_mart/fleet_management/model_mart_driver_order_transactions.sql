{{
  config(
    materialized = 'table',
    schema = 'data_mart_fleet_management'
    )
}}

SELECT 
	driver.driver_id,
	driver.vehicle_type,
	driver.region AS driver_region,
	restaurant.city,
	driver.active_status,
	driver.driver_rating,
	ord.order_id,
	ord.order_datetime,
	ord.pickup_datetime,
	ord.delivery_datetime,
	ord.order_status,
	ord.delivery_zone,
	ord.total_amount,
	ord.is_late_delivery,
	ord.delivery_distance_km,
    DATEDIFF('minute', pickup_datetime, delivery_datetime) AS delivery_minutes
FROM {{ ref('model_transaction_orders') }} ord 
LEFT JOIN {{ ref('model_dim_drivers') }} driver  
ON ord.driver_id = driver.driver_id
LEFT JOIN {{ ref('model_dim_restaurants') }} restaurant
ON restaurant.restaurant_id = ord.restaurant_id