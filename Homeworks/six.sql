-- easy:https://datalemur.com/questions/signup-confirmation-rate
SELECT 
    ROUND(
        COUNT(DISTINCT CASE WHEN t.signup_action = 'Confirmed' THEN e.user_id END) 
        * 1.0 / COUNT(DISTINCT e.user_id), 
        2
    ) AS confirm_rate
FROM emails e
LEFT JOIN texts t
  ON e.email_id = t.email_id;
--medium:https://datalemur.com/questions/signup-confirmation-rate
WITH touches_by_week AS (
    SELECT 
        contact_id,
        DATE_TRUNC('week', event_date) AS week_start
    FROM marketing_touches
    GROUP BY contact_id, DATE_TRUNC('week', event_date)
),
streaks AS (
    SELECT 
        contact_id,
        week_start,
        ROW_NUMBER() OVER (PARTITION BY contact_id ORDER BY week_start) 
          - EXTRACT(WEEK FROM week_start) AS grp
    FROM touches_by_week
),
valid_streaks AS (
    SELECT contact_id
    FROM streaks
    GROUP BY contact_id, grp
    HAVING COUNT(*) >= 3
),
trial_contacts AS (
    SELECT DISTINCT contact_id
    FROM marketing_touches
    WHERE event_type = 'trial_request'
)
SELECT c.email
FROM crm_contacts c
JOIN valid_streaks vs ON c.contact_id = vs.contact_id
JOIN trial_contacts tc ON c.contact_id = tc.contact_id;

-- hard : https://platform.stratascratch.com/coding/2120-first-and-last-day?code_type=1
WITH promo_tx AS (
    SELECT 
        p.promotion_id,
        p.start_date,
        p.end_date,
        SUM(o.units_sold) AS total_units
    FROM online_sales_promotions p
    JOIN online_orders o
      ON p.promotion_id = o.promotion_id
    GROUP BY p.promotion_id, p.start_date, p.end_date
),
first_last AS (
    SELECT 
        p.promotion_id,
        SUM(CASE WHEN o.date_sold = p.start_date THEN o.units_sold ELSE 0 END) AS first_day_units,
        SUM(CASE WHEN o.date_sold = p.end_date THEN o.units_sold ELSE 0 END) AS last_day_units,
        SUM(o.units_sold) AS total_units
    FROM online_sales_promotions p
    JOIN online_orders o
      ON p.promotion_id = o.promotion_id
    GROUP BY p.promotion_id
)
SELECT 
    f.promotion_id,
    ROUND(COALESCE(f.first_day_units * 100.0 / NULLIF(f.total_units,0),0),2) AS perc_first_day,
    ROUND(COALESCE(f.last_day_units * 100.0 / NULLIF(f.total_units,0),0),2) AS perc_last_day
FROM first_last f
ORDER BY f.promotion_id;
