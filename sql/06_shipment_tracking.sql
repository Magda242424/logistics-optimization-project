-- ============================================================
-- 06_shipment_tracking.sql
-- Shipment Tracking - Current Status
-- ============================================================

WITH current_event AS (
    SELECT DISTINCT ON (te.shipment_id)
        te.shipment_id,
        te.event_type AS current_status,
        te.event_timestamp AS last_update,
        te.latitude,
        te.longitude,
        te.estimated_delivery,
        te.leg_id
    FROM public.tracking_events te
    WHERE te.event_timestamp <= CURRENT_TIMESTAMP
    ORDER BY
        te.shipment_id,
        te.event_timestamp DESC,
        te.tracking_event_id DESC
),

shipment_info AS (
    SELECT DISTINCT ON (sl.shipment_id)
        sl.shipment_id,

        c1.city_name AS origin_city,
        c2.city_name AS destination_city,

        sl.transport_mode

    FROM public.shipment_legs sl

    JOIN public.cities c1
        ON c1.city_id = sl.origin_city_id

    JOIN public.cities c2
        ON c2.city_id = sl.destination_city_id

    ORDER BY
        sl.shipment_id,
        sl.leg_sequence
),

shipment_plan AS (
    SELECT
        shipment_id,
        MIN(planned_arrival) AS planned_arrival
    FROM public.shipment_legs
    GROUP BY shipment_id
)

SELECT
    si.shipment_id,

    si.origin_city,
    si.destination_city,

    si.transport_mode,

    ce.current_status,

    ce.last_update,

    ce.latitude,
    ce.longitude,

    ce.estimated_delivery,

    sp.planned_arrival

FROM shipment_info si

JOIN current_event ce
    ON ce.shipment_id = si.shipment_id

LEFT JOIN shipment_plan sp
    ON sp.shipment_id = si.shipment_id

ORDER BY
    si.shipment_id;