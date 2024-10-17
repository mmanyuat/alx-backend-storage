-- trigger for sql
DELIMITER $$

CREATE TRIGGER update_quantity_after_order
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    -- Decrease the quantity of the ordered item in the 'items' table
    UPDATE items
    SET quantity = quantity - NEW.number
    WHERE name = NEW.item_name;
END$$

DELIMITER ;
