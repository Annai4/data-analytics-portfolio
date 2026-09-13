-- ======================================================================
-- Topic: Stored Procedures and Functions (IN, OUT, INOUT parameters)
-- Database: HR 
-- ======================================================================

-- 1. Get the department ID for a specific employee.

-- Implementation A: Using a Function
DELIMITER //

CREATE FUNCTION get_department_by_employee_fn(emp_id INT)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE dep_id INT;
    SELECT department_id INTO dep_id FROM employees WHERE id = emp_id;
    RETURN dep_id;
END //

DELIMITER ;

-- Implementation B: Using a Stored Procedure
DELIMITER //

CREATE PROCEDURE get_department_by_employee_sp(IN emp_id INT)
BEGIN
    SELECT department_id FROM employees WHERE id = emp_id;
END //

DELIMITER ;

-- Example Call:
-- CALL get_department_by_employee_sp(9);

-- ======================================================================

-- 2. Create a stored procedure that takes an employee ID (IN) 
-- and returns their age via an OUT parameter.
DELIMITER //

CREATE PROCEDURE get_employee_age(IN emp_id INT, OUT age_emp INT)
BEGIN 
    SELECT age INTO age_emp FROM employees WHERE id = emp_id;
END //

DELIMITER ;
        
-- Example Call:
-- SET @age = 0;
-- CALL get_employee_age(9, @age);
-- SELECT @age; 	

-- ======================================================================

-- 3. Create a stored procedure that takes a salary (INOUT parameter) 
-- and decreases it by 10%.
DELIMITER //

CREATE PROCEDURE decrease_employee_salary(INOUT emp_salary DECIMAL(10, 2))
BEGIN
    SET emp_salary = emp_salary * 0.90; 
END //

DELIMITER ;

-- Example Call:
-- SET @current_salary = 50000; 
-- CALL decrease_employee_salary(@current_salary);
-- SELECT @current_salary;
