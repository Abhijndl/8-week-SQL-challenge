#3. What was the first item from the menu purchased by each customer?

WITH first_item AS (
    SELECT
        *,
        RANK() OVER(
            PARTITION BY customer_id
            ORDER BY
                order_date
        ) AS rn
    FROM
        sales
)
SELECT
    f.customer_id AS Customer_name,
    group_concat(distinct m.product_name) AS Product_Name
FROM
    first_item f
    INNER JOIN menu m ON f.product_id = m.product_id
WHERE
    rn = 1
GROUP BY
    f.customer_id;
