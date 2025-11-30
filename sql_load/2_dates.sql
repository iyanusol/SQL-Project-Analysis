
SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
    EXTRACT(MONTH FROM job_posted_date) AS date_month,
    EXTRACT(YEAR FROM job_posted_date) AS date_year
FROM
    job_postings_fact
LIMIT 5;

SELECT
    COUNT(job_id) AS job_posted_count,
    EXTRACT(MONTH FROM job_posted_date)AS month 
FROM
    job_postings_fact
WHERE job_title_short ='Data Analyst'
GROUP BY
    MONTH
ORDER BY
    job_posted_count DESC;

--GET JANUARY JOBS
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs
UNION ALL
--GET FEBURARY JOBS
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs
UNION ALL
--GET march JOBS
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs


SELECT
	quarter1_job_postings.job_title_short,
	quarter1_job_postings.job_location,
	quarter1_job_postings.job_via,
	quarter1_job_postings.job_posted_date::DATE
FROM
-- Gets all rows from January, February, and March job postings 
	(
		SELECT *
		FROM january_jobs
		UNION ALL
		SELECT *
		FROM february_jobs
		UNION ALL 
		SELECT *
		FROM march_jobs
	) AS quarter1_job_postings 
WHERE
	quarter1_job_postings.salary_year_avg > 70000
	--AND job_postings.job_title_short = 'Data Analyst'
ORDER BY
	quarter1_job_postings.salary_year_avg DESC




SELECT
    job_postings_q1.job_id,
    job_postings_q1.job_title_short,
    job_postings_q1.job_location,
    job_postings_q1.job_via,
    job_postings_q1.salary_year_avg,
    skills_dim.skills,
    skills_dim.type
FROM
-- Get job postings from the first quarter of 2023
    (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
    ) as job_postings_q1
LEFT JOIN skills_job_dim ON job_postings_q1.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings_q1.salary_year_avg > 70000
ORDER BY
    job_postings_q1.job_id;