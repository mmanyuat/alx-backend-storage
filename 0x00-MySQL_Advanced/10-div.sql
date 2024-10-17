-- Create the SafeDiv function
DROP FUNCTION IF EXISTS SafeDiv;

DELIMITER $$

CREATE FUNCTION SafeDiv(a INT, b INT)
RETURNS FLOAT
DETERMINISTIC
BEGIN
    -- Check if the second argument (b) is zero
    IF b = 0 THEN
        -- Return 0 if b is zero
        RETURN 0;
    ELSE
        -- Return the result of the division if b is not zero
        RETURN a / b;
    END IF;
END $$

DELIMITER ;
