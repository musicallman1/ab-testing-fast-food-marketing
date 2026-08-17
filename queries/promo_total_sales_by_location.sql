SELECT DISTINCT
   location_id AS location, 
   promotion, 
   ROUND(SUM(sales_in_thousands),2) AS sales 
FROM `data_analytics.wa_marketing_campaign` 
GROUP BY 
   1,2
