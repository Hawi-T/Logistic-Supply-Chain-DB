-- Transaction 1: Add new stock to a warehouse
START TRANSACTION;
UPDATE warehouse_product 
SET quantity = quantity + 100 
WHERE warehouse_id = 'W001' AND product_id = 'P001';
COMMIT;

-- Transaction 2: Remove stock from a warehouse for shipment
START TRANSACTION;
UPDATE warehouse_product 
SET quantity = quantity - 50 
WHERE warehouse_id = 'W001' AND product_id = 'P001';
INSERT INTO shipment (shipment_id, status, route_id, departure_time, total_weight, total_cost) 
VALUES ('S001', 'In Transit', 'R001', NOW(), 500.00, 1000.00);
COMMIT;

-- Transaction 3: Transfer stock between warehouses
START TRANSACTION;
UPDATE warehouse_product 
SET quantity = quantity - 30 
WHERE warehouse_id = 'W001' AND product_id = 'P002';
UPDATE warehouse_product 
SET quantity = quantity + 30 
WHERE warehouse_id = 'W002' AND product_id = 'P002';
COMMIT;

-- Transaction 4: Add a new product to inventory
START TRANSACTION;
INSERT INTO product (product_id, name, description, weight, hs_code, category, storage_type, price) 
VALUES ('P010', 'New Product', 'A new electronic product', 5.00, '123456', 'Electronics', 'Dry', 150.00);
INSERT INTO warehouse_product (warehouse_id, product_id, quantity) 
VALUES ('W001', 'P010', 200);
COMMIT;

-- Transaction 5: Process a customer order
START TRANSACTION;
INSERT INTO orders (order_id, order_date, customer_id, status, total_amount) 
VALUES ('O001', CURDATE(), 'C001', 'Processing', 1500.00);
INSERT INTO order_item (order_item_id, quantity, unit_price, product_id, order_id) 
VALUES ('OI001', 10, 150.00, 'P001', 'O001');
UPDATE warehouse_product 
SET quantity = quantity - 10 
WHERE warehouse_id = 'W001' AND product_id = 'P001';
COMMIT;

-- Transaction 6: Return a product
START TRANSACTION;
INSERT INTO returns (return_id, order_id, customer_id, return_date, reason, status, refund_amount) 
VALUES ('R001', 'O001', 'C001', CURDATE(), 'Damaged product', 'Processed', 1500.00);
UPDATE warehouse_product 
SET quantity = quantity + 10 
WHERE warehouse_id = 'W001' AND product_id = 'P001';
COMMIT;

-- Transaction 7: Update warehouse capacity
START TRANSACTION;
UPDATE warehouse 
SET capacity = capacity + 500 
WHERE warehouse_id = 'W001';
COMMIT;

-- Transaction 8: Assign a driver to a vehicle
START TRANSACTION;
INSERT INTO vehicle_driver (vehicle_id, driver_id, assignment_date) 
VALUES ('V001', 'D001', CURDATE());
COMMIT;

-- Transaction 9: Update shipment status
START TRANSACTION;
UPDATE shipment 
SET status = 'Delivered', actual_arrival = NOW() 
WHERE shipment_id = 'S001';
COMMIT;

-- Transaction 10: Add a new supplier
START TRANSACTION;
INSERT INTO supplier (supplier_id, name, address, contact_number, email, contract_terms, reliability_score) 
VALUES ('S005', 'New Supplier', '123 Supplier St.', '1234567890', 'supplier@example.com', '1-year contract', 'High');
INSERT INTO supplier_product (supplier_id, product_id) 
VALUES ('S005', 'P003');
COMMIT;

-- Transaction 11: Remove a product from inventory
START TRANSACTION;
DELETE FROM warehouse_product 
WHERE product_id = 'P004' AND warehouse_id = 'W002';
DELETE FROM product 
WHERE product_id = 'P004';
COMMIT;

-- Transaction 12: Update product details
START TRANSACTION;
UPDATE product 
SET weight = 6.50, category = 'Updated Category', price = 200.00 
WHERE product_id = 'P002';
COMMIT;

-- Transaction 13: Add a new route
START TRANSACTION;
INSERT INTO route (route_id, distance, origin_warehouse_id, destination_warehouse_id, estimated_time, transportation_cost) 
VALUES ('R005', 300, 'W001', 'W003', 180, 500.00);
COMMIT;

-- Transaction 14: Process customs clearance
START TRANSACTION;
INSERT INTO customs_clearance (clearance_id, tax_duty, shipment_id, clearance_date, status) 
VALUES ('CC001', 500.00, 'S001', CURDATE(), 'Cleared');
COMMIT;

-- Transaction 15: Update warehouse manager
START TRANSACTION;
UPDATE warehouse 
SET manager = 'New Manager' 
WHERE warehouse_id = 'W002';
COMMIT;

-- Transaction 16: Add a new customer
START TRANSACTION;
INSERT INTO customer (customer_id, name, tax_id, contact, email, address) 
VALUES ('C005', 'New Customer', 'TAX12345', '1234567890', 'customer@example.com', '456 Customer Lane');
COMMIT;

-- Transaction 17: Cancel an order
START TRANSACTION;
UPDATE orders 
SET status = 'Cancelled' 
WHERE order_id = 'O002';
COMMIT;

-- Transaction 18: Update vehicle status
START TRANSACTION;
UPDATE transportation_vehicle 
SET status = 'Under Maintenance', maintenance_date = CURDATE() 
WHERE vehicle_id = 'V002';
COMMIT;

-- Transaction 19: Add a new driver
START TRANSACTION;
INSERT INTO driver (driver_id, license_number, name, contact, address, hire_date) 
VALUES ('D005', 'LIC12345', 'New Driver', '9876543210', '789 Driver Blvd.', CURDATE());
COMMIT;

-- Transaction 20: Adjust stock for damaged goods
START TRANSACTION;
UPDATE warehouse_product 
SET quantity = quantity - 5 
WHERE warehouse_id = 'W001' AND product_id = 'P003';
COMMIT;

-- Transaction 21: Record a payment for an order
START TRANSACTION;
INSERT INTO payment (payment_id, order_id, payment_date, payment_method, amount) 
VALUES ('P001', 'O001', CURDATE(), 'Credit Card', 1500.00);
COMMIT;

-- Transaction 22: Log vehicle maintenance
START TRANSACTION;
INSERT INTO maintenance_log (log_id, vehicle_id, maintenance_date, description, cost) 
VALUES ('ML001', 'V001', CURDATE(), 'Engine repair', 1000.00);
COMMIT;