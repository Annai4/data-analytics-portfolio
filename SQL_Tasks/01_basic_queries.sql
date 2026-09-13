-- ======================================================================
-- Topic: Basic SQL Queries (Selection, Filtering, Logical Operators)
-- Database: Northwind
-- ======================================================================

-- 1. Select all rows from the suppliers table.
SELECT *
FROM suppliers;

-- 2. Select only those rows from the suppliers table where company is 'Supplier A'.
SELECT *
FROM suppliers
WHERE company = 'Supplier A';

-- 3. Select all rows from the purchase_orders table.
SELECT *
FROM purchase_orders;

-- 4. Select only those rows from the purchase_orders table where supplier_id = 2.
SELECT *
FROM purchase_orders
WHERE supplier_id = 2;

-- 5. Select supplier_id and shipping_fee from purchase_orders where created_by is 1 and supplier_id is 5.
-- Note: Column names are written without single quotes; quotes are only needed for text values.
SELECT supplier_id, shipping_fee
FROM purchase_orders 
WHERE created_by = 1 AND supplier_id = 5;

-- 6. Select last_name and first_name from the employees table where the address is '123 2nd Avenue' or '123 8th Avenue'. 

-- Method 1: Using the OR operator
SELECT last_name, first_name
FROM employees 
WHERE address = '123 2nd Avenue' OR address = '123 8th Avenue';

-- Method 2: Using the IN operator
SELECT last_name, first_name
FROM employees
WHERE address IN ('123 2nd Avenue', '123 8th Avenue');

-- 7. Output all employee names that contain the letter 'p' in the middle of their last name.
SELECT last_name, first_name
FROM employees
WHERE last_name LIKE '%p%';

-- 8. Select all rows from the orders table where there is no information about shipper_id (value is NULL).
SELECT *
FROM orders
WHERE shipper_id IS NULL;
