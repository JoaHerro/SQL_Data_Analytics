/*
    Question: What are the most optimal skills to learn?
        * Identify skills in high demand and associated with high average salaries for Data Analyst.
        * Concentrates on remote positions with specified salaries.
        * Why? Target skills that offer job security being in high demand and financial benefits with higher salaries.
*/

WITH skills_demand AS (
    SELECT 
        sjd.skill_id,
        sd.skills,
        COUNT(sjd.skill_id) AS demand_count
    FROM
        job_postings_fact
    INNER JOIN skills_job_dim AS sjd ON sjd.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim AS sd ON sd.skill_id = sjd.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_work_from_home IS TRUE AND
        salary_year_avg IS NOT NULL
    GROUP BY
        sjd.skill_id, sd.skills
),

avg_year_salary AS (
    SELECT 
        sjd.skill_id,
        sd.skills,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM
        job_postings_fact
    INNER JOIN skills_job_dim AS sjd ON sjd.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim AS sd ON sd.skill_id = sjd.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home IS TRUE
    GROUP BY
        sjd.skill_id, sd.skills
)

SELECT
    sd.skill_id,
    sd.skills,
    sd.demand_count,
    ays.avg_salary
FROM
    skills_demand AS sd
INNER JOIN avg_year_salary AS ays ON ays.skill_id = sd.skill_id
WHERE
    demand_count > 10
ORDER BY
    ays.avg_salary DESC,
    demand_count DESC
LIMIT
    25

/*
    | Insight                        | Summary                                                                       |
| ------------------------------ | ----------------------------------------------------------------------------- |
| 💰 High salary ≠ High demand   | Niche tools (e.g. Go, Confluence) have fewer listings but offer top pay.      |
| 🔧 Core tools are essential    | Python, Tableau, SQL remain highly in demand, even if not top-paying.         |
| ☁️ Cloud and big data pay well | Knowledge of AWS, Snowflake, BigQuery can boost compensation significantly.   |
| 🎯 Skill diversity matters     | Analysts who combine analytics with cloud/engineering/devops tools stand out. |

*/
