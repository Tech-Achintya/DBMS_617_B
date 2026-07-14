--Problem Link :  https://www.codechef.com/learn/course/sql-intermediate/SQ00BS02/problems/SQLKEY01B
-- Name : ON DELETE CASCADE & ON UPDATE CASCADE


 -- Write a DELETE query to delete John Doe's details from Customers table and see changes in Orders table.
DELETE FROM Customers 
WHERE customer_id = '1';
SELECT * FROM Orders