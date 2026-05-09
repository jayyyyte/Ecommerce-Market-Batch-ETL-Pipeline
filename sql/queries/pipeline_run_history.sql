-- Pipeline run history for the Metabase health table or status chart.
-- Optional Metabase filter:
--   [[WHERE execution_date BETWEEN {{start_date}} AND {{end_date}}]]

SELECT
    execution_date,
    status,
    rows_extracted,
    rows_transformed,
    rows_loaded,
    rows_rejected,
    data_quality_score,
    started_at,
    finished_at,
    ROUND(EXTRACT(EPOCH FROM (finished_at - started_at))::numeric, 2) AS duration_seconds,
    error_message
FROM pipeline_runs
[[WHERE execution_date BETWEEN {{start_date}} AND {{end_date}}]]
ORDER BY execution_date DESC, started_at DESC;
