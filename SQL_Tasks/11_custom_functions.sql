-- ======================================================================
-- Topic: User-Defined Functions (UDF)
-- Database: Custom (Edit Access)
-- ======================================================================

-- 1. Function to calculate the area of a circle.
-- Formula: S = π * r^2 (using the built-in PI() function)
DELIMITER //

CREATE FUNCTION calculate_circle_area(radius DECIMAL(10,5))
RETURNS DECIMAL(10,5)
DETERMINISTIC
BEGIN
    RETURN PI() * POWER(radius, 2); 
END //

DELIMITER ;

-- ======================================================================

-- 2. Function to calculate the hypotenuse of a right triangle.
-- Formula: c = √(a^2 + b^2) (Pythagorean theorem)
DELIMITER //

CREATE FUNCTION calculate_hypotenuse(side_a DECIMAL(10,2), side_b DECIMAL(10,2))
RETURNS DECIMAL(10,5)
DETERMINISTIC
BEGIN
    RETURN SQRT(POWER(side_a, 2) + POWER(side_b, 2)); 
END //

DELIMITER ;

-- ======================================================================
-- Example of how to call these functions (for the reviewer):
-- SELECT calculate_circle_area(5.5) AS circle_area;
-- SELECT calculate_hypotenuse(3.0, 4.0) AS hypotenuse_length;
