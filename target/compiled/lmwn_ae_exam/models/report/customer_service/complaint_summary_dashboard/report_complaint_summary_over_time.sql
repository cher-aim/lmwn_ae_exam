

WITH issue_rankings AS (
    SELECT 
        YEAR,
        MONTH,
        day_type,
        day_name,
        issue_type,
        issue_sub_type,
        COUNT(*) AS issue_count,
        DENSE_RANK() OVER (PARTITION BY YEAR, MONTH, day_type, day_name ORDER BY COUNT(*) DESC) AS issue_rank
    FROM "ae_exam_db"."main_data_mart_customer_service"."model_mart_support_tickets"
    GROUP BY YEAR, MONTH, day_type, day_name, issue_type, issue_sub_type
)
, most_common_issues AS (
    SELECT 
        YEAR,
        MONTH,
        day_type,
        day_name,
        issue_type AS most_common_issue_type,
        issue_sub_type AS most_common_issue_sub_type,
        issue_count AS most_common_issue_count
    FROM issue_rankings
    WHERE issue_rank = 1
)
SELECT
    st.YEAR,
    st.MONTH,
    st.day_type,
    st.day_name,
    COUNT(*) AS total_issues_reported,
    COUNT(CASE WHEN st.status = 'resolved' AND st.resolved_datetime IS NOT NULL THEN 1 END) AS resolved_count,
    ROUND(COUNT(CASE WHEN st.resolved_datetime IS NOT NULL THEN 1 END) * 100.0 / COUNT(*), 2) AS resolution_rate_percent,
    ROUND(AVG(
        CASE WHEN st.status = 'resolved' AND st.resolved_datetime IS NOT NULL
        THEN resolved_duration_hours
        END), 2) AS avg_resolution_time_hours,
    ROUND(AVG(CASE WHEN st.compensation_amount > 0 THEN st.compensation_amount END), 2) AS avg_compensation_paid,
    ROUND(SUM(st.compensation_amount), 2) AS total_compensation_paid,
    mci.most_common_issue_type,
    mci.most_common_issue_sub_type,
    mci.most_common_issue_count
FROM "ae_exam_db"."main_data_mart_customer_service"."model_mart_support_tickets" st
LEFT JOIN most_common_issues mci 
    ON st.YEAR = mci.YEAR 
    AND st.MONTH = mci.MONTH 
    AND st.day_type = mci.day_type 
    AND st.day_name = mci.day_name
GROUP BY
    st.YEAR,
    st.MONTH,
    st.day_type,
    st.day_name,
    mci.most_common_issue_type,
    mci.most_common_issue_sub_type,
    mci.most_common_issue_count