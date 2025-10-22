# 📊 Data Analyst Job Market Insights

## Introduction

Curious about the data analytics job market? This project explores **remote Data Analyst roles**, highlighting 💰 top-paying jobs, 🛠️ most in-demand skills, and 🔍 skills that provide both high demand and salary.

Check out the SQL queries behind this analysis in the [`/Project_SQL_Analisis`](./Project_SQL_Analisis) folder!

---

## Background

 I wanted to understand how to navigate the data analyst job market, identify the most valuable skills, and streamline the search for high-paying, high-demand roles.

The dataset includes **job postings, salaries, company info, and listed skills**, which makes it perfect for analyzing trends and uncovering actionable insights.

### Questions I aimed to answer

1. Which Data Analyst jobs pay the most?
2. What skills are required for these high-paying roles?
3. Which skills are most frequently requested?
4. Which skills are linked to higher salaries?
5. Which skills are the best to learn for maximizing market value?

---

## Tools Used

- **SQL** – querying and filtering data
- **PostgreSQL** – database management
- **Visual Studio Code** – running queries and managing scripts
- **Git & GitHub** – version control and project sharing

---

# 📊 Data Analyst Job Market Insights

This section summarizes the key **insights derived from each SQL query** in the project.  
Each query was designed to answer a specific question about the **data analyst job market**, combining data from job postings, salaries, companies, and required skills.

---

## 🧩 1️⃣ Top-Paying Data Analyst Jobs

**Goal:** Identify the highest-paying Data Analyst positions across remote job listings.

### 💡 Insights
- **Salary Range:** The top 10 Data Analyst roles range between **$184K and $650K**, indicating strong earning potential for specialized positions.
- **Company Diversity:** Employers like **Meta**, **SmartAsset**, and **AT&T** lead the list, showing that both tech giants and established enterprises invest heavily in analytics talent.
- **Job Variety:** Titles include _Data Analyst_, _Director of Analytics_, and _Data Science Lead_, suggesting a broad range of seniority levels within the same career path.
- **Remote Opportunities:** Many high-paying roles are fully remote, emphasizing flexibility and a global talent demand in analytics.

```sql
SELECT	
	job_id,
	job_title,
	job_location,
	job_schedule_type,
	salary_year_avg,
	job_posted_date,
    name AS company_name
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND 
    job_location = 'Anywhere' AND 
    salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;
```
---

## 🧠 2️⃣ Skills for High-Paying Jobs

**Goal:** Discover which skills are most frequently required in the top-paying Data Analyst roles.

### 💡 Insights
- **Top Technical Skills:**  
  - **SQL** (appears in 8 of 10 top roles)  
  - **Python** (7 of 10 roles)  
  - **Tableau** (6 of 10 roles)
- These skills form the **core toolkit** for top earners — highlighting the blend of data querying, programming, and visualization.
- **Supporting Tools:** _Snowflake, Pandas, R,_ and _Excel_ are often mentioned, reinforcing the value of both analytical and technical versatility.
- **Takeaway:** To reach high-paying positions, candidates should balance **strong SQL foundations** with **modern data stack skills** (Python + visualization).

```sql
WITH top_paying_jobs AS (
    SELECT job_id, salary_year_avg
    FROM job_postings_fact
    WHERE job_title_short = 'Data Analyst' AND job_location = 'Anywhere' AND salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)
SELECT skills
FROM top_paying_jobs
JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id;
```

---

## 📈 3️⃣ Most In-Demand Skills for Data Analysts

**Goal:** Identify the skills that appear most frequently in all remote Data Analyst job postings.

### 💡 Insights
- **Core Skills Dominate:**  
  - **SQL (7,291 mentions)** and **Excel (4,611 mentions)** top the list, confirming they remain indispensable.  
  - **Python, Tableau, and Power BI** follow closely, showing the shift toward more technical, data-driven storytelling.
- **Interpretation:** Employers still value traditional data handling (SQL, Excel) while increasingly expecting **programming and visualization** skills.
- **Practical Takeaway:** Mastering **SQL + Excel + one visualization tool (Tableau or Power BI)** creates a solid foundation for most data analyst roles.

| Skill   | Demand Count |
|----------|--------------|
| SQL      | 7291         |
| Excel    | 4611         |
| Python   | 4330         |
| Tableau  | 3745         |
| Power BI | 2609         |

```sql
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
```

---

## 💰 4️⃣ Skills Associated with Higher Salaries

**Goal:** Explore which technical skills correlate with higher average salaries among data analysts.

### 💡 Insights
- **Highest Paying Skills:**
  - **PySpark ($208K)** and **Couchbase ($160K)** dominate the top of the list, revealing the premium value of **big data and distributed computing** skills.
  - **Machine Learning tools** like _DataRobot_ and _Jupyter_ also show strong salary potential.
- **Engineering Tools Matter:** _GitLab, Airflow, Kubernetes_ — traditionally associated with engineering — indicate that hybrid “Data Analyst + Engineer” roles command higher pay.
- **Key Trend:** The closer a skill is to **data infrastructure or automation**, the higher its associated compensation.

| Skills        | Average Salary ($) |
|---------------|-------------------:|
| PySpark       | 208,172 |
| Bitbucket     | 189,155 |
| Couchbase     | 160,515 |
| Watson        | 160,515 |
| DataRobot     | 155,486 |
| GitLab        | 154,500 |
| Swift         | 153,750 |
| Jupyter       | 152,777 |
| Pandas        | 151,821 |
| Elasticsearch | 145,000 |

```sql
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

```

---

## 🚀 5️⃣ Most Optimal Skills to Learn

**Goal:** Combine both **demand** and **salary** data to determine which skills are most strategic to learn.

### 💡 Insights
- **Balanced Skills:** Tools like **Go, Snowflake, Azure, AWS, and BigQuery** offer a strong mix of demand and high salary — ideal for data professionals targeting high-value niches.
- **High-Demand Programming:**  
  - **Python (236)** and **R (148)** remain the most sought-after languages.  
  - Their moderate salaries (~$100K) suggest high competition but continued importance.
- **Data Visualization Tools:**  
  - **Tableau ($99K)** and **Looker ($103K)** emphasize the growing need for data communication and BI expertise.
- **Database & Cloud Tools:**  
  - Skills in **SQL Server, Oracle, NoSQL, and cloud platforms** point to an expanding need for scalable, integrated data management.
- **Strategic Takeaway:**  
  Learn a mix of **core analysis tools (SQL, Python, Tableau)** and **cloud/big data tech (Snowflake, Azure, AWS)** to maximize both **employability** and **earning potential**.

| Skills     | Demand Count | Avg Salary ($) |
|-------------|--------------|----------------:|
| Go          | 27           | 115,320 |
| Confluence  | 11           | 114,210 |
| Hadoop      | 22           | 113,193 |
| Snowflake   | 37           | 112,948 |
| Azure       | 34           | 111,225 |
| BigQuery    | 13           | 109,654 |
| AWS         | 32           | 108,317 |
| Java        | 17           | 106,906 |
| SSIS        | 12           | 106,683 |
| Jira        | 20           | 104,918 |

```sql
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

```

---

## 🧠 Overall Insights Summary

| Category | Key Findings |
|-----------|---------------|
| **Top-Paying Jobs** | Salaries reach up to $650K for remote data roles. |
| **Essential Skills** | SQL, Python, and Tableau dominate across all job levels. |
| **Emerging Trends** | Cloud (AWS, Azure, Snowflake) and Big Data tools drive the best salary growth. |
| **Market Demand** | SQL & Excel are still non-negotiable foundations. |
| **Career Strategy** | Learn high-demand + high-salary skills for maximum ROI (SQL + Python + Cloud/BI). |

---

## 🎓 Final Reflection

This analysis provided hands-on experience with real job data while strengthening my SQL, analytical, and storytelling skills.  
Understanding how **skills translate into demand and salary** gave me a data-driven perspective on professional growth as a Data Analyst.

> Continuous learning and adaptation are key — the data job market rewards those who stay ahead of technology trends.

---




