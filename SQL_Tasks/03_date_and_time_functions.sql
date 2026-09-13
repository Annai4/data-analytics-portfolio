-- ======================================================================
-- Topic: Date and Time Functions, Type Casting, and String Formatting
-- Database: Northwind
-- ======================================================================
USE northwind;

-- 1. Get the date that is 100 days from the current date.
SELECT DATE_ADD(CURDATE(), INTERVAL 100 DAY) AS new_day;

-- 2. Select orders placed on weekends (Saturday and Sunday).
-- Note: DAYOFWEEK() returns 1 for Sunday and 7 for Saturday.
SELECT order_date 
FROM orders
WHERE DAYOFWEEK(order_date) IN (1, 7);

-- 3. Find the number of days left until the end of the current year.
SELECT DATEDIFF(DATE_FORMAT(CURDATE(), '%Y-12-31'), CURDATE()) AS days_left_in_year;

-- 4. Get the date that was 15 days ago from the current date.
SELECT DATE_SUB(CURDATE(), INTERVAL 15 DAY) AS fifteen_days_ago;

-- 5. Explicitly cast the 'id' column from the customers table to a string (CHAR).
SELECT CAST(id AS CHAR) AS id_string
FROM customers;

-- 6. Select all orders made between '01.03.2006' and '2006-04-21' 
-- using string-to-date conversion.
SELECT *
FROM orders
WHERE order_date BETWEEN STR_TO_DATE('01,03,2006', '%d,%m,%Y') 
                     AND STR_TO_DATE('2006:04-21', '%Y:%m-%d');

-- 7. Calculate your exact age in seconds using TIMESTAMPDIFF.
-- (DATEDIFF only returns days, so TIMESTAMPDIFF is required for seconds).
SELECT TIMESTAMPDIFF(SECOND, '1976-11-16', NOW()) AS seconds_lived;

-- 8. Get the exact date and time 51 days from now.
SELECT DATE_ADD(NOW(), INTERVAL 51 DAY) AS future_date;

-- 9. Find out the day of the week for the date exactly 51 days from now.
-- Instead of hardcoding a specific date, we nest the functions dynamically.
SELECT DAYOFWEEK(DATE_ADD(NOW(), INTERVAL 51 DAY)) AS future_day_of_week;

-- 10. Output the original transaction date and a new column adding 3 hours to it.
SELECT transaction_created_date, 
       DATE_ADD(transaction_created_date, INTERVAL 3 HOUR) AS transaction_plus_3h
FROM inventory_transactions;

-- 11. Generate a formatted text message for each order using CONCAT.
SELECT CONCAT('Customer with ID ', CAST(customer_id AS CHAR), ' placed an order on ', order_date) AS order_message
FROM orders;
