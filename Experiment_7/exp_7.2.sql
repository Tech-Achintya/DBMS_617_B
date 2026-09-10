CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    amount NUMERIC(10,2)
);

INSERT INTO Orders (order_id, customer_name, amount) VALUES
(101, 'Rahul', 5000),
(102, 'Aman', 15000),
(103, 'Priya', 8000),
(104, 'Neha', 25000),
(105, 'Karan', 12000),
(106, 'Anjali', 7000),
(107, 'Rohit', 18000),
(108, 'Simran', 9500);


DO $$
DECLARE
    order_record RECORD;

    order_cursor CURSOR FOR
        SELECT order_id, customer_name, amount
        FROM Orders;
BEGIN
    OPEN order_cursor;

    LOOP
        FETCH order_cursor INTO order_record;

        EXIT WHEN NOT FOUND;

        IF order_record.amount > 10000 THEN
            RAISE NOTICE 'Order ID: %, High Value',
                order_record.order_id;
        END IF;
    END LOOP;

    CLOSE order_cursor;
END $$;