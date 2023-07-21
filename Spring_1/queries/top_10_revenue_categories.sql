-- TODO: This query will return a table with the top 10 revenue categories in 
-- English, the number of orders and their total revenue. The first column will 
-- be Category, that will contain the top 10 revenue categories; the second one 
-- will be Num_order, with the total amount of orders of each category; and the 
-- last one will be Revenue, with the total revenue of each catgory.
-- HINT: All orders should have a delivered status and the Category and actual 
-- delivery date should be not null.

SELECT e.product_category_name_english AS Category, 
    COUNT(DISTINCT(c.order_id)) AS Num_order, 
    ROUND(SUM(c.payment_value), 2) AS Revenue
    FROM olist_products a
    INNER JOIN olist_order_items b
    ON a.product_id = b.product_id
    INNER JOIN olist_order_payments c
    ON b.order_id = c.order_id
    INNER JOIN olist_orders d
    ON d.order_id = c.order_id
    INNER JOIN product_category_name_translation e
    ON a.product_category_name = e.product_category_name
    WHERE d.order_delivered_customer_date IS NOT NULL
    AND d.order_status == 'delivered'
GROUP BY Category
ORDER BY Revenue  DESC
LIMIT 10;