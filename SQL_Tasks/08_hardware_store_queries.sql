-- ======================================================================
-- Topic: Normalized Schema Queries (UNION, Subqueries, Aggregations)
-- Database: Computer Hardware Store
-- ======================================================================

-- 1. Find all records from the Printer table for color printers.
SELECT *
FROM printer
WHERE color = 'y';

-- 2. Find the model numbers and prices of all available products from maker 'B'.
SELECT model, price
FROM (
    SELECT laptop.model, laptop.price, product.maker
    FROM product
    JOIN laptop ON product.model = laptop.model
    UNION
    SELECT pc.model, pc.price, product.maker
    FROM product
    JOIN pc ON product.model = pc.model
    UNION
    SELECT printer.model, printer.price, product.maker
    FROM product
    JOIN printer ON product.model = printer.model
) AS all_products
WHERE maker = 'B';

-- 3. Find makers who produce PCs but do not produce Laptops.
SELECT DISTINCT maker
FROM product
WHERE type = 'PC'
  AND maker NOT IN (
      SELECT maker
      FROM product
      WHERE type = 'Laptop'
  );

-- 4. Find makers of PCs with a processor speed of at least 450 MHz.
SELECT DISTINCT product.maker
FROM product
JOIN pc ON product.model = pc.model
WHERE pc.speed >= 450;

-- 5. Find the average speed of all PCs.
SELECT AVG(speed) AS avg_speed
FROM pc;

-- 6. Find the average screen size of laptops for each maker.
SELECT product.maker, AVG(laptop.screen) AS avg_screen_size
FROM product
JOIN laptop ON product.model = laptop.model
GROUP BY product.maker;
