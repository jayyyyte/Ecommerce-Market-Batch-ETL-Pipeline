-- Daily product count trend for the Metabase line chart.
-- Optional Metabase filters:
--   [[AND extraction_date BETWEEN {{start_date}} AND {{end_date}}]]
--   [[AND category = {{category}}]]

SELECT
    extraction_date,
    COUNT(*) AS product_count,
    COUNT(DISTINCT category) AS category_count,
    COUNT(DISTINCT source) AS source_count
FROM products_market
WHERE 1 = 1
  [[AND extraction_date BETWEEN {{start_date}} AND {{end_date}}]]
  [[AND category = {{category}}]]
GROUP BY extraction_date
ORDER BY extraction_date;
