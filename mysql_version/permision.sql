-- Create Users
CREATE USER  warehouse_manager @ localhost  IDENTIFIED BY  password123 ;
CREATE USER  inventory_clerk @ localhost  IDENTIFIED BY  password123 ;
CREATE USER  logistics_manager @ localhost  IDENTIFIED BY  password123 ;
CREATE USER  auditor @ localhost  IDENTIFIED BY  password123 ;

-- Grant Permissions
-- Grant permissions to the warehouse manager
GRANT SELECT, INSERT, UPDATE, DELETE ON national_logistics_and_supply_chain.warehouse TO  warehouse_manager @ localhost ;
GRANT SELECT, INSERT, UPDATE, DELETE ON national_logistics_and_supply_chain.warehouse_product TO  warehouse_manager @ localhost ;

-- Grant permissions to the inventory clerk
GRANT SELECT, INSERT, UPDATE ON national_logistics_and_supply_chain.product TO  inventory_clerk @ localhost ;
GRANT SELECT, INSERT, UPDATE ON national_logistics_and_supply_chain.warehouse_product TO  inventory_clerk @ localhost ;

-- Grant permissions to the logistics manager
GRANT SELECT, INSERT, UPDATE, DELETE ON national_logistics_and_supply_chain.shipment TO  logistics_manager @ localhost ;
GRANT SELECT, INSERT, UPDATE, DELETE ON national_logistics_and_supply_chain.route TO  logistics_manager @ localhost ;

-- Grant read-only permissions to the auditor
GRANT SELECT ON national_logistics_and_supply_chain.* TO  auditor @ localhost ;

-- Revoke Permissions (Example)
-- Revoke DELETE permission from the inventory clerk
REVOKE DELETE ON national_logistics_and_supply_chain.product FROM  inventory_clerk @ localhost ;

-- Database Audit Implementation
-- Create an audit table to log changes
CREATE TABLE audit_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(50),
    operation_type VARCHAR(10),
    table_name VARCHAR(50),
    operation_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    details TEXT
);

-- Create a trigger to log INSERT operations on the  product  table
DELIMITER $$
CREATE TRIGGER after_product_insert
AFTER INSERT ON product
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (user_name, operation_type, table_name, details)
    VALUES (USER(),  INSERT ,  product , CONCAT( Inserted product_id:  , NEW.product_id,  , name:  , NEW.name));
END$$
DELIMITER ;

-- Create a trigger to log UPDATE operations on the  warehouse_product  table
DELIMITER $$
CREATE TRIGGER after_warehouse_product_update
AFTER UPDATE ON warehouse_product
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (user_name, operation_type, table_name, details)
    VALUES (USER(),  UPDATE ,  warehouse_product , CONCAT( Updated product_id:  , NEW.product_id,  , warehouse_id:  , NEW.warehouse_id,  , new quantity:  , NEW.quantity));
END$$
DELIMITER ;

-- Create a trigger to log DELETE operations on the  shipment  table
DELIMITER $$
CREATE TRIGGER after_shipment_delete
AFTER DELETE ON shipment
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (user_name, operation_type, table_name, details)
    VALUES (USER(),  DELETE ,  shipment , CONCAT( Deleted shipment_id:  , OLD.shipment_id));
END$$
DELIMITER ;

-- Example: View audit logs
SELECT * FROM audit_log;