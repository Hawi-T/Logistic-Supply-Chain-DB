-- Backup the entire database
-- This command generates a SQL dump of the database
mysqldump -u root -p national_logistics_and_supply_chain > /path/to/backup/national_logistics_backup.sql;

-- Backup specific tables
mysqldump -u root -p national_logistics_and_supply_chain product warehouse > /path/to/backup/product_warehouse_backup.sql;

-- Backup structure only (no data)
mysqldump -u root -p --no-data national_logistics_and_supply_chain > /path/to/backup/national_logistics_schema_backup.sql;

-- Backup data only (no structure)
mysqldump -u root -p --no-create-info national_logistics_and_supply_chain > /path/to/backup/national_logistics_data_backup.sql;

