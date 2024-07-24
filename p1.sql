-- Step 1: Create a user and grant all permissions to the user
CREATE USER 'myuser'@'localhost' IDENTIFIED BY 'mypassword';
GRANT ALL PRIVILEGES ON *.* TO 'myuser'@'localhost';
FLUSH PRIVILEGES;

-- Step 2: Login to user account using command prompt
-- Command: mysql -u myuser -p

-- Step 3: Create database in the user account
CREATE DATABASE COMPANY;
USE COMPANY;

-- Step 4: Create Table Employee
CREATE TABLE Employee (
    EMPNO INT,
    ENAME VARCHAR(50),
    JOB VARCHAR(50),
    MANAGER_NO INT,
    SAL DECIMAL(10, 2),
    COMMISSION DECIMAL(10, 2)
);

-- Step 5: Insert three records into the Employee table and use rollback
START TRANSACTION;
INSERT INTO Employee (EMPNO, ENAME, JOB, MANAGER_NO, SAL, COMMISSION)
VALUES (1, 'John', 'Manager', 101, 50000, 1000);
INSERT INTO Employee (EMPNO, ENAME, JOB, MANAGER_NO, SAL, COMMISSION)
VALUES (2, 'Alice', 'Developer', 101, 40000, 500);
INSERT INTO Employee (EMPNO, ENAME, JOB, MANAGER_NO, SAL, COMMISSION)
VALUES (3, 'Bob', 'Analyst', 101, 35000, NULL);
ROLLBACK;

-- Step 6: Add primary key and not null constraints to the Employeetable
ALTER TABLE Employee
ADD CONSTRAINT PK_EMPLOYEE PRIMARY KEY (EMPNO);
ALTER TABLE Employee
MODIFY ENAME VARCHAR(50) NOT NULL,
MODIFY JOB VARCHAR(50) NOT NULL,
MODIFY MANAGER_NO INT NOT NULL,
MODIFY SAL DECIMAL(10, 2) NOT NULL;

-- Step 7: Attempt to insert null values into the Employee table and verify the result
-- This will result in an error because JOB is a NOT NULL column
INSERT INTO Employee (EMPNO, ENAME, JOB, MANAGER_NO, SAL, COMMISSION)
VALUES (4, 'Carol', NULL, 101, 45000, 700);