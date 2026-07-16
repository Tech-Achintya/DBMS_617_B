-- easy : https://www.codechef.com/learn/course/sql-intermediate/SQ00BS02/problems/SQLKEY01C?tab=statement
DELETE FROM Customers
WHERE customer_id = 1;
SELECT * FROM Orders;

-- medium : https://www.codechef.com/learn/course/sql-intermediate/SQ00BS02/problems/SQLKEY01C?tab=statement 
--ANS :  Foreign key is a field in one table that refers to the primary key of another table.
-- hard : https://www.codechef.com/learn/course/sql-intermediate/SQ00BS03/problems/GSQ68?tab=statement
SELECT Customer_id,
       Customer_Name,
       Customer_Age
FROM Customer
LIMIT 3;
