/*
    Question: What are the most in-demand skills for Data Analyst?
        * Join job postings to inner join table similar to Query 2.
        * Indentify the top 5 in-demand skills for a data analyst.
        * Focus on all job postings.
        * Why? Retrive the top 5 skills with the highest demand in the job market,
            providing insights into the most valuable skills for job seekers.
*/

SELECT 
    skills,
    COUNT(sjd.skill_id) AS demand_count
FROM
    job_postings_fact
INNER JOIN skills_job_dim AS sjd ON sjd.job_id = job_postings_fact.job_id
INNER JOIN skills_dim AS sd ON sd.skill_id = sjd.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home IS TRUE
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 10