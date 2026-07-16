-- easy :  https://platform.stratascratch.com/coding/10549-top-customers-with-dense-ranking?code_type=1%20(

WITH customer_totals AS (
    SELECT customer_id,
           SUM(total_purchase_value) AS total_purchase_value
    FROM customer_purchase
    GROUP BY customer_id
),
top5_cutoff AS (
    SELECT DISTINCT total_purchase_value
    FROM customer_totals
    ORDER BY total_purchase_value DESC
    LIMIT 5
)
SELECT c.customer_id,
       c.total_purchase_value
FROM customer_totals c
WHERE c.total_purchase_value >= (SELECT MIN(total_purchase_value) FROM top5_cutoff)
ORDER BY c.total_purchase_value DESC;

--medium : https://datalemur.com/questions/rolling-average-tweets
SELECT 
    user_id,
    tweet_date,
    ROUND(
        AVG(tweet_count) OVER (
            PARTITION BY user_id
            ORDER BY tweet_date
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ), 2
    ) AS rolling_avg_3d
FROM tweets
ORDER BY user_id, tweet_date;

--hard : https://datalemur.com/questions/repeated-payments
SELECT COUNT(*) AS payment_count
FROM (
    SELECT t2.transaction_id
    FROM transactions t1
    JOIN transactions t2
      ON t1.merchant_id = t2.merchant_id
     AND t1.credit_card_id = t2.credit_card_id
     AND t1.amount = t2.amount
     AND t2.transaction_timestamp > t1.transaction_timestamp
     AND t2.transaction_timestamp <= t1.transaction_timestamp + INTERVAL '10 minutes'
) repeated;
