-- TODO: This query will return a table with the differences between the real 
-- and estimated delivery times by month and year. It will have different 
-- columns: month_no, with the month numbers going from 01 to 12; month, with 
-- the 3 first letters of each month (e.g. Jan, Feb); Year2016_real_time, with 
-- the average delivery time per month of 2016 (NaN if it doesn't exist); 
-- Year2017_real_time, with the average delivery time per month of 2017 (NaN if 
-- it doesn't exist); Year2018_real_time, with the average delivery time per 
-- month of 2018 (NaN if it doesn't exist); Year2016_estimated_time, with the 
-- average estimated delivery time per month of 2016 (NaN if it doesn't exist); 
-- Year2017_estimated_time, with the average estimated delivery time per month 
-- of 2017 (NaN if it doesn't exist) and Year2018_estimated_time, with the 
-- average estimated delivery time per month of 2018 (NaN if it doesn't exist).
-- HINTS
-- 1. You can use the julianday function to convert a date to a number.
-- 2. order_status == 'delivered' AND order_delivered_customer_date IS NOT NULL
-- 3. Take distinct order_id. 

SELECT month AS month_no,
                CASE 
                    WHEN a.month='01' THEN 'Jan'
                    WHEN a.month='02' THEN 'Feb'
                    WHEN a.month='03' THEN 'Mar'
                    WHEN a.month='04' THEN 'Apr'
                    WHEN a.month='05' THEN 'May'
                    WHEN a.month='06' THEN 'Jun'
                    WHEN a.month='07' THEN 'Jul'
                    WHEN a.month='08' THEN 'Aug'
                    WHEN a.month='09' THEN 'Sep'
                    WHEN a.month='10' THEN 'Oct'
                    WHEN a.month='11' THEN 'Nov'
                    WHEN a.month='12' THEN 'Dec'
                    ELSE 0
                END AS month,
                AVG(CASE 
                        WHEN a.year= '2016' THEN real_avg
                    END) AS Year2016_real_time,
                AVG(CASE 
                        WHEN a.year= '2017' THEN real_avg
                    END) AS Year2017_real_time,
                AVG(CASE 
                        WHEN a.year= '2018' THEN real_avg
                    END) AS Year2018_real_time,
                AVG(CASE 
                        WHEN a.year= '2016' THEN estimated_avg
                    END) AS Year2016_estimated_time,
                AVG(CASE 
                        WHEN a.year= '2017' THEN estimated_avg
                    END) AS Year2017_estimated_time,
                AVG(CASE 
                        WHEN a.year= '2018' THEN estimated_avg
                    END) AS Year2018_estimated_time
FROM
    (SELECT customer_id,
            order_id,
            order_delivered_customer_date,
            order_estimated_delivery_date,
            order_status,
            (JULIANDAY(order_delivered_customer_date)- 
                JULIANDAY(order_purchase_timestamp)) AS real_avg,
            (JULIANDAY(order_estimated_delivery_date)- 
            	JULIANDAY(order_purchase_timestamp)) AS estimated_avg,
            STRFTIME('%Y', order_purchase_timestamp) AS year,
            STRFTIME('%m', order_purchase_timestamp) AS month
     FROM olist_orders
     WHERE order_status= 'delivered' AND order_delivered_customer_date IS NOT NULL) a
GROUP BY month
ORDER BY month_no ASC