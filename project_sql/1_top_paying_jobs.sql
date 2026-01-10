/*
Qeestion: What are the top-paying data analyst jobs?
- Identify the top 10 highest paying Data Analyst roles that are available remotely/Anywhere.
- Focuses on job postings with specified salaries(removed null).
- Include company names to.
*/

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



