-- Self Joins
-- Sometimes, you need to join a table to itself. This is called a self join. It's not a distinct type of JOIN like INNER, LEFT, RIGHT, or FULL; rather, it's a technique where you use any of those join types, but the left and right tables are the same table. You treat the table as if it were two separate tables, typically using aliases to distinguish them.

-- Self joins are crucial when you need to compare rows within the same table or when you have hierarchical data within a single table. Think of situations like:

-- Employee-Manager Relationships: A single employees table might have an employee_id column and a manager_id column (which also references employee_id). To find each employee's manager, you'd join the table to itself.
-- Finding Pairs: You might want to find pairs of employees who live in the same city.
-- Parts List Consider a scenario in mechanical industry where a self-join helps retrieve hierarchical relationships in a Bill of Materials (BOM) by linking components to their parent assemblies within the same table.
-- Here's the general idea, using aliases (a and b in this case):

-- SELECT
--     e1.employee_name AS Employee,
--     e2.employee_name AS Manager
-- FROM
--     employees AS e1  -- Alias for employee
-- INNER JOIN
--     employees AS e2  -- Alias for manager
-- ON
--     e1.manager_id = e2.employee_id;
-- Key Points:
-- 1.Table Aliases: You must use table aliases (like a and b above) to differentiate between the "two" instances of the same table. Without aliases, the database wouldn't know which instance you're referring to.

-- 2.Join Condition: The ON clause is critical. It defines how rows within the same table are related. This is where you specify the relationship you're investigating (e.g., a.manager_id = b.employee_id). The Join Condition cannot have same name on both sides of comparison, that will include all the entries in the table.

-- 3.Join Types: Although its mostly used with the INNER JOIN, any of the previously dicussed joins could also be used in SELF JOIN.

-- Task
-- We have a student table that also stores the Course_id of a student's favorite course. Our task has two parts related to using a SELF JOIN:

-- Find pairs of students that belong to the same department.
-- Identify students who have chosen the same Course_id as their favorite. Display the St_id, St_Name, and Course_id and order it in increasing Course_id.
-- Expected Output:

-- Part 1

-- ┌───────┬─────────────────┬─────────────┬───────┬─────────────────┬─────────────┐
-- │ St_id │     St_Name     │ Department  │ St_id │     St_Name     │ Department  │
-- ├───────┼─────────────────┼─────────────┼───────┼─────────────────┼─────────────┤
-- │ 1003  │ David Lee       │ Mathematics │ 1006  │ Light Yagami    │ Mathematics │
-- │ 1004  │ Sarah Johnson   │ English     │ 1008  │ Patrick Bateman │ English     │
-- │ 1005  │ Michael Chen    │ Biology     │ 1007  │ Jordan          │ Biology     │
-- │ 1006  │ Light Yagami    │ Mathematics │ 1003  │ David Lee       │ Mathematics │
-- │ 1007  │ Jordan          │ Biology     │ 1005  │ Michael Chen    │ Biology     │
-- │ 1008  │ Patrick Bateman │ English     │ 1004  │ Sarah Johnson   │ English     │
-- └───────┴─────────────────┴─────────────┴───────┴─────────────────┴─────────────┘
-- Part 2
-- ┌───────┬─────────────────┬───────────┐
-- │ St_id │     St_Name     │ Course_id │
-- ├───────┼─────────────────┼───────────┤
-- │ 1005  │ Michael Chen    │ BIO103    │
-- │ 1007  │ Jordan          │ BIO103    │
-- │ 1004  │ Sarah Johnson   │ ENG201    │
-- │ 1008  │ Patrick Bateman │ ENG201    │
-- │ 1003  │ David Lee       │ MAT202    │
-- │ 1006  │ Light Yagami    │ MAT202    │
-- └───────┴─────────────────┴───────────┘

-- Part 1: Find pairs of students that belong to the same department.
SELECT 
    s1.St_id, s1.St_Name, s1.Department,
    s2.St_id, s2.St_Name, s2.Department
FROM student s1
INNER JOIN student s2
    ON s1.Department = s2.Department
   AND s1.St_id <> s2.St_id;

-- Part 2: Identify students who have chosen the same Course_id as their favorite.
SELECT DISTINCT
    s1.St_id, s1.St_Name, s1.Course_id
FROM student s1
INNER JOIN student s2
    ON s1.Course_id = s2.Course_id
   AND s1.St_id <> s2.St_id
ORDER BY s1.Course_id;