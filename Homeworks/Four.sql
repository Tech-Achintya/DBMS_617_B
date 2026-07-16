-- easy : https://datalemur.com/questions/time-spent-snaps
SELECT 
    ab.age_bucket,
    ROUND(
        SUM(CASE WHEN a.activity_type = 'send' THEN a.time_spent ELSE 0 END) 
        * 100.0 / 
        NULLIF(SUM(CASE WHEN a.activity_type IN ('send','open') THEN a.time_spent ELSE 0 END),0), 
        2
    ) AS send_perc,
    ROUND(
        SUM(CASE WHEN a.activity_type = 'open' THEN a.time_spent ELSE 0 END) 
        * 100.0 / 
        NULLIF(SUM(CASE WHEN a.activity_type IN ('send','open') THEN a.time_spent ELSE 0 END),0), 
        2
    ) AS open_perc
FROM activities a
JOIN age_breakdown ab
  ON a.user_id = ab.user_id
WHERE a.activity_type IN ('send','open')
GROUP BY ab.age_bucket
ORDER BY ab.age_bucket;


--hard :  https://platform.stratascratch.com/coding/2146-department-manager-and-employee-salary-comparison?code_type=1
WITH dept_avg AS (
    SELECT department,
           ROUND(AVG(salary)) AS dept_avg_salary
    FROM employee_o
    WHERE employee_title != 'Manager'
    GROUP BY department
)
SELECT e.department,
       e.id AS employee_id,
       e.salary AS employee_salary,
       m.salary AS manager_salary,
       d.dept_avg_salary
FROM employee_o e
LEFT JOIN employee_o m
       ON e.manager_id = m.id
JOIN dept_avg d
       ON e.department = d.department
ORDER BY e.department, e.salary DESC;

