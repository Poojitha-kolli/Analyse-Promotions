CREATE VIEW vw_fact_events_details AS
SELECT 
    fe.event_id,
    fe.store_id,
    fe.campaign_id,
    fe.product_code,
    fe.base_price,
    fe.promo_type,
    fe.quantity_sold_before_promo,
    fe.quantity_sold_after_promo,
    ds.city,
    dc.campaign_name,
    dc.start_date,
    dc.end_date,
    dp.product_name,
    dp.category
FROM fact_events fe
INNER JOIN dim_stores ds ON fe.store_id = ds.store_id
INNER JOIN dim_campaigns dc ON fe.campaign_id = dc.campaign_id
INNER JOIN dim_products dp ON fe.product_code = dp.product_code;

SELECT * FROM vw_fact_events_details;



