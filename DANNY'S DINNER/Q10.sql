-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January

WITH cte AS (
    SELECT
        s.customer_id,
        CASE
            WHEN s.order_date BETWEEN m.join_date
            AND timestampadd(week, 1, m.join_date) THEN mu.price * 20
            WHEN s.product_id = 1 THEN mu.price * 20
            ELSE 10 * mu.price
        END AS POINTS
    FROM
        sales s
        JOIN members m ON s.customer_id = m.customer_id
        JOIN menu mu ON s.product_id = mu.product_id
    WHERE
        MONTH(s.order_date) = 1
)
SELECT
    customer_id As Customer_Name,
    SUM(points) AS Points
FROM
    cte
GROUP BY
    customer_id
ORDER BY 
	customer_id;
