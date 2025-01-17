
SELECT city, COUNT(distinct store_id) AS total_stores
FROM vw_fact_events_details
group by city 
order by total_stores desc;
