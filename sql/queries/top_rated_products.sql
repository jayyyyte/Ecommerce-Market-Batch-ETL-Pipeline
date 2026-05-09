-- Top-rated products for the Metabase table.
-- Optional Metabase filters:
--   [[AND extraction_date BETWEEN {{start_date}} AND {{end_date}}]]
--   [[AND category = {{category}}]]

SELECT
    name,
    category,
    source,
    price,
    rating,
    review_count,
    stock_status,
    extraction_date
FROM products_market
WHERE rating IS NOT NULL
  [[AND extraction_date BETWEEN {{start_date}} AND {{end_date}}]]
  [[AND category = {{category}}]]
ORDER BY rating DESC, review_count DESC, price ASC, name
LIMIT 10;
