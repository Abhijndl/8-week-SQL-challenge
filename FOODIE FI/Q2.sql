-- Q2 .What is the monthly distribution of trial plan start_date values for our dataset - use the start of the month as the group by value

SELECT
    monthname(start_date) AS MONTH_NAME,
    MONTH(start_date) AS MONTH_NUMBER,
    COUNT(plan_id) AS TOTAL_JOINED
FROM
    subscriptions
WHERE
    plan_id = 0
GROUP BY
    MONTH(start_date),
    monthname(start_date)
ORDER BY
    MONTH_NUMBER,
    MONTH_NAME;
