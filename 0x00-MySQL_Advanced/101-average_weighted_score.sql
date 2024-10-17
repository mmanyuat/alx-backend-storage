-- the last task
DROP PROCEDURE IF EXISTS ComputeAverageWeightedScoreForUsers;

DELIMITER $$

CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
    -- Declare variables to hold total score and total weight for calculation
    DECLARE total_score FLOAT;
    DECLARE total_weight INT;

    -- Declare cursor to iterate through all users
    DECLARE user_id INT;
    DECLARE finished INT DEFAULT 0;
    DECLARE user_cursor CURSOR FOR SELECT id FROM users;
    
    -- Handler for when there are no more rows to fetch from the cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
    
    -- Open the cursor
    OPEN user_cursor;

    -- Loop through each user
    read_loop: LOOP
        -- Fetch user ID
        FETCH user_cursor INTO user_id;
        
        -- If finished, exit the loop
        IF finished THEN
            LEAVE read_loop;
        END IF;

        -- Calculate the total score and total weight for the current user
        SELECT SUM(c.score * p.weight), SUM(p.weight)
        INTO total_score, total_weight
        FROM corrections c
        JOIN projects p ON c.project_id = p.id
        WHERE c.user_id = user_id;
        
        -- If total_weight is not zero, calculate and update average score
        IF total_weight > 0 THEN
            UPDATE users
            SET average_score = total_score / total_weight
            WHERE id = user_id;
        END IF;
    END LOOP;

    -- Close the cursor
    CLOSE user_cursor;
END $$

DELIMITER ;
