-- Q3. What plan start_date values occur after the year 2020 for our dataset? Show the breakdown by count of events for each plan_name ?

WITH count_2020_2021 AS (
    SELECT
        p.plan_id,
        UPPER(p.plan_name) AS PLAN_NAME,
        COUNT(
            CASE
                WHEN YEAR(s.start_date) = 2020 THEN plan_id
            END
        ) AS COUNT_2020,
        COUNT(
            CASE
                WHEN YEAR(s.start_date) = 2021 THEN plan_id
            END
        ) AS COUNT_2021
    FROM
        plans p
        INNER JOIN subscriptions s USING(plan_id)
    GROUP BY
        p.plan_id,
        p.plan_name
    ORDER BY
        p.plan_id
)
SELECT
    *
FROM
    count_2020_2021;