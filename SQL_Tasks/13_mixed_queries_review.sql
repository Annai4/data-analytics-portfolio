-- ======================================================================
-- Topic: Mixed Queries (Filtering, Date Math, Aggregation, Joins)
-- Database: Northwind
-- ======================================================================
USE northwind;

-- 1. Select only those rows from the suppliers table where the company is 'Supplier A'.
SELECT * 
FROM suppliers 
WHERE company = 'Supplier A';

-- 2. Output all rows where purchase_order_id is missing (NULL). 
-- Add a calculated column 'total_price' (quantity * unit_cost).
SELECT *, (quantity * unit_cost) AS total_price
FROM purchase_order_details
WHERE purchase_order_id IS NULL;

-- 3. Calculate the date that is exactly 51 days from the current date.
SELECT DATE_ADD(CURDATE(), INTERVAL 51 DAY) AS future_date;

-- 4. Count the total number of unique purchase orders.
SELECT COUNT(DISTINCT purchase_order_id) AS unique_orders_count
FROM purchase_order_details;

-- 5. Output all columns from order_details along with the payment_method from purchase_orders.
-- Include only orders where the payment_method is known.
SELECT od.*, po.payment_method 
FROM order_details AS od
LEFT JOIN orders AS ord ON od.order_id = ord.id
LEFT JOIN inventory_transactions AS inv_tran ON ord.id = inv_tran.customer_order_id
LEFT JOIN purchase_orders AS po ON inv_tran.customer_order_id = po.id
WHERE po.payment_method IS NOT NULL;
