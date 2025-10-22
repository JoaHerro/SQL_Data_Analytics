/*
    Question: What are the top-paying data analyst jobs?
        * Identify the top 10 highest-paying Data Analyst roles that are available remotly.
        * Focuses on job postings with specified salaries (removing nulls).
        * Why? Highlight the Top-paying opportunities for Data Analyst, offering insights into employment
*/

SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    cd.name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim AS cd
    ON cd.company_id = job_postings_fact.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT
    10