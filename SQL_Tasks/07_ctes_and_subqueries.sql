-- ======================================================================
-- Topic: Subqueries and Common Table Expressions (CTEs)
-- Database: Northwind
-- ======================================================================
USE northwind;

-- 1. Output product names including the total ordered quantity for each product.

-- Approach A: Using a Common Table Expression (CTE)
WITH ProductTotals AS (
    SELECT product_id, SUM(quantity) AS total_quantity
    FROM order_details
    GROUP BY product_id
)
SELECT p.product_name, pt.total_quantity
FROM products p
JOIN ProductTotals pt ON p.id = pt.product_id;

-- Approach B: Using a Correlated Subquery
SELECT 
    product_name,
    (SELECT SUM(quantity) 
     FROM order_details od 
     WHERE od.product_id = p.id) AS total_quantity
FROM products p;

-- 2. Find all orders placed after the date of the very first order by customer 'Lee'.
SELECT *
FROM orders
WHERE order_date > (
    SELECT MIN(order_date)
    FROM orders
    WHERE customer_id IN (
        SELECT id 
        FROM customers 
        WHERE last_name = 'Lee' OR first_name = 'Lee'
    )
);

-- 3. Find all products that have the maximum target_level.
SELECT *
FROM products
WHERE target_level = (
    SELECT MAX(target_level) 
    FROM products
);
