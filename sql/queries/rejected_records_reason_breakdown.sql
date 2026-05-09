-- Rejected-record reason breakdown for the optional quality/audit chart.
-- Optional Metabase filters:
--   [[AND pr.execution_date BETWEEN {{start_date}} AND {{end_date}}]]

SELECT
    COALESCE(pr.execution_date, rr.rejected_at::date) AS rejection_date,
    rr.rejection_reason,
    COUNT(*) AS rejected_count
FROM rejected_records rr
LEFT JOIN pipeline_runs pr
    ON pr.run_id = rr.run_id
WHERE 1 = 1
  [[AND pr.execution_date BETWEEN {{start_date}} AND {{end_date}}]]
GROUP BY COALESCE(pr.execution_date, rr.rejected_at::date), rr.rejection_reason
ORDER BY rejection_date DESC, rejected_count DESC, rr.rejection_reason;
