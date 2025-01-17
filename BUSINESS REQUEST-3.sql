SELECT campaign_name, 
CONCAT(sum(base_price * quantity_sold_before_promo)/1000000,'M') [Total_Revenue_Before_Promo_In_Millions], 
concat(round(sum(
case
when promo_type = 'BOGOF' then base_price * 0.5 * 2*(quantity_sold_after_promo)
when promo_type = '50% OFF' then base_price * 0.5 * quantity_sold_after_promo
when promo_type = '25% OFF' then base_price * 0.75* quantity_sold_after_promo
when promo_type = '33% OFF' then base_price * 0.67 * quantity_sold_after_promo
when promo_type = '500 cashback' then (base_price-500)*  quantity_sold_after_promo
end)/1000000,2),'M') as Total_Revenue_After_Promotion_In_Millions
from vw_fact_events_details
group by campaign_name;
