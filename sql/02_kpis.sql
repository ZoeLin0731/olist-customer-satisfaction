-- 02_kpis.sql

-- Overall dissatisfaction rate
SELECT
    COUNT(*) FILTER (WHERE review_score IS NOT NULL) AS reviewed_orders,
    COUNT(*) FILTER (WHERE is_dissatisfied) AS dissatisfied_orders,
    ROUND(
        COUNT(*) FILTER (WHERE is_dissatisfied)::numeric
        / COUNT(*) FILTER (WHERE review_score IS NOT NULL),
        4
    ) AS dissatisfaction_rate
FROM vw_orders_delivery_reviews;

-- Delivery performance summary
SELECT
    ROUND(AVG(delivery_delay_days)::numeric, 2) AS avg_delay,
    PERCENTILE_CONT(0.5)
        WITHIN GROUP (ORDER BY delivery_delay_days::numeric) AS median_delay,
    COUNT(*) FILTER (WHERE delivery_delay_days > 0) AS late_orders,
    COUNT(*) FILTER (WHERE delivery_delay_days <= 0) AS on_time_or_early
FROM vw_orders_delivery_reviews
WHERE delivery_delay_days IS NOT NULL;