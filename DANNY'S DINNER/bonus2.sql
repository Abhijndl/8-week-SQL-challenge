# Bonus Questions Rank All The Things
WITH cte AS(
    SELECT
        s.customer_id AS CUSTOMER_NAME,
        s.order_date,
        mu.product_name,
        mu.price,
        CASE
            WHEN m.join_date IS NULL THEN 'N'
            WHEN s.order_date < m.join_date THEN 'N'
            ELSE 'Y'
        END AS MEMBER
    FROM
        sales s
        JOIN menu mu USING (product_id)
        LEFT JOIN members m USING(customer_id)
    ORDER BY
        s.customer_id,
        s.order_date,
        mu.product_name
)
SELECT
    *,
    CASE
        WHEN MEMBER = 'N' THEN NULL
        ELSE RANK() OVER(
            PARTITION BY CUSTOMER_NAME,
            MEMBER
            ORDER BY
                order_date
        )
    END AS ranking
FROM
    cte