-- 6. Which item was purchased first by the customer after they became a member?
WITH cte AS (
    SELECT
        a.customer_id,
        a.order_date,
        b.join_date,
        m.product_name,
        ROW_NUMBER() OVER(
            PARTITION BY a.customer_id
            ORDER BY
                a.order_date
        ) AS rn
    FROM
        sales a
        JOIN members b ON a.customer_id = b.customer_id
        JOIN menu m ON a.product_id = m.product_id
    WHERE
        a.order_date >= b.join_date
)
SELECT
    customer_id as Customer_Name,
    product_name
FROM
    cte
WHERE
    rn = 1;