-- Restore the entire database from a backup
-- Use the following command to restore the database from a full backup file
mysql -u root -p national_logistics_and_supply_chain < /path/to/backup/national_logistics_backup.sql;

-- Restore specific tables from a backup
-- Example: Restore only the 'product' and 'warehouse' tables
mysql -u root -p national_logistics_and_supply_chain < /path/to/backup/product_warehouse_backup.sql;

-- Restore database structure only (no data)
-- Example: Restore only the schema of the database
mysql -u root -p national_logistics_and_supply_chain < /path/to/backup/national_logistics_schema_backup.sql;

-- Restore database data only (no structure)
-- Example: Restore only the data of the database
mysql -u root -p national_logistics_and_supply_chain < /path/to/backup/national_logistics_data_backup.sql;

-- Example: Recover a specific table from a backup
-- If you need to recover a specific table, extract it from the backup file
-- Use the following command to extract the table from the backup
mysqldump -u root -p national_logistics_and_supply_chain product > /path/to/backup/product_table_backup.sql;

-- Restore the extracted table
mysql -u root -p national_logistics_and_supply_chain < /path/to/backup/product_table_backup.sql;