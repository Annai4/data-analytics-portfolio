-- ======================================================================
-- Topic: Advanced Window Functions (LAG, LEAD, FIRST_VALUE, RANK)
-- Database: Northwind
-- ======================================================================
USE northwind;

-- 1. For each product_id, output the current inventory_id along with the 
-- previous and next inventory_id based on quantity in descending order.
SELECT 
    product_id, 
    inventory_id, 
    quantity,
    LAG(inventory_id) OVER (PARTITION BY product_id ORDER BY quantity DESC) AS prev_inv_id,
    LEAD(inventory_id) OVER (PARTITION BY product_id ORDER BY quantity DESC) AS next_inv_id
FROM order_details;

-- 2. Find the minimum and maximum unit_price for each order_id using FIRST_VALUE.
SELECT DISTINCT
    order_id,
    FIRST_VALUE(unit_price) OVER(PARTITION BY order_id ORDER BY unit_price ASC) AS min_price_first_val,
    FIRST_VALUE(unit_price) OVER(PARTITION BY order_id ORDER BY unit_price DESC) AS max_price_first_val
FROM order_details;

-- 3. Calculate the difference between the current unit_price and the minimum 
-- unit_price within the same order. Solve using two methods (MIN and FIRST_VALUE).

-- Approach A: Using MIN()
SELECT 
    order_id, 
    unit_price,
    (unit_price - MIN(unit_price) OVER (PARTITION BY order_id)) AS price_diff_min
FROM order_details;

-- Approach B: Using FIRST_VALUE()
SELECT 
    order_id, 
    unit_price,
    (unit_price - FIRST_VALUE(unit_price) OVER (PARTITION BY order_id ORDER BY unit_price ASC)) AS price_diff_first_val
FROM order_details;

-- 4. Assign a rank to each row based on quantity in descending order using RANK().
SELECT 
    order_id, 
    quantity,
    RANK() OVER (ORDER BY quantity DESC) AS quantity_rank
FROM order_details;

-- 5. Using the previous query as a subquery, filter the results 
-- to show only the top 10 ranked rows.
SELECT *
FROM (
    SELECT 
        order_id, 
        quantity,
        RANK() OVER (ORDER BY quantity DESC) AS quantity_rank
    FROM order_details
) AS ranked_orders
WHERE quantity_rank <= 10;
