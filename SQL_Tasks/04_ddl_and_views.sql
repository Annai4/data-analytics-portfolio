-- ======================================================================
-- Topic: Data Definition (DDL), Data Manipulation (DML), and Views
-- Skills: CREATE TABLE, INSERT, UPDATE, ALTER TABLE, CREATE VIEW
-- ======================================================================

-- 1. Create the Employees table with specific constraints:
-- EmployeeID (Primary Key, Auto Increment)
-- FirstName, LastName (Varchar 50, Not Null)
-- BirthDate (Date)
-- HireDate (Datetime, Default to Current Timestamp)
-- Salary (Decimal 10,2, Check > 0)
-- Email (Varchar 100, Unique)

CREATE TABLE Employees (
    EmployeeID INTEGER AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    BirthDate DATE,
    HireDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Salary DECIMAL(10, 2) CHECK (Salary > 0),
    Email VARCHAR(100) UNIQUE
);

-- 2. Insert sample data into the Employees table
INSERT INTO Employees (LastName, FirstName, BirthDate, Salary, Email) 
VALUES 
('Ivanovich', 'Illia', '1999-03-16', 1150.15, 'illia.mega@gmail.com'),
('Petrov', 'Sergii', '1985-12-12', 1090.88, 'marta.moja@gmail.com');

INSERT INTO Employees (LastName, FirstName, BirthDate, HireDate, Salary, Email) 
VALUES 
('Zhukova', 'Maria', '1975-05-18', '2024-11-02', 1980.45, 'zvezda.mega@gmail.com'),
('Vetrova', 'Sonia', '1981-10-14', '2024-09-02', 1090.88, 'urta.nova_36@gmail.com');

-- 3. Create a new table by copying a subset of data from the Employees table
CREATE TABLE Employees_new AS 
SELECT * 
FROM Employees 
LIMIT 2;

-- 4. Update the salary for a specific employee
UPDATE Employees
SET Salary = 65000
WHERE EmployeeID = 2;

-- 5. Increase the salary by 10% for all employees hired in or after 2024
UPDATE Employees
SET Salary = Salary * 1.10
WHERE HireDate >= '2024-01-01';

-- 6. Create views based on the Employees table
-- View 1: All columns
CREATE VIEW Employees_view_1 AS
SELECT * 
FROM Employees;

-- View 2: Only EmployeeID and FirstName
CREATE VIEW Employees_view_2 AS 
SELECT EmployeeID, FirstName
FROM Employees;

-- Modify data to demonstrate that views reflect underlying table changes dynamically
UPDATE Employees
SET FirstName = 'Alisia'
WHERE EmployeeID = 4;

-- ======================================================================
-- Part 2: Weather Data Tracking
-- ======================================================================

-- 7. Create a Weather table to track local weather data for the last 5 days
CREATE TABLE Weather ( 
    Id INTEGER AUTO_INCREMENT PRIMARY KEY,
    RecordDate DATE NOT NULL CHECK (RecordDate >= '2025-05-10'),
    DayTemp INTEGER CHECK (DayTemp BETWEEN -50 AND 50),
    NightTemp INTEGER CHECK (NightTemp BETWEEN -50 AND 50),
    WindSpeed DECIMAL(4,1) CHECK (WindSpeed >= 0)
);

-- 8. Insert weather records
INSERT INTO Weather (RecordDate, DayTemp, NightTemp, WindSpeed)
VALUES 
  ('2025-05-12', 10, 3, 3.1),
  ('2025-05-13', 4, -2, 0.3),
  ('2025-05-14', 3, -3, 5.8),
  ('2025-05-15', 6, 1, 7.0),
  ('2025-05-16', 8, 2, 9.5);
        
-- 9. Alter the table to add a comment explaining the WindSpeed unit
ALTER TABLE Weather
MODIFY COLUMN WindSpeed DECIMAL(4,1) COMMENT 'Speed in m/s' CHECK (WindSpeed >= 0);

-- 10. Update night temperature conditionally (increase by 1 if wind speed < 3)
UPDATE Weather
SET NightTemp = NightTemp + 1
WHERE WindSpeed < 3;

-- 11. Create a comprehensive view with calculated columns and conditionals
CREATE VIEW WeatherView AS 
SELECT *, 
       (DayTemp + NightTemp) / 2 AS AverageTemp,
       CASE
           WHEN WindSpeed < 2 THEN 'Calm'
           WHEN WindSpeed >= 2 AND WindSpeed < 5 THEN 'Moderate breeze'
           ELSE 'Strong wind'
       END AS WindDescription
FROM Weather;
