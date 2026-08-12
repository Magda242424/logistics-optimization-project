SELECT
    origin_city_id, destination_city_id,
    COUNT(*) AS shipment_count,
    AVG(distance_km) AS avg_distance_km,
    AVG(transport_cost_eur) AS avg_transport_cost_eur,
    SUM(total_weight_kg) / 1000.0 AS total_weight_tons
FROM shipments
GROUP BY
    origin_city_id,
    destination_city_id
ORDER BY
    shipment_count DESC;

SELECT
    city_id,
    city_name,
    country,
    latitude,
    longitude
FROM cities;
