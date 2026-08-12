SELECT
    transport_mode,
    COUNT(*) AS shipment_count,
    ROUND(SUM(transport_cost_eur)::numeric, 2) AS total_cost_eur,
    ROUND(AVG(transport_cost_eur)::numeric, 2) AS avg_cost_eur,
    ROUND(AVG(transit_time_hours)::numeric, 2) AS avg_transit_hours,
    ROUND(SUM(co2_kg)::numeric, 2) AS total_co2_kg
FROM shipments
GROUP BY transport_mode
ORDER BY total_cost_eur DESC;

SELECT
    w.warehouse_id,
    w.warehouse_type,
    w.city_id,
    w.capacity_tons,
    COUNT(s.shipment_id) AS shipment_count,
    ROUND(SUM(s.total_weight_kg)::numeric / 1000, 2) AS total_weight_tons,
    ROUND(SUM(s.transport_cost_eur)::numeric, 2) AS total_cost_eur,
    ROUND(AVG(s.transit_time_hours)::numeric, 2) AS avg_transit_hours,
    ROUND(SUM(s.co2_kg)::numeric, 2) AS total_co2_kg
FROM warehouses wLEFT JOIN shipments s
    ON w.warehouse_id = s.warehouse_id
GROUP BY
    w.warehouse_id,
    w.warehouse_type,
    w.city_id,
    w.capacity_tons
ORDER BY total_cost_eur DESC;

SELECT
    c.client_id,
    c.segment,
    c.priority,
    c.annual_demand_tons,
    COUNT(s.shipment_id) AS shipment_count,
    ROUND(SUM(s.total_weight_kg)::numeric / 1000, 2) AS shipped_weight_tons,
    ROUND(SUM(s.transport_cost_eur)::numeric, 2) AS total_transport_cost_eur,
    ROUND(AVG(s.transit_time_hours)::numeric, 2) AS avg_transit_hours,
    ROUND(SUM(s.co2_kg)::numeric, 2) AS total_co2_kg
FROM clients c
LEFT JOIN shipments s
    ON c.client_id = s.client_id
GROUP BY
    c.client_id,
    c.segment,
    c.priority,
    c.annual_demand_tons
ORDER BY total_transport_cost_eur DESC;
