-- easy : https://datalemur.com/questions/histogram-users-purchases
WITH latest_tx AS (
    SELECT user_id,
           MAX(transaction_date) AS latest_date
    FROM user_transactions
    GROUP BY user_id
)
SELECT 
    lt.latest_date AS transaction_date,
    lt.user_id,
    COUNT(ut.product_id) AS purchase_count
FROM latest_tx lt
JOIN user_transactions ut
  ON lt.user_id = ut.user_id
 AND lt.latest_date = ut.transaction_date
GROUP BY lt.latest_date, lt.user_id
ORDER BY lt.latest_date, lt.user_id;


-- medium: https://datalemur.com/questions/teams-power-users
SELECT 
    sender_id,
    COUNT(*) AS message_count
FROM messages
WHERE sent_date >= '2022-08-01'
  AND sent_date < '2022-09-01'
GROUP BY sender_id
ORDER BY message_count DESC
LIMIT 2;

-- hard: https://datalemur.com/questions/teams-power-users
SELECT 
    p.product_family,
    COALESCE(SUM(s.units_sold), 0) AS total_units_sold,
    COALESCE(
        ROUND(
            SUM(
                CASE 
                    WHEN s.promotion_id IS NOT NULL 
                         AND s.promotion_id IN (SELECT promotion_id FROM facebook_sales_promotions)
                    THEN s.units_sold 
                    ELSE 0 
                END
            ) * 100.0 / NULLIF(SUM(s.units_sold), 0), 
        2), 
    0) AS perc_units_with_valid_promo
FROM facebook_products p
LEFT JOIN facebook_sales s
       ON p.product_id = s.product_id
GROUP BY p.product_family
ORDER BY p.product_family;
