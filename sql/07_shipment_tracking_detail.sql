-- ============================================================
-- 07_shipment_tracking_detail.sql
-- Shipment Tracking Detail - Full Timeline
-- ============================================================

WITH current_event AS (

    SELECT DISTINCT ON (te.shipment_id)

        te.shipment_id,

        te.event_type AS current_status,

        te.event_timestamp AS current_timestamp

    FROM public.tracking_events te

    WHERE te.event_timestamp <= CURRENT_TIMESTAMP

    ORDER BY
        te.shipment_id,
        te.event_timestamp DESC,
        te.tracking_event_id DESC
),

steps AS (

    SELECT *
    FROM (
        VALUES
            ('PICKED_UP', 1),
            ('DEPARTED', 2),
            ('IN_TRANSIT', 3),
            ('ARRIVED', 4)
    ) AS v(
        event_type,
        step_order
    )
),

actual_events AS (

    SELECT

        te.shipment_id,

        te.event_type,

        MIN(te.event_timestamp) AS event_timestamp

    FROM public.tracking_events te

    WHERE te.event_timestamp <= CURRENT_TIMESTAMP

    GROUP BY
        te.shipment_id,
        te.event_type
),

shipment_plan AS (

    SELECT

        shipment_id,

        MIN(planned_arrival) AS planned_arrival

    FROM public.shipment_legs

    GROUP BY
        shipment_id
)

SELECT

    ce.shipment_id,

    s.step_order,

    s.event_type,

    ae.event_timestamp AS actual_event_timestamp,

    CASE

        WHEN ae.event_type IS NOT NULL
             AND s.event_type = ce.current_status
            THEN 'CURRENT'

        WHEN ae.event_type IS NOT NULL
            THEN 'COMPLETED'

        ELSE 'PLANNED'

    END AS timeline_state,

    sp.planned_arrival

FROM current_event ce

CROSS JOIN steps s

LEFT JOIN actual_events ae

    ON ae.shipment_id = ce.shipment_id

    AND ae.event_type = s.event_type

LEFT JOIN shipment_plan sp

    ON sp.shipment_id = ce.shipment_id

ORDER BY

    ce.shipment_id,

    s.step_order;