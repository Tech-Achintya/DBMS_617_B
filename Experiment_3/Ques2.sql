CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    salary DECIMAL(10,2),
    age INT,
    city VARCHAR(30)
);

INSERT INTO Employee VALUES
(101, 'Amit', 'IT', 60000, 25, 'Delhi'),
(102, 'Priya', 'HR', 45000, 28, 'Mumbai'),
(103, 'Rahul', 'IT', 70000, 30, 'Pune'),
(104, 'Sneha', 'Finance', 55000, 27, 'Delhi'),
(105, 'Karan', 'HR', 48000, 24, 'Chandigarh'),
(106, 'Neha', 'Finance', 75000, 35, 'Mumbai'),
(107, 'Arjun', 'IT', 65000, 29, 'Bangalore'),
(108, 'Riya', 'Marketing', 50000, 26, 'Pune');

SELECT * FROM Employee;

SELECT emp_name, salary
FROM Employee
WHERE salary > 50000;

SELECT *
FROM Employee
WHERE department = 'IT';

SELECT *
FROM Employee
WHERE age < 30;

SELECT *
FROM Employee
WHERE city = 'Delhi';

-- Count how many employees are in each department
SELECT department, COUNT(*) AS total_employees
FROM Employee
GROUP BY department;

-- Find the average salary of employees in each department
SELECT department, AVG(salary) AS average_salary
FROM Employee
GROUP BY department;

-- Find the highest salary in each city
SELECT city, MAX(salary) AS highest_salary
FROM Employee
GROUP BY city;

-- Calculate the total salary paid in each department
SELECT department, SUM(salary) AS total_salary
FROM Employee
GROUP BY department;

-- Display only those departments having more than one employee
SELECT department, COUNT(*) AS total
FROM Employee
GROUP BY department
HAVING COUNT(*) > 1;

-- Find the average salary of each department and sort the result from highest to lowest
SELECT department, AVG(salary) AS average_salary
FROM Employee
GROUP BY department
ORDER BY average_salary DESC;