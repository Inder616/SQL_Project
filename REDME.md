# 📌 Project Overview
Drive into the data job market!
This project analyzes Data Analyst roles to uncover:

* 💰Top-paying jobs
* 🛠️ Most in-demand skills
* 📈 Where high salary meets high demand

The goal is to help aspiring data analysts understand what skills actually pay and which jobs are worth targeting in today’s market.

All insights are generated using real job posting data and analyzed through SQL queries.

📂 SQL Queries Used in This Project
Explore all queries here:[project_sql folder](/project_sql/)

# 📊 Background
The data analytics job market is growing rapidly, but not all skills and roles are valued equally. Many aspiring analysts learn tools like SQL, Excel, and Python without knowing which skills actually lead to higher salaries and better job opportunities.

Companies today look for analysts who can not only analyze data, but also bring business value by working with the right tools and technologies. However, job seekers often face confusion about:

* Which data analyst roles pay the most

* What skills are required for these jobs 

* Which skills are truly in demand

* How salary and skill demand are connected

* What are the most optimal skills to learn

This project was created to remove that confusion by using real job posting data to identify trends in salary, job demand, and required skills. By analyzing this data, the project provides clear, data-driven answers to help data analysts make smarter career decisions.

# 🛠 Tools I used
- **SQL** – Used to extract, filter, join, and analyze job market data

- **PostgreSQL** – Relational database used to store and manage all datasets

- **VS Code** – Code editor used to write and execute SQL queries efficiently

- **Git & GitHub** – Used for version control, collaboration, and sharing the project.

# The Analysis 
Each query for this project is aimed at investigating specific aspects of the data analyst job market.
Here’s how I approached each question:

### 1. Top Paying Data Analyst Jobs
This query identifies the highest-paying data analyst roles by filtering remote job postings based on average yearly salary.
```sql
SELECT 
      j.job_id,
      j.job_title,
      j.job_location,
      j.job_schedule_type,
      j.salary_year_avg,
      j.job_posted_date,
      c.name AS company_name
FROM job_postings_fact j
LEFT JOIN company_dim c 
      ON j.company_id = c.company_id
WHERE job_title_short = 'Data Analyst' 
      AND job_location = 'Anywhere'
      AND salary_year_avg IS NOT NULL
ORDER BY j.salary_year_avg DESC
LIMIT 10;
```
### 2. Skills from top paying jobs
This query shows which skills are required for the highest-paying data analyst roles.
```sql
WITH top_paying_jobs AS (
    SELECT 
        j.job_id,
        j.job_title,
        j.salary_year_avg,
        c.name AS company_name
    FROM job_postings_fact j
    LEFT JOIN company_dim c 
        ON j.company_id = c.company_id
    WHERE job_title_short = 'Data Analyst' 
        AND job_location = 'Anywhere'
        AND salary_year_avg IS NOT NULL
    ORDER BY j.salary_year_avg DESC
    LIMIT 10
)
SELECT 
    tp.*,
    sd.skills
FROM top_paying_jobs tp
INNER JOIN skills_job_dim sj
    ON tp.job_id = sj.job_id
INNER JOIN skills_dim sd
    ON sj.skill_id = sd.skill_id
ORDER BY salary_year_avg DESC
```
### 3. In Demand skills for Data Analyst
This query identifies the most frequently required skills for remote data analyst jobs.
```sql
select 
    sd.skills,
    count(sj.skill_id) as demand_count
FROM job_postings_fact jp
INNER JOIN skills_job_dim sj
    ON jp.job_id = sj.job_id
INNER JOIN skills_dim sd
    ON sj.skill_id = sd.skill_id
WHERE job_title_short = 'Data Analyst' AND
      job_work_from_home = TRUE
GROUP BY
    sd.skills
ORDER BY
    demand_count DESC
LIMIT 5;
```
### 4. Skills Based on Salary
This query shows the average salary associated with each skill.
```sql
select 
    sd.skills,
    round(Avg(jp.salary_year_avg),2)as avg_salary
FROM job_postings_fact jp
INNER JOIN skills_job_dim sj
    ON jp.job_id = sj.job_id
INNER JOIN skills_dim sd
    ON sj.skill_id = sd.skill_id
WHERE job_title_short = 'Data Analyst' 
      And salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    sd.skills
ORDER BY
    avg_salary DESC
LIMIT 25;
```
### 5. Most optimal Skills to learn
This query identifies skills that offer both high demand and high average salary.
```sql
SELECT 
    sd.skill_id,
    sd.skills,
    COUNT(sj.skill_id) AS demand_count,
    ROUND(AVG(jp.salary_year_avg), 2) AS avg_salary
FROM job_postings_fact jp
JOIN skills_job_dim sj 
    ON jp.job_id = sj.job_id
JOIN skills_dim sd 
    ON sj.skill_id = sd.skill_id
WHERE jp.job_title_short = 'Data Analyst'
  AND jp.salary_year_avg IS NOT NULL
  AND jp.job_work_from_home = TRUE
GROUP BY 
    sd.skill_id, sd.skills
HAVING COUNT(sj.skill_id) > 10
ORDER BY 
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```
# What I Learned
Through this project, I learned how to:

- Write SQL queries to analyze real-world job market data

- Use joins, subqueries, and CTEs to combine and organize data

- Identify top-paying data analyst roles

- Discover which skills are most in demand

- Analyze how salary and skill demand are connected

- Work with a PostgreSQL database to manage and query data

- Use VS Code to write and run SQL queries

- Use Git and GitHub to version control and share a professional data projectfindings.

# 🧾 Conclusions
This project provides a clear, data-driven view of the data analyst job market by analyzing real job posting data. By combining salary information with required skills, it highlights which roles offer the highest pay and which skills are most valuable in today’s market.

The analysis shows that learning the right tools and technologies can significantly improve career opportunities for aspiring data analysts. Instead of guessing which skills to focus on, this project helps job seekers make informed decisions based on real market demand.

Overall, this project demonstrates how SQL and data analysis can be used to turn raw job data into meaningful insights that support smarter career planning.