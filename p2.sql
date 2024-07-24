-- Step 1: Create Table Employee
CREATE TABLE Employee (
    EMPNO INT PRIMARY KEY,
    ENAME VARCHAR(50),
    JOB VARCHAR(50),
    MGR INT,
    SAL DECIMAL(10, 2)
);

-- Step 2: Add a column commission to the Employee table
ALTER TABLE Employee
ADD COLUMN commission DECIMAL(10, 2);

-- Step 3: Insert five records into the table
INSERT INTO Employee (EMPNO, ENAME, JOB, MGR, SAL, commission)
VALUES
    (101, 'John', 'Manager', 100, 50000, 1000),
    (102, 'Alice', 'Developer', 101, 40000, 500),
    (103, 'Bob', 'Analyst', 102, 35000, 200),
    (104, 'Carol', 'Designer', 103, 45000, 800),
    (105, 'David', 'Engineer', 101, 42000, 700);

-- Step 4: Update the column details of job
UPDATE Employee
SET JOB = 'Lead Developer'
WHERE ENAME = 'Alice';

-- Step 5: Rename the column MGR to manager_no
ALTER TABLE Employee
CHANGE COLUMN MGR manager_no INT;

-- Step 6: Delete the employee whose EMPNO is 105
DELETE FROM Employee
WHERE EMPNO = 105;