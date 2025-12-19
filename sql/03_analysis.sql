-- 03_analysis.sql

-- Dissatisfaction by delay bucket
SELECT
    CASE
        WHEN delivery_delay_days <= -5 THEN 'Early (>=5 days)'
        WHEN delivery_delay_days BETWEEN -4 AND 0 THEN 'On time'
        WHEN delivery_delay_days BETWEEN 1 AND 5 THEN 'Late (1–5 days)'
        WHEN delivery_delay_days BETWEEN 6 AND 15 THEN 'Late (6–15 days)'
        ELSE 'Very late (>15 days)'
    END AS delay_bucket,
    COUNT(*) AS total_orders,
    COUNT(*) FILTER (WHERE is_dissatisfied) AS dissatisfied_orders,
    ROUND(
        COUNT(*) FILTER (WHERE is_dissatisfied)::numeric / COUNT(*),
        4
    ) AS dissatisfaction_rate
FROM vw_orders_delivery_reviews
WHERE review_score IS NOT NULL
GROUP BY delay_bucket
ORDER BY dissatisfaction_rate DESC;


-- Median delay comparison
SELECT
    is_dissatisfied,
    COUNT(*) AS orders,
    ROUND(AVG(delivery_delay_days)::numeric, 2) AS avg_delay,
    PERCENTILE_CONT(0.5)
        WITHIN GROUP (ORDER BY delivery_delay_days::numeric) AS median_delay
FROM vw_orders_delivery_reviews
WHERE review_score IS NOT NULL
GROUP BY is_dissatisfied;


-- Seller-level delivery risk (unique orders per seller)
SELECT
    s.seller_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(AVG(o.delivery_delay_days)::numeric, 2) AS avg_delay,
    ROUND(
        (COUNT(DISTINCT o.order_id) FILTER (WHERE o.is_dissatisfied IS TRUE))::numeric
        / COUNT(DISTINCT o.order_id),
        4
    ) AS dissatisfaction_rate
FROM public.vw_orders_delivery_reviews o
JOIN order_items oi USING (order_id)
JOIN sellers s USING (seller_id)
WHERE o.review_score IS NOT NULL
GROUP BY s.seller_id
HAVING COUNT(DISTINCT o.order_id) >= 50
ORDER BY dissatisfaction_rate DESC
LIMIT 20;



