/* 
Question : What are the top skills based on salary?
-LOOK at the avg. salary associted with each skills for Data Analysts positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills imapact salary levels for data analyst and
  helps identify the most financially rewarding skills to acquire of imptrove.
*/


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