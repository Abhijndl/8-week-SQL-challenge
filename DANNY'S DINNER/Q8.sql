-- Q8. What is the total items and amount spent for each member before they became a member?

WITH cte AS (
    SELECT
        ms.customer_id,
        ms.join_date,
        mu.product_name,
        s.product_id,
        s.order_date,
        mu.price
    FROM
        members ms
        JOIN sales s ON ms.customer_id = s.customer_id
        JOIN menu mu ON s.product_id = mu.product_id
    WHERE
        s.order_date < ms.join_date
)
SELECT
    customer_id,
    SUM(price) AS TOTAL_SPENT,
    COUNT(product_id) AS TOTAL_ITEMS
FROM
    cte
GROUP BY
    customer_id
ORDER BY
    cte.customer_id;

