# Which item was the most popular for each customer?

WITH cte AS(
    SELECT
        customer_id,
        product_id,
        COUNT(product_id) AS cn,
        ROW_NUMBER() OVER(
            PARTITION BY customer_id
            ORDER BY
                COUNT(product_id) desc
        ) AS rn
    FROM
        sales
    GROUP BY
        customer_id,
        product_id
    ORDER BY
        customer_id,
        cn desc
)
SELECT
    c.customer_id AS CUSTOMER_NAME,
    m.product_name AS MOST_POPULAR_ITEM,
    c.product_id AS ORDER_COUNT
FROM
    cte c
    INNER JOIN menu m ON c.product_id = m.product_id
WHERE
    rn = 1
ORDER BY
    CUSTOMER_NAME;