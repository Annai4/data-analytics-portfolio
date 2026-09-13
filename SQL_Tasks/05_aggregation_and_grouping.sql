-- ======================================================================
-- Topic: Data Aggregation and Grouping (GROUP BY, Aggregate Functions)
-- Databases: HR, World, Northwind
-- ======================================================================

-- ======================================================================
-- Part 1: HR Database
-- ======================================================================
USE hr;

-- 1. Find the maximum salary in each department.
SELECT department_id, MAX(salary) AS max_salary
FROM employees
GROUP BY department_id;

-- 2. Count the total number of employees and the number of unique departments.
SELECT COUNT(employee_id) AS total_employees, 
       COUNT(DISTINCT department_id) AS unique_departments
FROM employees;

-- ======================================================================
-- Part 2: World Database
-- ======================================================================
USE world;

-- 3. Calculate the average population for cities in Brazil (CountryCode = 'BRA').
SELECT CountryCode, ROUND(AVG(Population)) AS avg_population
FROM city
WHERE CountryCode = 'BRA'
GROUP BY CountryCode;

-- ======================================================================
-- Part 3: Northwind Database
-- ======================================================================
USE northwind;

-- 4. Calculate key statistics (average, sum, min, max) for the unit_cost column.
SELECT AVG(unit_cost) AS avg_unit_cost, 
       SUM(unit_cost) AS sum_unit_cost, 
       MAX(unit_cost) AS max_unit_cost, 
       MIN(unit_cost) AS min_unit_cost
FROM purchase_order_details;

-- 5. Count the number of unique purchase orders.
SELECT COUNT(DISTINCT purchase_order_id) AS unique_orders_count
FROM purchase_order_details;

-- 6. Count the number of products per order. Sort the results in descending order.
SELECT purchase_order_id, COUNT(product_id) AS product_count
FROM purchase_order_details
GROUP BY purchase_order_id
ORDER BY product_count DESC;

-- 7. Count orders by delivery date (date_received), including only items where quantity > 30.
SELECT date_received, COUNT(purchase_order_id) AS order_count
FROM purchase_order_details  
WHERE quantity > 30
GROUP BY date_received;

-- 8. Calculate the total cost of orders per date. (Total cost = quantity * unit_cost).
SELECT date_received, SUM(quantity * unit_cost) AS total_cost
FROM purchase_order_details
GROUP BY date_received;

-- 9. Group items by unit_cost and calculate the average and max quantity 
-- for orders with purchase_order_id <= 100.
SELECT unit_cost, 
       AVG(quantity) AS avg_quantity, 
       MAX(quantity) AS max_quantity
FROM purchase_order_details
WHERE purchase_order_id <= 100
GROUP BY unit_cost;

-- 10. Categorize items by unit_cost ('Expensive' if > 20, else 'Others').
-- Filter out rows where inventory_id is NULL, and count products per category.
SELECT  
  CASE 
    WHEN unit_cost > 20 THEN 'Expensive'
    ELSE 'Others'
  END AS category,
  COUNT(product_id) AS product_count
FROM purchase_order_details
WHERE inventory_id IS NOT NULL
GROUP BY category;
