-- ======================================================================
-- Topic: CASE Statements, Window Functions vs GROUP BY, and Date Formatting
-- Database: Sakila
-- ======================================================================
USE sakila;

-- 1. Output film titles along with a full description of their rating using CASE.
SELECT title, rating,
    CASE rating
        WHEN 'G' THEN 'General Audiences. All ages admitted.'
        WHEN 'PG' THEN 'Parental Guidance Suggested. Some material may not be suitable for children.'
        WHEN 'PG-13' THEN 'Parents Strongly Cautioned. Some material may be inappropriate for children under 13.'
        WHEN 'R' THEN 'Restricted. Under 17 requires accompanying parent or adult guardian.'
        WHEN 'NC-17' THEN 'No One 17 and Under Admitted.'
        ELSE 'Not Rated'
    END AS rating_description
FROM film;

-- 2. Count the number of films in each rating category using GROUP BY.
SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;

-- 3. Output film titles, ratings, and the count of films per rating using Window Functions.
SELECT title, rating, 
       COUNT(*) OVER (PARTITION BY rating) AS films_in_rating_category
FROM film;

/* 
EXPLANATION (Window Functions vs GROUP BY):
- The GROUP BY query (Task 2) aggregates the data, collapsing all rows with the same rating into a single row. It changes the granularity of the output.
- The Window Function with PARTITION BY (Task 3) calculates the same aggregate count but retains every original row (every individual film). It simply appends the calculated count as a new column to the existing rows.
*/

-- 4. Output a list of all payments showing customer first and last name, payment date, and amount.
SELECT c.first_name, c.last_name, p.payment_date, p.amount
FROM payment p
JOIN customer c ON p.customer_id = c.customer_id;

-- 5. Modify the previous query to format the date as "DD, Month Name, YYYY" (without time).
SELECT c.first_name, c.last_name, 
       DATE_FORMAT(p.payment_date, '%d, %M, %Y') AS formatted_payment_date, 
       p.amount
FROM payment p
JOIN customer c ON p.customer_id = c.customer_id;
