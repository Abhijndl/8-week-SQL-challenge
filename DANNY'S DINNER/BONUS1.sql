# Bonus Questions Join All The Things

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
    mu.product_name;