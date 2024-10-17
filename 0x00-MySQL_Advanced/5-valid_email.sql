-- 5-valid_email.sql
DELIMITER $$

CREATE TRIGGER reset_valid_email_after_email_change
BEFORE UPDATE ON users
FOR EACH ROW
BEGIN
    -- Check if the email is being changed
    IF NEW.email != OLD.email THEN
        -- Reset valid_email to 0 when the email is changed
        SET NEW.valid_email = 0;
    END IF;
END$$

DELIMITER ;
