CREATE TABLE Employee ( 
    E_id INT PRIMARY KEY, 
    E_name VARCHAR(255), 
    Age INT,
    Salary DECIMAL(10, 2) 
);

INSERT INTO Employee (E_id, E_name, Age, Salary) 
VALUES 
    (1, 'John Doe', 30, 50000.00),
    (2, 'Jane Smith', 25, 60000.00),
    (3, 'Jim Brown', 35, 70000.00);

DELIMITER //
CREATE PROCEDURE fetch_employee_data()
BEGIN
    -- Declare variables to store values from the cursor
    DECLARE emp_id INT;
    DECLARE emp_name VARCHAR(255);
    DECLARE emp_age INT;
    DECLARE emp_salary DECIMAL(10, 2);

    -- Declare a variable to indicate whether there are more rows to fetch
    DECLARE no_more_rows BOOLEAN DEFAULT FALSE;

    -- Declare a cursor for the Employee table
    DECLARE emp_cursor CURSOR FOR
        SELECT E_id, E_name, Age, Salary
        FROM Employee;

    -- Declare a NOT FOUND handler to exit loop when there are no more rows
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_more_rows = TRUE;

    -- Open the cursor
    OPEN emp_cursor;

    -- Loop to fetch values from the cursor
    employee_loop: LOOP
        -- Fetch values from the cursor into variables
        FETCH emp_cursor INTO emp_id, emp_name, emp_age, emp_salary;

        -- Check if there are no more rows to fetch
        IF no_more_rows THEN
            LEAVE employee_loop;
        END IF;

        -- Process the fetched values (you can perform any operations here)
        -- For example, you can print the values
        SELECT CONCAT('Employee ID: ', emp_id, ', 
                       Name: ', emp_name, ',
                       Age: ', emp_age, ', 
                       Salary: ', emp_salary 
        )AS output;
    END LOOP;

    -- Close the cursor
    CLOSE emp_cursor;
END //
DELIMITER ;

CALL fetch_employee_data();