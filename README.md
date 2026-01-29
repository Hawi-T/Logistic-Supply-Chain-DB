## National Logistics and Supply Chain

This repository contains the database implementation for the **National Logistics and Supply Chain** project. It is designed to manage and optimize the operations of a logistics and supply chain system, including inventory management, warehouse operations, shipment tracking, and supplier coordination.

### Project Overview
The database is built using **Microsoft SQL Server** and **MySQL** and includes a comprehensive schema to handle various aspects of logistics and supply chain management. The project includes scripts for creating tables, views, stored procedures, triggers, and transactions, as well as scripts for data recovery and user permissions.

### Folder Structure
- **`sql_server_version/`**: Contains all SQL scripts compatible with Microsoft SQL Server.
  - **`insert_data.sql`**: Scripts to populate the database with initial data for testing and demonstration purposes.
  - **`logging.sql`**: Contains triggers and tables for logging operations and tracking changes in the database.
  - **`permision.sql`**: Scripts to create users, logins, and grant/revoke permissions for database access.
  - **`recovery.sql`**: Scripts for database recovery, including restoring backups and recovering specific tables.
  - **`select_queries.sql`**: Frequently used `SELECT` queries for retrieving data from the database.
  - **`stored_procedure.sql`**: Contains stored procedures for reusable and parameterized database operations.
  - **`transaction.sql`**: Scripts demonstrating transactional operations to ensure data consistency and integrity.
  - **`triggers.sql`**: Contains triggers for automating tasks such as logging and enforcing business rules.
  - **`views.sql`**: Scripts to create views for simplified and aggregated data retrieval.

- **`mysql_version/`**: Contains all SQL scripts compatible with MySQL.
  - **`insert_data.sql`**: Scripts to populate the database with initial data for testing and demonstration purposes.
  - **`logging.sql`**: Contains triggers and tables for logging operations and tracking changes in the database.
  - **`permision.sql`**: Scripts to create users, logins, and grant/revoke permissions for database access.
  - **`recovery.sql`**: Scripts for database recovery, including restoring backups and recovering specific tables.
  - **`select_queries.sql`**: Frequently used `SELECT` queries for retrieving data from the database.
  - **`stored_procedure.sql`**: Contains stored procedures for reusable and parameterized database operations.
  - **`transaction.sql`**: Scripts demonstrating transactional operations to ensure data consistency and integrity.
  - **`triggers.sql`**: Contains triggers for automating tasks such as logging and enforcing business rules.
  - **`views.sql`**: Scripts to create views for simplified and aggregated data retrieval.

### Getting Started
1. **Database Setup**:
   - Use the scripts in the `sql_server_version/` or `mysql_version/` folder to create and populate the database.
   - Start with the schema creation scripts (`tables.sql` if available) and then run the `insert_data.sql` script to populate the database with sample data.

2. **Permissions**:
   - Use `permision.sql` to set up user roles and permissions for accessing the database.

3. **Testing**:
   - Use `select_queries.sql` to test the database and retrieve data.
   - Run stored procedures and triggers to validate the functionality.

4. **Recovery**:
   - Use `recovery.sql` to restore the database from backups or recover specific tables.

### Expected Features
- **Comprehensive Schema**: Includes tables for products, warehouses, shipments, suppliers, customers, and more.
- **Data Integrity**: Implements transactions and triggers to ensure data consistency.
- **Logging and Auditing**: Tracks changes and operations for accountability.
- **User Roles**: Supports multiple user roles with specific permissions.
- **Reports**: Provides views for generating reports on inventory, suppliers, shipments, and more.


#### Contributors List
Below is the list of contributors to this project. The profiles and names are fetched dynamically from GitHub:

[![Contributors](https://contrib.rocks/image?repo=girmasamuel/Logistics-Supply-Chain)](https://github.com/girmasamuel/Logistics-Supply-Chain/graphs/contributors)

You can view the contributors' names and profiles by clicking the image above or visiting the [Contributors Page](https://github.com/girmasamuel/Logistics-Supply-Chain/graphs/contributors).