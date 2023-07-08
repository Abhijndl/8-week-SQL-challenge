-- Q 10 Can you further breakdown this average value into 30 day periods (i.e. 0-30 days, 31-60 days etc)

WITH trial AS (
	SELECT customer_id, start_date
	FROM subscriptions
	WHERE plan_id = 0
),
annual AS (
	SELECT customer_id, start_date
	FROM subscriptions
	WHERE plan_id = 3
),
bucket AS (
	SELECT
		CASE
			WHEN DATEDIFF(annual.start_date, trial.start_date) >= 0 AND DATEDIFF(annual.start_date, trial.start_date) <= 30
				THEN '0-30 Days'
			WHEN DATEDIFF(annual.start_date, trial.start_date) > 30 AND DATEDIFF(annual.start_date, trial.start_date) <= 60
				THEN '30-60 Days'
			WHEN DATEDIFF(annual.start_date, trial.start_date) > 60 AND DATEDIFF(annual.start_date, trial.start_date) <= 90
				THEN '60-90 Days'
			WHEN DATEDIFF(annual.start_date, trial.start_date) > 90 AND DATEDIFF(annual.start_date, trial.start_date) <= 120
				THEN '90-120 Days'
			WHEN DATEDIFF(annual.start_date, trial.start_date) > 120 AND DATEDIFF(annual.start_date, trial.start_date) <= 150
				THEN '120-150 Days'
			WHEN DATEDIFF(annual.start_date, trial.start_date) > 150 AND DATEDIFF(annual.start_date, trial.start_date) <= 180
				THEN '150-180 Days'
			WHEN DATEDIFF(annual.start_date, trial.start_date) > 180 AND DATEDIFF(annual.start_date, trial.start_date) <= 210
				THEN '180-210 Days'
			WHEN DATEDIFF(annual.start_date, trial.start_date) > 210 AND DATEDIFF(annual.start_date, trial.start_date) <= 240
				THEN '210-240 Days'
			WHEN DATEDIFF(annual.start_date, trial.start_date) > 240 AND DATEDIFF(annual.start_date, trial.start_date) <= 270
				THEN '240-270 Days'
			WHEN DATEDIFF(annual.start_date, trial.start_date) > 270 AND DATEDIFF(annual.start_date, trial.start_date) <= 300
				THEN '270-300 Days'
			WHEN DATEDIFF(annual.start_date, trial.start_date) > 300 AND DATEDIFF(annual.start_date, trial.start_date) <= 330
				THEN '300-330 Days'
			WHEN DATEDIFF(annual.start_date, trial.start_date) > 330 AND DATEDIFF(annual.start_date, trial.start_date) <= 360
				THEN '330-360 Days'
			ELSE 'NA'
		END AS Bins
	FROM trial 
	JOIN annual ON trial.customer_id = annual.customer_id
)
SELECT Bins, COUNT(*) AS Customers
FROM bucket
GROUP BY Bins
ORDER BY Bins;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

WITH trial_plan AS (
   SELECT
      customer_id,
      start_date AS trial_days
   FROM
      subscriptions
   WHERE
      plan_id = 0
),
annual_plan AS (
   SELECT
      customer_id,
      start_date AS annual_days
   FROM
      subscriptions
   WHERE
      plan_id = 3
),
cte AS (
   SELECT 
      FLOOR (DATEDIFF (annual_days, trial_days)/30 ) AS average_value
   FROM
      annual_plan
      JOIN trial_plan ON annual_plan.customer_id = trial_plan.customer_id
)
SELECT 
   concat(
      (average_value * 30),
      "-",
      ((average_value + 1) * 30),
      "days"
   ) AS breakdown,
   COUNT(*) AS customers
FROM
   cte
GROUP BY
   average_value
ORDER BY
   average_value;