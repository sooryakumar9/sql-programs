CREATE TABLE N_RollCall ( 
    id INT,
    name VARCHAR(255), 
    roll_no INT,
    present INT
);


INSERT INTO N_RollCall (id, name, roll_no, present) 
VALUES 
    (1, 'John', 101, 1),
    (2, 'Alice', 102, 1),
    (3, 'Bob', 103, 0),
    (4, 'Emily', 104, 1), (5, 'David', 105, 0);

CREATE TABLE O_RollCall ( 
    id INT,
    name VARCHAR(255), 
    roll_no INT,
    present INT
);

DELIMITER $$

CREATE PROCEDURE merge_data_from_n_to_o()
BEGIN
    DECLARE done BOOLEAN DEFAULT FALSE;
    DECLARE n_id INT;
    DECLARE n_name VARCHAR(255);
    DECLARE n_roll_no INT;
    DECLARE n_present INT;

    -- Declare a cursor for the N_RollCall table
    DECLARE n_cursor CURSOR FOR
        SELECT id, name, roll_no, present
        FROM N_RollCall;

    -- Declare a handler for no data found
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Open the cursor
    OPEN n_cursor;

    -- Loop to fetch data from the cursor
    fetch_loop: LOOP
        -- Fetch data into variables
        FETCH n_cursor INTO n_id, n_name, n_roll_no, n_present;

        -- Check if no more rows
        IF done THEN
            LEAVE fetch_loop;
        END IF;

        -- Check if data already exists in O_RollCall table
        IF NOT EXISTS (SELECT 1 FROM O_RollCall WHERE id = n_id) THEN
            -- If data does not exist, insert into O_RollCall table
            INSERT INTO O_RollCall (id, name, roll_no, present)
            VALUES (n_id, n_name, n_roll_no, n_present);
        END IF;
    END LOOP;

    -- Close the cursor
    CLOSE n_cursor;
END $$
DELIMITER ;

CALL merge_data_from_n_to_o(); 
SELECT * FROM O_RollCall;