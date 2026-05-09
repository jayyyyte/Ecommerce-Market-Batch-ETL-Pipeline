# Dashboard SQL Queries

These queries are the source of truth for the Sprint 4 Metabase dashboard. Create each Metabase question as a native SQL question against the `ecommerce_db` PostgreSQL database.

## Before You Start

Start the stack from the repository root:

```powershell
docker compose up -d
```

Open Metabase:

```text
http://localhost:3000
```

If this is the first Metabase visit, create the admin account in the browser. Then add the project database with these values:

| Field | Value |
|---|---|
| Database type | PostgreSQL |
| Host | `postgres` |
| Port | `5432` |
| Database name | `ecommerce_db` |
| Username | `POSTGRES_USER` from `.env` |
| Password | `POSTGRES_PASSWORD` from `.env` |

Metabase runs inside Docker, so use host `postgres`, not `localhost`.

## Create the Collection

1. In Metabase, open **Collections**.
2. Create a collection named `E-Commerce Market Analysis`.
3. Save all Sprint 4 questions and the final dashboard inside this collection.

## Create Each Question

For every `.sql` file in this directory:

1. Click **New**.
2. Choose **SQL query**.
3. Select the `ecommerce_db` database.
4. Paste the SQL from the file.
5. If Metabase asks about variables, configure them using the table below.
6. Click **Run**.
7. Choose the visualization type listed below.
8. Click **Save** and save it into `E-Commerce Market Analysis`.

Use these variable names in Metabase when prompted:

| Variable | Type | Connected Field |
|---|---|---|
| `start_date` | Date | `products_market.extraction_date` or `pipeline_runs.execution_date` |
| `end_date` | Date | `products_market.extraction_date` or `pipeline_runs.execution_date` |
| `category` | Text | `products_market.category` |

For queries that use `category`, set a sample value such as `electronics` when testing. The categories in the current FakeStore demo data are:

```text
electronics
jewelery
mens_clothing
womens_clothing
```

## Required Cards

| File | Save As | Visualization | Recommended Settings |
|---|---|---|---|
| `avg_price_by_category.sql` | Average Price by Category | Bar chart | X-axis `category`, Y-axis `avg_price` |
| `top_rated_products.sql` | Top 10 Products by Rating | Table | Keep `name`, `category`, `price`, `rating`, `review_count`, `extraction_date` visible |
| `daily_product_count_trend.sql` | Daily Product Count Trend | Line chart | X-axis `extraction_date`, Y-axis `product_count` |
| `pipeline_run_history.sql` | Pipeline Run History | Table | Sort by `execution_date` descending |
| `latest_data_quality_score.sql` | Latest Data Quality Score | Number/scorecard | Display `data_quality_score` |

## Optional Card

| File | Save As | Visualization | Recommended Settings |
|---|---|---|---|
| `rejected_records_reason_breakdown.sql` | Rejected Records by Reason | Bar chart or table | This may be empty for clean FakeStore demo data |

## Build the Dashboard

1. Click **New**.
2. Choose **Dashboard**.
3. Name it `E-Commerce Market Analysis`.
4. Add the five required saved questions.
5. Arrange them like this:
   - Top row: Latest Data Quality Score, Pipeline Run History.
   - Middle row: Daily Product Count Trend, Average Price by Category.
   - Bottom row: Top 10 Products by Rating.
   - Optional: Rejected Records by Reason below the required cards.
6. Click the filter icon and add:
   - **Date filter** named `Date Range`.
   - **Text or category filter** named `Category`.
7. Connect `Date Range` to:
   - `start_date` / `end_date` on product cards.
   - `start_date` / `end_date` on pipeline cards.
8. Connect `Category` to the `category` variable on product cards.
9. Save the dashboard.

## Refresh and Demo

Before the demo:

1. Run the Airflow DAG for five dates if the dashboard is empty.
2. Open the dashboard.
3. Click refresh in Metabase.
4. Test the `Date Range` filter with `2026-05-01` through `2026-05-05`.
5. Test the `Category` filter with `electronics`.

The dashboard should show 5 dates, 20 products per date, and latest data quality score `100.00` after the Sprint 4 demo data commands have run.

## Troubleshooting

| Symptom | Likely Cause | Fix |
|---|---|---|
| Metabase cannot connect to Postgres | Used `localhost` as host | Use `postgres` because Metabase is inside Docker |
| Query asks for variables every run | Query has `{{start_date}}`, `{{end_date}}`, or `{{category}}` | Enter sample values while saving, then wire dashboard filters |
| Dashboard has no product data | DAG has not loaded demo history | Run the five `airflow dags test ecommerce_market_etl YYYY-MM-DD` commands from the main README |
| Rejected records card is empty | FakeStore demo data is clean | This is expected for the normal demo |
| Category filter returns no rows | Category value does not match normalized slug | Use `electronics`, `jewelery`, `mens_clothing`, or `womens_clothing` |
