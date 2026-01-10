/*
Question : What are the most optimal skills to learn it's in high demand and a high paying skil?
- Identify skills in high demand and associated with high avg. salaries for data analyst roles.
- Concentrates on remote positions with specified salaries.
- Why? Targets skills that offer job security (high demand) and financial benefits (high salary),
  offering staategic insights for career development in data analysis.
*/

WITH skills_demand AS (
    select 
        sd.skill_id,
        sd.skills,
        count(sj.skill_id) as demand_count
    FROM job_postings_fact jp
    INNER JOIN skills_job_dim sj
        ON jp.job_id = sj.job_id
    INNER JOIN skills_dim sd
        ON sj.skill_id = sd.skill_id
    WHERE job_title_short = 'Data Analyst'
         AND salary_year_avg IS NOT NULL
         AND job_work_from_home = TRUE
    GROUP BY
        sd.skill_id
), Avg_salary AS (
    select
        sj.skill_id, 
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
        sj.skill_id
)

select 
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM skills_demand
INNER JOIN Avg_salary
    ON skills_demand.skill_id = Avg_salary.skill_id
Where demand_count >10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;



--small

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





