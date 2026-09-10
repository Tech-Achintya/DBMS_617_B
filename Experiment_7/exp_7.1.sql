---Ques Implement a PL/SQL block with a cursor to fetch and display the Name and Salary of the
-- top 5 highest-paid employees from the Staff table. - 
CREATE TABLE Staff (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    salary NUMERIC(10,2)
);

INSERT INTO Staff (emp_id, name, salary) VALUES
(1, 'Rahul', 45000),
(2, 'Aman', 75000),
(3, 'Priya', 60000),
(4, 'Neha', 90000),
(5, 'Karan', 55000),
(6, 'Anjali', 85000),
(7, 'Rohit', 70000),
(8, 'Simran', 95000);

DO $$
DECLARE
    emp_record RECORD;

    emp_cursor CURSOR FOR
        SELECT name, salary
        FROM Staff
        ORDER BY salary DESC
        LIMIT 5;
BEGIN
    OPEN emp_cursor;

    LOOP
        FETCH emp_cursor INTO emp_record;

        EXIT WHEN NOT FOUND;

        RAISE NOTICE 'Name: %, Salary: %',
            emp_record.name, emp_record.salary;
    END LOOP;

    CLOSE emp_cursor;
END $$;