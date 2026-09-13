-- ======================================================================
-- Topic: Combining Data (UNION, INNER JOIN, LEFT JOIN, RIGHT JOIN)
-- Database: Northwind
-- ======================================================================
USE northwind;

-- ======================================================================
-- Part 1: UNION Operations
-- ======================================================================

-- 1. Combine first and last names of customers and employees into a single list.
SELECT last_name, first_name
FROM employees
UNION ALL
SELECT last_name, first_name
FROM customers
ORDER BY last_name;

-- 2. Add a 'role' column to distinguish between employees and customers in the combined list.
SELECT last_name, first_name, 'Customer' AS role
FROM customers
UNION ALL
SELECT last_name, first_name, 'Employee' AS role
FROM employees
ORDER BY last_name;

-- 3. Combine company names from employees, customers, and suppliers using UNION.
-- (UNION automatically removes duplicates, unlike UNION ALL).
SELECT company, 'Employee' AS source
FROM employees
UNION 
SELECT company, 'Customer' AS source
FROM customers
UNION 
SELECT company, 'Supplier' AS source
FROM suppliers;

-- 4. Combine IDs and employee IDs from orders and purchase_orders.
-- (In purchase_orders, 'created_by' corresponds to the employee).
-- Exclude NULL values and add a source table column.
SELECT id, employee_id, 'orders' AS source_table
FROM orders
WHERE employee_id IS NOT NULL
UNION                                                                    
SELECT id, created_by, 'purchase_orders' AS source_table
FROM purchase_orders
WHERE created_by IS NOT NULL;

-- ======================================================================
-- Part 2: JOIN Operations
-- ======================================================================

-- 5. Demonstrate INNER, LEFT, and RIGHT JOINs between employees and their privileges.
-- INNER JOIN: Only employees with privileges.
SELECT e.first_name, e.last_name, ep.privilege_id
FROM employees e
INNER JOIN employee_privileges ep ON e.id = ep.employee_id;

-- RIGHT JOIN: All privileges, matching employees if they exist.
SELECT e.first_name, e.last_name, ep.privilege_id
FROM employees e
RIGHT JOIN employee_privileges ep ON e.id = ep.employee_id;

-- LEFT JOIN (Anti-Join): Find employees who DO NOT have any privileges.
SELECT e.last_name, e.first_name 
FROM employees e
LEFT JOIN employee_privileges ep ON e.id = ep.employee_id
WHERE ep.employee_id IS NULL;

-- 6. Output order details along with the actual product names instead of just product_id.
SELECT od.order_id, od.product_id, p.product_name
FROM order_details od
LEFT JOIN products p ON p.id = od.product_id;

-- 7. Count the number of orders for each product name using the previous join.
SELECT od.product_id, p.product_name, COUNT(od.order_id) AS order_count
FROM order_details od
LEFT JOIN products p ON p.id = od.product_id
GROUP BY od.product_id, p.product_name
ORDER BY order_count DESC;

-- 8. Join order details with products and purchase orders.
SELECT od.order_id, p.product_name, po.payment_amount
FROM order_details od
LEFT JOIN products p ON od.product_id = p.id
LEFT JOIN purchase_orders po ON od.purchase_order_id = po.id;

-- 9. Join inventory_transactions with transaction types and product names.
SELECT it.transaction_created_date, p.product_name, itt.type_name
FROM inventory_transactions it
JOIN inventory_transaction_types itt ON itt.id = it.transaction_type
JOIN products p ON p.id = it.product_id;

-- 10. Output all columns from order_details with the payment_method from purchase_orders.
-- Only include orders where payment_method is known.
SELECT od.*, po.payment_method
FROM order_details od
INNER JOIN purchase_orders po ON od.purchase_order_id = po.id
WHERE po.payment_method IS NOT NULL; 

-- 11. Find orders and customer last names specifically for orders that have invoices.
SELECT o.*, c.last_name
FROM orders o
INNER JOIN customers c ON o.customer_id = c.id
INNER JOIN invoices i ON i.order_id = o.id; 

-- 12. Count the number of invoices for each customer based on the previous query.
SELECT c.last_name, COUNT(i.id) AS invoice_count
FROM orders o
INNER JOIN customers c ON o.customer_id = c.id
INNER JOIN invoices i ON i.order_id = o.id
GROUP BY c.last_name;
