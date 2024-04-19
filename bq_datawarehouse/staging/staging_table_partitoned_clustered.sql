CREATE OR REPLACE TABLE `dtc-de-course-412605.dezoomcamp2024_capstone.stg_matches_partitoned_clustered`
PARTITION BY DATE(date_time)
CLUSTER BY season AS
SELECT * FROM `dtc-de-course-412605.dezoomcamp2024_capstone.stg_matches`;
