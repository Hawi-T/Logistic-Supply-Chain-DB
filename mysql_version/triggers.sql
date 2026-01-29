-- Trigger to log updates to the  order  table
DELIMITER $$
CREATE TRIGGER after_order_update
AFTER UPDATE ON   order  
FOR EACH ROW
BEGIN
  INSERT INTO   tracking_log  (log_id, shipment_id, location, status, notes)
  VALUES (CONCAT( LOG , UUID()), NULL,  System ,  Order Updated , CONCAT( Order  , NEW.order_id,   was updated. ));
END$$
DELIMITER ;

-- Trigger to log inserts into the  shipment  table
DELIMITER $$
CREATE TRIGGER after_shipment_insert
AFTER INSERT ON  shipment 
FOR EACH ROW
BEGIN
  INSERT INTO  tracking_log  (log_id, shipment_id, location, status, notes)
  VALUES (CONCAT( LOG , UUID()), NEW.shipment_id,  Warehouse ,  Shipment Created , CONCAT( Shipment  , NEW.shipment_id,   was created. ));
END$$
DELIMITER ;

-- Trigger to handle deletions from the  customer  table
DELIMITER $$
CREATE TRIGGER before_customer_delete
BEFORE DELETE ON  customer 
FOR EACH ROW
BEGIN
  INSERT INTO  tracking_log  (log_id, shipment_id, location, status, notes)
  VALUES (CONCAT( LOG , UUID()), NULL,  System ,  Customer Deleted , CONCAT( Customer  , OLD.customer_id,   was deleted. ));
END$$
DELIMITER ;