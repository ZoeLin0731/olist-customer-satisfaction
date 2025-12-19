CREATE OR REPLACE VIEW public.vw_tableau_order_level AS
SELECT
    o.order_id,
    o.customer_id,
    o.order_status,
    DATE_TRUNC('day', o.order_purchase_timestamp) AS purchase_date,
    o.delivery_delay_days,
    o.review_score,
    o.is_dissatisfied
FROM public.vw_orders_delivery_reviews o
WHERE o.review_score IS NOT NULL;

CREATE OR REPLACE VIEW public.vw_tableau_delay_bucket AS
SELECT
    CASE
        WHEN delivery_delay_days <= -5 THEN 'Early (>=5 days)'
        WHEN delivery_delay_days BETWEEN -4 AND 0 THEN 'On time'
        WHEN delivery_delay_days BETWEEN 1 AND 5 THEN 'Late (1–5 days)'
        WHEN delivery_delay_days BETWEEN 6 AND 15 THEN 'Late (6–15 days)'
        ELSE 'Very late (>15 days)'
    END AS delay_bucket,
    COUNT(*) AS total_orders,
    COUNT(*) FILTER (WHERE is_dissatisfied IS TRUE) AS dissatisfied_orders,
    ROUND(
        (COUNT(*) FILTER (WHERE is_dissatisfied IS TRUE))::numeric / COUNT(*),
        4
    ) AS dissatisfaction_rate
FROM public.vw_orders_delivery_reviews
WHERE review_score IS NOT NULL
GROUP BY delay_bucket;


CREATE OR REPLACE VIEW public.vw_tableau_seller_risk AS
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
JOIN public.order_items oi USING (order_id)
JOIN public.sellers s USING (seller_id)
WHERE o.review_score IS NOT NULL
GROUP BY s.seller_id
HAVING COUNT(DISTINCT o.order_id) >= 50;



