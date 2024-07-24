-- Step 1: Create Employee table containing all Records E_id, E_name, Age, Salary
CREATE TABLE Employee (
    E_id INT PRIMARY KEY,
    E_name VARCHAR(50),
    Age INT,
    Salary DECIMAL(10, 2)
);

INSERT INTO Employee (E_id, E_name, Age, Salary) VALUES
    (1, 'John', 30, 50000),
    (2, 'Alice', 28, 45000),
    (3, 'Bob', 35, 60000),
    (4, 'Carol', 32, 55000),
    (5, 'David', 25, 40000);

-- Step 2: Count the number of employee names from the employee table
SELECT COUNT(E_name) 
AS num_employees 
FROM Employee;

-- Step 3: Find the maximum age from the employee table
SELECT MAX(Age) 
AS max_age 
FROM Employee;

-- Step 4: Find the minimum age from the employee table
SELECT MIN(Age) 
AS min_age 
FROM Employee;

-- Step 5: Find the salaries of employees in ascending order
SELECT Salary 
FROM Employee 
ORDER BY Salary ASC;

-- Step 6: Find grouped salaries of employees
SELECT Salary, COUNT(*) 
AS num_employees_with_salary 
FROM Employee
GROUP BY Salary;