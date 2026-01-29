-- Create database if it does not exist
CREATE DATABASE IF NOT EXISTS national_logistics_and_supply_chain;
USE national_logistics_and_supply_chain;

-- Enhanced product table with additional attributes
CREATE TABLE IF NOT EXISTS product (
  product_id VARCHAR(10) NOT NULL,
  name VARCHAR(50) NOT NULL,
  description TEXT,
  weight DECIMAL(10,2) NOT NULL,
  hs_code VARCHAR(10) NOT NULL,
  category VARCHAR(20) NOT NULL,
  storage_type VARCHAR(20) NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (product_id)
);

-- Enhanced supplier table with additional attributes
CREATE TABLE IF NOT EXISTS supplier (
  supplier_id VARCHAR(10) NOT NULL,
  name VARCHAR(50) NOT NULL,
  address TEXT,
  contact_number VARCHAR(15),
  email VARCHAR(50),
  contract_terms TEXT,
  reliability_score VARCHAR(20),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (supplier_id)
);

-- Supplier-product relationship remains the same
CREATE TABLE IF NOT EXISTS supplier_product (
  supplier_id VARCHAR(10) NOT NULL,
  product_id VARCHAR(10) NOT NULL,
  PRIMARY KEY (supplier_id, product_id),
  FOREIGN KEY (supplier_id) REFERENCES supplier (supplier_id),
  FOREIGN KEY (product_id) REFERENCES product (product_id)
);

-- Enhanced warehouse table with additional attributes
CREATE TABLE IF NOT EXISTS warehouse (
  warehouse_id VARCHAR(10) NOT NULL,
  name VARCHAR(50) NOT NULL,
  location VARCHAR(50) NOT NULL,
  capacity INT NOT NULL,
  manager VARCHAR(50),
  type VARCHAR(20) NOT NULL,
  contact VARCHAR(15),
  operational_status VARCHAR(20) DEFAULT 'Active',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (warehouse_id)
);

-- Warehouse-product relationship remains the same
CREATE TABLE IF NOT EXISTS warehouse_product (
  warehouse_id VARCHAR(10) NOT NULL,
  product_id VARCHAR(10) NOT NULL,
  quantity INT NOT NULL DEFAULT 0,
  PRIMARY KEY (warehouse_id, product_id),
  FOREIGN KEY (warehouse_id) REFERENCES warehouse (warehouse_id),
  FOREIGN KEY (product_id) REFERENCES product (product_id)
);

-- Enhanced route table with additional attributes
CREATE TABLE IF NOT EXISTS route (
  route_id VARCHAR(10) NOT NULL,
  distance INT NOT NULL,
  origin_warehouse_id VARCHAR(10) NOT NULL,
  destination_warehouse_id VARCHAR(10) NOT NULL,
  estimated_time INT NOT NULL, -- in minutes
  transportation_cost DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (route_id),
  FOREIGN KEY (origin_warehouse_id) REFERENCES warehouse (warehouse_id),
  FOREIGN KEY (destination_warehouse_id) REFERENCES warehouse (warehouse_id),
  CHECK (origin_warehouse_id <> destination_warehouse_id)
);

-- Enhanced transportation_vehicle table with additional attributes
CREATE TABLE IF NOT EXISTS transportation_vehicle (
  vehicle_id VARCHAR(10) NOT NULL,
  type VARCHAR(20) NOT NULL,
  status VARCHAR(20) NOT NULL,
  capacity DECIMAL(10,2),
  fuel_type VARCHAR(20),
  maintenance_date DATE,
  PRIMARY KEY (vehicle_id)
);

-- Enhanced driver table with additional attributes
CREATE TABLE IF NOT EXISTS driver (
  driver_id VARCHAR(10) NOT NULL,
  license_number VARCHAR(20) NOT NULL,
  name VARCHAR(50) NOT NULL,
  contact VARCHAR(15),
  address TEXT,
  hire_date DATE,
  PRIMARY KEY (driver_id)
);

-- Vehicle-driver relationship remains the same
CREATE TABLE IF NOT EXISTS vehicle_driver (
  vehicle_id VARCHAR(10) NOT NULL,
  driver_id VARCHAR(10) NOT NULL,
  assignment_date DATE NOT NULL,
  PRIMARY KEY (vehicle_id, driver_id),
  FOREIGN KEY (vehicle_id) REFERENCES transportation_vehicle (vehicle_id),
  FOREIGN KEY (driver_id) REFERENCES driver (driver_id)
);

-- Enhanced shipment table with additional attributes
CREATE TABLE IF NOT EXISTS shipment (
  shipment_id VARCHAR(10) NOT NULL,
  status VARCHAR(20) NOT NULL,
  estimated_arrival DATE,
  actual_arrival DATE,
  vehicle_id VARCHAR(10),
  route_id VARCHAR(10) NOT NULL,
  departure_time DATETIME,
  total_weight DECIMAL(10,2),
  total_cost DECIMAL(10,2),
  PRIMARY KEY (shipment_id),
  FOREIGN KEY (vehicle_id) REFERENCES transportation_vehicle (vehicle_id),
  FOREIGN KEY (route_id) REFERENCES route (route_id)
);

-- Tracking log remains the same
CREATE TABLE IF NOT EXISTS tracking_log (
  log_id VARCHAR(10) NOT NULL,
  timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  shipment_id VARCHAR(10) NOT NULL,
  location VARCHAR(50) NOT NULL,
  status VARCHAR(20) NOT NULL,
  notes TEXT,
  PRIMARY KEY (log_id),
  FOREIGN KEY (shipment_id) REFERENCES shipment (shipment_id)
);

-- Customs clearance remains the same
CREATE TABLE IF NOT EXISTS customs_clearance (
  clearance_id VARCHAR(10) NOT NULL,
  tax_duty DECIMAL(10,2) NOT NULL,
  shipment_id VARCHAR(10) NOT NULL,
  clearance_date DATE NOT NULL,
  status VARCHAR(20) NOT NULL,
  PRIMARY KEY (clearance_id),
  FOREIGN KEY (shipment_id) REFERENCES shipment (shipment_id)
);

-- Enhanced customer table with additional attributes
CREATE TABLE IF NOT EXISTS customer (
  customer_id VARCHAR(10) NOT NULL,
  name VARCHAR(50) NOT NULL,
  tax_id VARCHAR(20),
  contact VARCHAR(15),
  email VARCHAR(50),
  address TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (customer_id)
);

-- Orders table remains the same
CREATE TABLE IF NOT EXISTS orders (
  order_id VARCHAR(10) NOT NULL,
  order_date DATE NOT NULL,
  customer_id VARCHAR(10) NOT NULL,
  status VARCHAR(20) NOT NULL,
  total_amount DECIMAL(10,2),
  PRIMARY KEY (order_id),
  FOREIGN KEY (customer_id) REFERENCES customer (customer_id)
);

-- Order items remain the same
CREATE TABLE IF NOT EXISTS order_item (
  order_item_id VARCHAR(10) NOT NULL,
  quantity INT NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  product_id VARCHAR(10) NOT NULL,
  order_id VARCHAR(10) NOT NULL,
  PRIMARY KEY (order_item_id),
  FOREIGN KEY (product_id) REFERENCES product (product_id),
  FOREIGN KEY (order_id) REFERENCES orders (order_id)
);

-- Invoice table remains the same
CREATE TABLE IF NOT EXISTS invoice (
  invoice_id VARCHAR(10) NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  issue_date DATE NOT NULL,
  due_date DATE NOT NULL,
  order_id VARCHAR(10) NOT NULL,
  status VARCHAR(20) NOT NULL,
  PRIMARY KEY (invoice_id),
  FOREIGN KEY (order_id) REFERENCES orders (order_id)
);

-- Returns table remains the same
CREATE TABLE IF NOT EXISTS returns (
  return_id VARCHAR(10) NOT NULL,
  order_id VARCHAR(10) NOT NULL,
  customer_id VARCHAR(10) NOT NULL,
  return_date DATE NOT NULL,
  reason TEXT NOT NULL,
  status VARCHAR(20) NOT NULL,
  refund_amount DECIMAL(10,2),
  PRIMARY KEY (return_id),
  FOREIGN KEY (order_id) REFERENCES orders (order_id),
  FOREIGN KEY (customer_id) REFERENCES customer (customer_id)
);

-- New table: Payment details
CREATE TABLE IF NOT EXISTS payment (
  payment_id VARCHAR(10) NOT NULL,
  order_id VARCHAR(10) NOT NULL,
  payment_date DATE NOT NULL,
  payment_method VARCHAR(20) NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (payment_id),
  FOREIGN KEY (order_id) REFERENCES orders (order_id)
);

-- New table: Maintenance logs for vehicles
CREATE TABLE IF NOT EXISTS maintenance_log (
  log_id VARCHAR(10) NOT NULL,
  vehicle_id VARCHAR(10) NOT NULL,
  maintenance_date DATE NOT NULL,
  description TEXT NOT NULL,
  cost DECIMAL(10,2),
  PRIMARY KEY (log_id),
  FOREIGN KEY (vehicle_id) REFERENCES transportation_vehicle (vehicle_id)
);