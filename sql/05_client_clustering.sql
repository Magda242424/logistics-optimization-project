SELECT
    c.client_id,
    c.segment,
    c.annual_demand_tons,
    c.priority,
    COUNT(s.shipment_id) AS shipment_count,
    SUM(s.total_weight_kg) AS shipped_weight_kg,
    SUM(s.transport_cost_eur) AS total_transport_cost_eur,
    AVG(s.distance_km) AS avg_distance_km,
    AVG(s.transit_time_hours) AS avg_transit_hours,
    SUM(s.co2_kg) AS total_co2_kg
FROM clients c
LEFT JOIN shipments s
    ON c.client_id = s.client_id
GROUP BY
    c.client_id,
    c.segment,
    c.annual_demand_tons,
    c.priority
ORDER BY c.client_id;
