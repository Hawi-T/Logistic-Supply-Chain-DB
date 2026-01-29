-- Create a logging table to store operation logs
CREATE TABLE operation_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(50),
    operation_type VARCHAR(10),
    table_name VARCHAR(50),
    operation_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    details TEXT
);

-- Trigger to log INSERT operations on the  product  table
DELIMITER $$
CREATE TRIGGER log_product_insert
AFTER INSERT ON product
FOR EACH ROW
BEGIN
    INSERT INTO operation_log (user_name, operation_type, table_name, details)
    VALUES (USER(),  INSERT ,  product , CONCAT( Inserted product_id:  , NEW.product_id,  , name:  , NEW.name));
END$$
DELIMITER ;

-- Trigger to log UPDATE operations on the  warehouse_product  table
DELIMITER $$
CREATE TRIGGER log_warehouse_product_update
AFTER UPDATE ON warehouse_product
FOR EACH ROW
BEGIN
    INSERT INTO operation_log (user_name, operation_type, table_name, details)
    VALUES (USER(),  UPDATE ,  warehouse_product , CONCAT( Updated product_id:  , NEW.product_id,  , warehouse_id:  , NEW.warehouse_id,  , new quantity:  , NEW.quantity));
END$$
DELIMITER ;

-- Trigger to log DELETE operations on the  shipment  table
DELIMITER $$
CREATE TRIGGER log_shipment_delete
AFTER DELETE ON shipment
FOR EACH ROW
BEGIN
    INSERT INTO operation_log (user_name, operation_type, table_name, details)
    VALUES (USER(),  DELETE ,  shipment , CONCAT( Deleted shipment_id:  , OLD.shipment_id));
END$$
DELIMITER ;

-- Example: View logs
SELECT * FROM operation_log;