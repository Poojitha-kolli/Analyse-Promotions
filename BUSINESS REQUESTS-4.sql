WITH CategoryISU AS (
    SELECT 
        campaign_name, category,
        CASE 
            WHEN SUM(quantity_sold_before_promo) = 0 THEN 0
            ELSE ROUND(((SUM(quantity_sold_after_promo) - SUM(quantity_sold_before_promo)) * 100.0) / SUM(quantity_sold_before_promo), 2)
        END AS isu_percentage
    FROM vw_fact_events_details
    WHERE campaign_name = 'Diwali'
    GROUP BY campaign_name,category
)
SELECT 
    campaign_name, category,
    CAST(isu_percentage AS DECIMAL(10, 2)) AS isu_percentage,
    RANK() OVER (ORDER BY isu_percentage DESC) AS rank_order
FROM CategoryISU;
