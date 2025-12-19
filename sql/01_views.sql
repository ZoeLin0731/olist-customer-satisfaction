-- 01_views.sql
CREATE OR REPLACE VIEW vw_orders_delivery_reviews AS
SELECT
    o.order_id,
    o.customer_id,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
    o.delivery_delay_days,
    r.review_score,
    CASE
        WHEN r.review_score IS NULL THEN NULL
        WHEN r.review_score <= 2 THEN TRUE
        ELSE FALSE
    END AS is_dissatisfied
FROM orders_clean o
LEFT JOIN reviews_clean r
USING (order_id);

