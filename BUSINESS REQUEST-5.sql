WITH cte1 AS (
    SELECT 
        category,
        product_name,
        SUM(base_price * quantity_sold_before_promo) AS Total_Revenue_BP,
        SUM(
            CASE
                WHEN promo_type = 'BOGOF' THEN base_price * 0.5 * 2 * quantity_sold_after_promo
                WHEN promo_type = '50% OFF' THEN base_price * 0.5 * quantity_sold_after_promo
                WHEN promo_type = '25% OFF' THEN base_price * 0.75 * quantity_sold_after_promo
                WHEN promo_type = '33% OFF' THEN base_price * 0.67 * quantity_sold_after_promo
                WHEN promo_type = '500 cashback' THEN (base_price - 500) * quantity_sold_after_promo
            END) AS Total_Revenue_AP
    FROM  vw_fact_events_details
    GROUP BY product_name, category),
cte2 AS (
    SELECT *,
        (Total_Revenue_AP - Total_Revenue_BP) AS IR,  
        ((Total_Revenue_AP - Total_Revenue_BP) / Total_Revenue_BP) * 100 AS IR_Percent
    FROM cte1)
SELECT TOP 5 
    product_name, category, IR, IR_Percent,
    RANK() OVER (ORDER BY IR_Percent DESC) AS Rank_IR
FROM cte2;
