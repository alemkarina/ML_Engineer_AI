-- TODO: This query will return a table with two columns; customer_state, and 
-- Revenue. The first one will have the letters that identify the top 10 states 
-- with most revenue and the second one the total revenue of each.
-- HINT: All orders should have a delivered status and the actual delivery date 
-- should be not null. 

SELECT a.customer_state, 
    ROUND(SUM(c.payment_value), 2) AS Revenue
    FROM olist_customers a
    INNER JOIN olist_orders b
    ON a.customer_id = b.customer_id
    INNER JOIN olist_order_payments c 
    ON b.order_id = c.order_id
    WHERE b.order_delivered_customer_date IS NOT NULL
    AND b.order_status == 'delivered'
GROUP BY a.customer_state
ORDER BY Revenue  DESC
LIMIT 10;