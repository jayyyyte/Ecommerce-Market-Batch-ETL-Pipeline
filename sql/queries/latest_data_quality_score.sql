-- Latest data quality score for the Metabase scorecard.

SELECT
    execution_date,
    status,
    data_quality_score,
    rows_extracted,
    rows_loaded,
    rows_rejected
FROM pipeline_runs
ORDER BY execution_date DESC, started_at DESC
LIMIT 1;
