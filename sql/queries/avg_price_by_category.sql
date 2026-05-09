-- Average price by category for the Metabase bar chart.
-- Optional Metabase filters:
--   [[AND extraction_date BETWEEN {{start_date}} AND {{end_date}}]]
--   [[AND category = {{category}}]]

SELECT
    category,
    ROUND(AVG(price)::numeric, 2) AS avg_price,
    COUNT(*) AS product_count,
    MIN(extraction_date) AS first_seen_date,
    MAX(extraction_date) AS latest_seen_date
FROM products_market
WHERE category IS NOT NULL
  [[AND extraction_date BETWEEN {{start_date}} AND {{end_date}}]]
  [[AND category = {{category}}]]
GROUP BY category
ORDER BY avg_price DESC, category;
