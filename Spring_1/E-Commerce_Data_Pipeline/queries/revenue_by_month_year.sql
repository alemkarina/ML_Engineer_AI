-- TODO: This query will return a table with the revenue by month and year. It
-- will have different columns: month_no, with the month numbers going from 01
-- to 12; month, with the 3 first letters of each month (e.g. Jan, Feb);
-- Year2016, with the revenue per month of 2016 (0.00 if it doesn't exist);
-- Year2017, with the revenue per month of 2017 (0.00 if it doesn't exist) and
-- Year2018, with the revenue per month of 2018 (0.00 if it doesn't exist).
SELECT month AS month_no,
                CASE 
                    WHEN x.month='01' THEN 'Jan'
                    WHEN x.month='02' THEN 'Feb'
                    WHEN x.month='03' THEN 'Mar'
                    WHEN x.month='04' THEN 'Apr'
                    WHEN x.month='05' THEN 'May'
                    WHEN x.month='06' THEN 'Jun'
                    WHEN x.month='07' THEN 'Jul'
                    WHEN x.month='08' THEN 'Aug'
                    WHEN x.month='09' THEN 'Sep'
                    WHEN x.month='10' THEN 'Oct'
                    WHEN x.month='11' THEN 'Nov'
                    WHEN x.month='12' THEN 'Dec'
                END AS month,
                SUM(CASE 
                        WHEN x.year= '2016' THEN payment_value
                        ELSE 0
                    END) AS Year2016,
                SUM(CASE 
                        WHEN x.year= '2017' THEN payment_value
                        ELSE 0
                    END) AS Year2017,
                SUM(CASE 
                        WHEN x.year= '2018' THEN payment_value
                        ELSE 0
                    END) AS Year2018
FROM
    (SELECT customer_id,
            order_id,
            order_delivered_customer_date,
            order_status,
            strftime('%Y',order_delivered_customer_date) AS Year,
            strftime('%m',order_delivered_customer_date) AS Month,
            payment_value
     FROM olist_orders
     JOIN olist_order_payments USING (order_id)
     WHERE order_status= 'delivered'
         AND order_delivered_customer_date IS NOT NULL
     GROUP BY 2
     ORDER BY order_delivered_customer_date ASC) x
GROUP BY month
ORDER BY month_no ASC;