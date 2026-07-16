--Easy : https://platform.stratascratch.com/coding/10552-identify-never-sold-inventory-products?code_type=1

SELECT i.product_id,
       i.product_name
FROM inventory_current_stock i
LEFT JOIN sales_transactions s
       ON i.product_id = s.product_id
WHERE s.product_id IS NULL;


--Medium : https://platform.stratascratch.com/coding/10365-common-friends-script?code_type=1

SELECT u.user_id,
       u.user_name
FROM users u
JOIN friends f1 
       ON u.user_id = f1.friend_id
JOIN users k 
       ON k.user_id = f1.user_id
JOIN friends f2 
       ON u.user_id = f2.friend_id
JOIN users h 
       ON h.user_id = f2.user_id
WHERE k.user_name = 'Karl'
  AND h.user_name = 'Hans';

