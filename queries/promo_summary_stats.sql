WITH total_promo_sales AS (
    SELECT
        location_id AS location,
        promotion,
        ROUND(SUM(sales_in_thousands), 2) AS sales
    FROM `tc-da-1.turing_data_analytics.wa_marketing_campaign`
    GROUP BY
        1,
        2
), 
mean_std_by_locations AS 
(SELECT
    promotion,
    location,
    sales,
    COUNT(location) OVER
    (PARTITION BY promotion)
    AS sample_count, 
    AVG(sales) OVER (
        PARTITION BY promotion
    ) AS mean_sales_by_promo,
    STDDEV(sales) OVER (
        PARTITION BY promotion
    ) AS stddev_sales_by_promo
FROM total_promo_sales)

SELECT 
DISTINCT promotion, 
mean_sales_by_promo, 
stddev_sales_by_promo, 
sample_count
FROM 
mean_std_by_locations
