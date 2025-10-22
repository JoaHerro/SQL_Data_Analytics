/*
    Question: What are the top skills based on salary?
     * Look at the average salary associated with each skills for Data Analyst positions.
     * Focuses on roles with specified salaries, regadless of location.
     * Why? It reveals how different skills impact salary levels for Data Analyst and
        helps identify the most financially rewarding skills to acquire or improve
*/

SELECT 
    skills,
    ROUND(AVG(salary_year_avg),0) AS avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim AS sjd ON sjd.job_id = job_postings_fact.job_id
INNER JOIN skills_dim AS sd ON sd.skill_id = sjd.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
    AND job_work_from_home IS TRUE
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 20

/*
    Insights:
        * PySpark top the list, reflecting high demand for Big Data processing skills.
        * Bitbucket signals that Data Analyst with devops or software collaboration expierence are being valued more.
        * Watson and DataRobot suggest a growing interest in AI-Driven analytics platforms.

        * Also strong demand for data manipulation and ML frameworks.
        * Jupyter Notebooks remains essential for prototyping and exploratory data analysis.
        * Airflow and Data Bricks point towards the need for automated workflows and distributed computing.


        * The highest-paying skills skew heavily toward data engineering, machine learning, and automation tools.
        * Data Analysts with hybrid skills sets combining analysis + ML + DevOps are commanding top salaries.
        * Core analyst tools like Excel, SQL or Tableau don't appear possibly because they're more widespread and offer less salary differentiation.

*/