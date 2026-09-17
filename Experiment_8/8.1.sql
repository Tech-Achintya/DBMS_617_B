
DROP TABLE IF EXISTS employee;

CREATE TABLE employee (
    empl_id INT PRIMARY KEY,
    empl_name VARCHAR(50),
    empl_salary NUMERIC,
    department VARCHAR(50)
);

CREATE OR REPLACE PROCEDURE add_employee(
    p_empl_id INT,
    p_empl_name VARCHAR,
    p_empl_salary NUMERIC,
    p_department VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN

    IF p_empl_id % 2 = 0 THEN
        RAISE EXCEPTION 'EVEN not allowed';
    ELSE
        INSERT INTO employee
        VALUES (
            p_empl_id,
            p_empl_name,
            p_empl_salary,
            p_department
        );
    END IF;

END;
$$;

-- This will fail because 102 is even
CALL add_employee(102, 'Rahul', 60000, 'HR');

-- This will successfully insert the employee
CALL add_employee(101, 'Rahul', 60000, 'HR');

-- Check the table
SELECT * FROM employee;