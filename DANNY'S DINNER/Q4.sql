-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?

WITH count_product AS (
    SELECT
        product_id,
        COUNT(1) AS COUNT_OF_EACH_PRODUCT_SOLD
    FROM
        sales
    GROUP BY
        product_id
)
SELECT
    m.product_name AS MOST_PURCHASED_ITEM,
    cp.COUNT_OF_EACH_PRODUCT_SOLD AS TIMES_PURCHASED
FROM
    menu m
    INNER JOIN count_product cp ON m.product_id = cp.product_id
    order by TIMES_PURCHASED desc
    limit 1;