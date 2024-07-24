-- Create Customers table containing all Records ID, NAME, AGE, ADDRESS, SALARY
CREATE TABLE CUSTOMERS (
    ID INT PRIMARY KEY,
    NAME VARCHAR(255),
    AGE INT,
    ADDRESS VARCHAR(255),
    SALARY DECIMAL(10, 2)
);

INSERT INTO CUSTOMERS (ID, NAME, AGE, ADDRESS, SALARY) VALUES
(1, 'John Doe', 30, '123 Elm St', 50000.00),
(2, 'Jane Smith', 25, '456 Oak St', 60000.00),
(3, 'Jim Brown', 35, '789 Pine St', 70000.00);


-- Trigger for INSERT Operation
DELIMITER //
CREATE TRIGGER salary_difference_trigger_after_insert
AFTER INSERT ON CUSTOMERS
FOR EACH ROW
BEGIN
    DECLARE new_salary DECIMAL(10, 2);
    SET new_salary = NEW.SALARY;
    SELECT CONCAT('New record inserted. ID: ', NEW.ID, ', Name: ',
    NEW.NAME, ', Age: ', NEW.AGE, ', Address: ', NEW.ADDRESS, ', Salary: ',
    new_salary) INTO @output;
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @output;
END //
DELIMITER ;

INSERT INTO CUSTOMERS (ID, NAME, AGE, ADDRESS, SALARY) VALUES 
    (4, 'Alice Johnson', 28, '321 Maple St', 55000.00);
-- Expected output:
-- ERROR 1644 (45000): New record inserted. ID: 4, Name: Alice Johnson, Age: 28, Address: 321 Maple St, Salary: 55000.00

-- Trigger for UPDATE Operation
ELIMITER //
CREATE TRIGGER salary_difference_trigger_after_update
AFTER UPDATE ON CUSTOMERS
FOR EACH ROW
BEGIN
    DECLARE old_salary DECIMAL(10, 2);
    DECLARE new_salary DECIMAL(10, 2);
    DECLARE salary_diff DECIMAL(10, 2);
    SET old_salary = OLD.SALARY;
    SET new_salary = NEW.SALARY;
    SET salary_diff = new_salary - old_salary;
    SELECT CONCAT('Salary updated. ID: ', NEW.ID, ', Old Salary: ',
old_salary, ', New Salary: ', new_salary, ', Salary Difference: ',
salary_diff) INTO @output;
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @output;
END //
DELIMITER ;

UPDATE CUSTOMERS SET SALARY = 65000.00 WHERE ID = 2;

-- Expected output:
-- ERROR 1644 (45000): Salary updated. ID: 2, Old Salary: 60000.00, New Salary: 65000.00, Salary Difference: 5000.00

-- Trigger for DELETE Operation
DELIMITER //
CREATE TRIGGER salary_difference_trigger_after_delete
AFTER DELETE ON CUSTOMERS
FOR EACH ROW
BEGIN
    DECLARE old_salary DECIMAL(10, 2);
    SET old_salary = OLD.SALARY;
    SELECT CONCAT('Record deleted. ID: ', OLD.ID, ', Name: ', OLD.NAME,
    ', Age: ', OLD.AGE, ', Address: ', OLD.ADDRESS, ', Salary: ',
    old_salary) INTO @output;
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @output;
END //
DELIMITER ;


DELETE FROM CUSTOMERS WHERE ID = 1;
-- Expected output:
-- ERROR 1644 (45000): Record deleted. ID: 1, Name: John Doe, Age: 30, Address: 123 Elm St, Salary: 50000.0