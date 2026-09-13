-- ======================================================================
-- Topic: Window Functions vs GROUP BY
-- Database: Northwind
-- ======================================================================
USE northwind;

-- 1. For each order (purchase_order_id), output the min, max, and avg unit_cost 
-- using Window Functions (retains all original rows).
SELECT 
    purchase_order_id, 
    quantity, 
    MIN(unit_cost) OVER (PARTITION BY purchase_order_id) AS min_cost_window,
    MAX(unit_cost) OVER (PARTITION BY purchase_order_id) AS max_cost_window,
    AVG(unit_cost) OVER (PARTITION BY purchase_order_id) AS avg_cost_window
FROM purchase_order_details;

-- 2. Return only unique rows from the previous query.
-- (This effectively mimics the result of a GROUP BY clause by using DISTINCT).
SELECT DISTINCT 
    purchase_order_id, 
    MIN(unit_cost) OVER (PARTITION BY purchase_order_id) AS min_cost_window,
    MAX(unit_cost) OVER (PARTITION BY purchase_order_id) AS max_cost_window,
    AVG(unit_cost) OVER (PARTITION BY purchase_order_id) AS avg_cost_window
FROM purchase_order_details;

-- Equivalent result using standard GROUP BY approach:
SELECT 
    purchase_order_id,
    MIN(unit_cost) AS min_cost,
    MAX(unit_cost) AS max_cost,
    AVG(unit_cost) AS avg_cost
FROM purchase_order_details
GROUP BY purchase_order_id;

-- 3. Calculate total product cost (quantity * unit_cost).

-- Approach A: Using Window Function and DISTINCT
SELECT DISTINCT 
    product_id, 
    SUM(quantity * unit_cost) OVER (PARTITION BY product_id) AS total_product_cost_window
FROM purchase_order_details;

-- Approach B: Using GROUP BY
SELECT 
    product_id, 
    SUM(quantity * unit_cost) AS total_product_cost
FROM purchase_order_details
GROUP BY product_id;

-- 4. Count orders partitioned by date_received and posted_to_inventory.
-- If the count is > 1 output '>1', else output '=1'.
SELECT 
    purchase_order_id, 
    date_received, 
    CASE 
        WHEN COUNT(purchase_order_id) OVER (PARTITION BY date_received, posted_to_inventory) > 1 THEN '>1' 
        ELSE '=1' 
    END AS order_count_status
FROM purchase_order_details;
