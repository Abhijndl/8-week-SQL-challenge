-- If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?

WITH update_price AS (
    SELECT
        c.customer_id,
        CASE
            WHEN m.product_name IN ('curry', 'ramen') THEN m.price * 10
            ELSE m.price * 20
        END AS PRICE_UPDATE
    FROM
        menu m
        INNER JOIN sales c ON m.product_id = c.product_id
)
SELECT
    customer_id AS CUSTOMER_NAME,
    SUM(PRICE_UPDATE) AS TOTAL_POINTS
FROM
    update_price
GROUP BY
    customer_id;